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
import re

import dotbot
from dotbot.dispatcher import Dispatcher
from dotbot.plugin import Plugin

# Only consider os.name and a subset of platform.system(). Values chosen below
# reflect a "best guess" of which OSes are being used with dotbot as it is not
# possible to determine every possible value `uname -s` may emit a priori.
_names = ['nt', 'posix']
_systems = [
    'Darwin',
    'Dragonfly',
    'FreeBSD',
    'Java',
    'Linux',
    'MidnightBSD',
    'NetBSD',
    'OpenBSD',
    'SunOS',
    'Windows'
]


class IfSystem(dotbot.Plugin):
    """Execute directives if system matches"""

    def __init__(self, context):
        super(IfSystem, self).__init__(context)
        self._directives = [f'if{val.lower()}' for val in _names + _systems]

    def can_handle(self, directive):
        return directive in self._directives

    def handle(self, directive, data):
        if directive not in self._directives:
            raise ValueError(f'IfSystem cannot handle directive {directive}')
        val = re.sub('^if', '', directive)
        if val == os.name or val == platform.system().lower():
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
        return True
