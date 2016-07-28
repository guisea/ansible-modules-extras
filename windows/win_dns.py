#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2016, Aaron Guise <guisea@gmail.com>
#
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: win_dns
version_added: "2.1"
short_description: Sets Windows machine DNS
description:
    - Sets machine hostname to the specified entries.
options:
  dns1:
    description:
      - The 1st DNS server to set on the machine. E.g. 10.0.1.1
    required: true
    default: null
    aliases: []

  dns2:
    description:
      - The 2nd DNS server to set on the machine. E.g. 10.0.1.1
    required: true
    default: null
    aliases: []
author: Aaron Guise
'''


EXAMPLES = '''
  # Set machine's dns to Google DNS
  win_dns:
    dns1: 8.8.8.8
    dns2: 8.8.4.4
'''

RETURN = '''# '''
