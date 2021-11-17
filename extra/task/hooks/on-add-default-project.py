#!/usr/bin/env python3
# Copyright (C) 2021 Steven Stallion <sstallion@gmail.com>
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

import json
import shlex
import subprocess
import sys


def run_task(args):
    process = subprocess.run(['task'] + shlex.split(args),
                             capture_output=True, check=True, text=True)
    return process.stdout.strip()


def get_context():
    return run_task('_get rc.context')


def get_context_filter(context):
    return run_task('_get rc.context.%s' % context)


def get_project(context):
    context_filter = get_context_filter(context)
    if not context_filter:
        return None
    for s in shlex.split(context_filter):
        if s.startswith('project:'):
            return s.split(':')[-1]
    return None


if __name__ == '__main__':
    task = json.load(sys.stdin)

    context = get_context()
    if context:
        project = get_project(context)
        if project and 'project' not in task:
            task['project'] = project

    json.dump(task, sys.stdout)
    sys.exit(0)
