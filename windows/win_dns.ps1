#!powershell
# This file is part of Ansible
#
# Copyright 2015, Phil Schwartz <schwartzmx@gmail.com>
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
    output = "No changes needed"
    changed = $false
}

$dns1 = Get-Attr -obj $params -name dns1 -failifempty $true -resultobj $result
$dns2 = Get-Attr -obj $params -name dns2 -failifempty $true -resultobj $result

$result.dns1 = $dns1
$result.dns2 = $dns2


Try {
    # Get current DNS Server details for Ethernet
    $dnsAddresses = Get-DnsClientServerAddress -InterfaceAlias 'Ethernet' | Select-Object -ExpandProperty ServerAddresses
	$currentDns1 = $dnsAddresses[0]
	$currentDns2 = $dnsAddresses[1]
	
	If ( $dns1 -ne $currentDns1 -and $dns2 -ne $currentDns2 )
	{
		# The DNS does not match
		Set-DnsClientServerAddress -InterfaceAlias 'Ethernet' -ServerAddresses ( $dns1 , $dns2 ) # Set the DNS Entry
		$dnsAddresses = Get-DnsClientServerAddress -InterfaceAlias 'Ethernet' | Select-Object -ExpandProperty ServerAddresses # Select them again
		$currentDns1 = $dnsAddresses[0]
		$currentDns2 = $dnsAddresses[1]
		# Compare the results again
		If ( $dns1 -eq $currentDns1 -and $dns2 -eq $currentDns2 )
		{
		    $result.output = "Updated DNS Servers."
			$result.changed = $true
		}
	}
}
Catch {
    Fail-Json $result
}
Exit-Json $result;

