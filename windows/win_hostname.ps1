#!powershell
# This file is part of Ansible
#
# Copyright 2016, Aaron Guise <guisea@gmail.com>
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

# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args;

$result = New-Object psobject @{
    output = $false
    changed = $false
}

$hostname = Get-Attr -obj $params -name name -failifempty $true -resultobj $result
$existingHostname = $(hostname)



Try {
    If ($hostname -ne $existingHostname){
       # Hostname needs to be changed
       $rc = Rename-Computer -NewName $hostname -PassThru
       If ( $rc.HasSucceeded -eq $true )
       {
            $result.msg = "Changed Hostname successfully. Effective after restart.";
            $result.changed = $true;
       }
        $result.output = $rc
    }
    If ( $existingHostname -eq $hostname ) {
        $result.output = "Machine is already named $hostname";
    }
    }
Catch {
    Fail-Json $result "Error setting hostname to: $hostname."
}
Exit-Json $result;

