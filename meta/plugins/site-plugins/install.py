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

import ctypes
import os

import dotbot
from dotbot.dispatcher import Dispatcher
from dotbot.plugin import Plugin


def _is_superuser():
    return os.name == 'posix' and os.getuid() == 0 or \
           os.name == 'nt' and ctypes.windll.shell32.IsUserAnAdmin() != 0


class Install(dotbot.Plugin):
    """Execute install directives if running as superuser"""
    _directives = ['config', 'install']

    def __init__(self, context):
        super(Install, self).__init__(context)

    def can_handle(self, directive):
        return directive in self._directives

    def handle(self, directive, data):
        if directive not in self._directives:
            raise ValueError(f'Install cannot handle directive {directive}')
        return directive == 'config' and self._process_config(data) or \
               directive == 'install' and self._process_install(data)

    def _process_config(self, data):
        return _is_superuser() or self._dispatch(data)

    def _process_install(self, data):
        return not _is_superuser() or self._dispatch(data)

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
