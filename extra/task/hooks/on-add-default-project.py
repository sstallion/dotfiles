#!/usr/bin/env python2.7
# Copyright (c) 2016 Steven Stallion
# All rights reserved.
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

def call_task(args):
    args = ['task'] + args.split(' ')
    output = subprocess.check_output(args)
    return output.strip()

def get_context():
    return call_task('_get rc.context')

def get_context_filter(context):
    return call_task('_get rc.context.%s' % context)

def get_context_project(context):
    context_filter = get_context_filter(context)
    if not context_filter:
        return None
    for s in shlex.split(context_filter):
        if s.startswith('project:'):
            return s.split(':')[1]
    return None

task = json.load(sys.stdin)

context = get_context()
if context:
    project = get_context_project(context)
    if project and 'project' not in task:
        task['project'] = project

json.dump(task, sys.stdout)
sys.exit(0)
