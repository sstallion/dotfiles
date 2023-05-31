#!/usr/bin/env python3
# Copyright (C) 2019 Steven Stallion <sstallion@gmail.com>
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
import sys
from datetime import datetime, time

from pytz import utc
from tzlocal import get_localzone

TIME_FORMAT = '%Y%m%dT%H%M%SZ'

DEFAULT_TIME = time(0, 0, 0)    # sod
REPLACE_TIME = time(23, 59, 59) # eod


def get_due_date(task):
    dt = datetime.strptime(task['due'], TIME_FORMAT)
    return utc.localize(dt).astimezone(get_localzone())


def replace_due_date(task, dt):
    dt = dt.replace(hour=REPLACE_TIME.hour,
                    minute=REPLACE_TIME.minute,
                    second=REPLACE_TIME.second)
    dt = dt.astimezone(utc)
    task['due'] = dt.strftime(TIME_FORMAT)


if __name__ == '__main__':
    task = json.load(sys.stdin)

    if 'due' in task:
        dt = get_due_date(task)
        if dt.time() == DEFAULT_TIME:
            replace_due_date(task, dt)

    json.dump(task, sys.stdout)
    sys.exit(0)
