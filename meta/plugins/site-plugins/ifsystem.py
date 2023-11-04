# Copyright (c) 2023 Steven Stallion <sstallion@gmail.com>
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
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS "AS IS" AND
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

import os
import platform

import dotbot
from dotbot.dispatcher import Dispatcher
from dotbot.plugin import Plugin


def _check_os(name):
    return lambda: os.name == name


def _check_platform(name):
    return lambda: platform.system() == name


def _check_linux(path):
    return lambda: platform.system() == 'Linux' and os.path.exists(path)


class IfSystem(dotbot.Plugin):
    """Execute directives if system matches"""

    # Only consider os.name and a subset of platform.system(). Values chosen
    # reflect a "best guess" of which OSes are being used with dotbot as it is
    # not possible to determine every possible value `uname -s` may emit.
    _directives = {
        'ifposix':     _check_os('posix'),
        'ifdragonfly': _check_platform('Dragonfly'),
        'iffreebsd':   _check_platform('FreeBSD'),
        'ifjava':      _check_platform('Java'),
        'iflinux':     _check_platform('Linux'),
        'ifmacos':     _check_platform('Darwin'),
        'ifmidnight':  _check_platform('MidnightBSD'),
        'ifnetbsd':    _check_platform('NetBSD'),
        'ifopenbsd':   _check_platform('OpenBSD'),
        'ifsunos':     _check_platform('SunOS'),
        'ifwindows':   _check_platform('Windows'),
        'ifdebian':    _check_linux('/etc/debian_version'),
        'ifgentoo':    _check_linux('/etc/gentoo-release'),
        'ifredhat':    _check_linux('/etc/redhat-release')
    }

    def __init__(self, context):
        super(IfSystem, self).__init__(context)

    def can_handle(self, directive):
        return directive in self._directives

    def handle(self, directive, data):
        if directive not in self._directives:
            raise ValueError(f'IfSystem cannot handle directive {directive}')
        return self._process_system(self._directives[directive], data)

    def _process_system(self, check_system, data):
        return not check_system() or self._dispatch(data)

    def _dispatch(self, data):
        # We monkey patch Dispatcher._setup_context to inject the correct
        # context into new plugin instances, otherwise defaults are lost.
        def _setup_context(subself, base_directory, options):
            subself._context = self._context
        Dispatcher._setup_context = _setup_context
        dispatcher = Dispatcher(self._context.base_directory(),
                                only=self._context.options().only,
                                skip=self._context.options().skip,
                                options=self._context.options(),
                                plugins=Plugin.__subclasses__())
        return dispatcher.dispatch(data)
