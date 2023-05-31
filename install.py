#!/usr/bin/env python3
# Copyright (C) 2023 Steven Stallion <sstallion@gmail.com>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

import argparse
import importlib.util
import inspect
import logging
import os
import pathlib
import platform
import shlex
import subprocess
import sys

logger = logging.getLogger(__name__)


# Mimic colors used by dotbot for each logging level:
class ColorFilter(logging.Filter):
    COLORS = {
        logging.CRITICAL: '\033[91m',
        logging.ERROR:    '\033[91m',
        logging.WARNING:  '\033[95m',
        logging.INFO:     '\033[92m',
        logging.DEBUG:    '\033[93m',
        logging.NOTSET:   '\033[0m'
    }

    def __init__(self, enabled=None):
        self._enabled = os.isatty(sys.stdout.fileno()) if enabled is None else enabled

    def color(self, levelno):
        return ColorFilter.COLORS[levelno] if self._enabled else ''

    def filter(self, record):
        record.color = self.color(record.levelno)
        record.reset = self.color(logging.NOTSET)
        return True


def check_call(*args, **kwargs):
    logger.debug(f'Calling {args}')
    try:
        return subprocess.check_call(args, **kwargs)
    except (Exception, KeyboardInterrupt) as e:
        logger.error(e)
        sys.exit(1)


def check_path(path):
    if not path.exists():
        logger.error(f'Nonexistent path {path}')
        sys.exit(1)
    return path


def dotbot(*args, **kwargs):
    args = [sys.executable, '-m', 'dotbot', '--base-directory', kwargs['basedir'], *args]

    plugindir = kwargs['basedir'] / 'meta' / 'plugins'
    for dir in filter(lambda path: path.is_dir(), plugindir.iterdir()):
        args.extend(['--plugin-dir', dir])

    if kwargs['color'] is not None:
        args.append('--force-color' if kwargs['color'] else '--no-color')

    if kwargs['exit_on_failure']:
        args.append('--exit-on-failure')

    check_call(*args)


def main():
    parser = argparse.ArgumentParser(
        epilog='Report issues to https://github.com/sstallion/dotfiles/issues.')

    parser.add_argument('-v', '--verbose', action='store_true',
                        help='increase output verbosity')

    parser.add_argument('-d', '--base-directory', metavar='BASEDIR', dest='basedir',
                        default=pathlib.Path(__file__).absolute().parent, type=pathlib.Path,
                        help='execute commands from within BASEDIR')

    parser.add_argument('-c', '--config-file', metavar='CONFIGFILE', dest='configfile',
                        type=pathlib.Path,
                        help='run commands given in CONFIGFILE')

    parser.add_argument('--force-color', action='store_true', default=None, dest='color',
                        help='force color output')

    parser.add_argument('--no-color', action='store_false', default=None, dest='color',
                        help='disable color output')

    parser.add_argument('--no-clean', action='store_false', dest='clean',
                        help='disable cleaning broken symbolic links')

    parser.add_argument('-x', '--exit-on-failure', action='store_true',
                        help='exit after first failed directive')

    parser.add_argument('profiles', nargs='*', default=['default'],
                        help='run commands for listed config files')

    args = parser.parse_args()

    # It is 2023 and Windows still does not support high intensity ANSI colors
    # reliably. This is why we cannot have nice things.
    if platform.system() == 'Windows':
        args.color = False

    logging.basicConfig(format='%(color)s%(message)s%(reset)s',
                        level=logging.INFO, stream=sys.stdout)
    logger.addFilter(ColorFilter(args.color))
    if args.verbose:
        logger.setLevel(logging.DEBUG)

    # Update submodules prior to calling dotbot:
    if (args.basedir / '.gitmodules').exists():
        logger.info('Updating submodules')
        check_call('git', '-C', args.basedir, 'submodule', 'update', '--init', '--recursive')

    # Install dotbot to user install directory if module cannot be found:
    if importlib.util.find_spec('dotbot') is None:
        logger.info('Installing dotbot')
        check_call(sys.executable, '-m', 'pip', 'install', '--user', 'dotbot')

    # Config files may be specified directly using the --config-file argument
    # or indirectly by specifying profiles. Profiles specify the stem of one
    # or more config files, one per line.
    def configure(configfile, message=None):
        if message is None:
            message = f'Configuring {configfile.stem}'
        logger.info(f'\n{message}')
        dotbot('--config-file', configfile, **vars(args))

    if args.configfile is not None:
        configure(args.configfile)
    else:
        configdir = args.basedir / 'meta' / 'configs'
        profiledir = args.basedir / 'meta' / 'profiles'
        for path in [check_path(profiledir / profile) for profile in args.profiles]:
            with path.open() as f:
                for config in f.read().splitlines():
                    configure(configdir / f'{config}.yaml')

    if args.clean:
        configfile = args.basedir / 'meta' / 'clean.yaml'
        configure(configfile, 'Cleaning broken symbolic links')

if __name__ == '__main__':
    main()
