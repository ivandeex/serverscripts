#!/usr/bin/perl
#
# $Id: migrate_profile.pl,v 1.2 2001/01/07 22:31:46 lukeh Exp $
#
# Copyright (c) 2001 Luke Howard.
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
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by Luke Howard.
# 4. The name of the other may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE LUKE HOWARD ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL LUKE HOWARD BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
#
# LDIF entries for base DN
#
#

require '/usr/share/openldap/migration/migrate_common.ph';

$PROGRAM = "migrate_profile.pl";

sub gen_profile
{
	print "dn: cn=config,$DEFAULT_BASE\n";
	print "cn: config\n";
	print "objectClass: DUAConfigProfile\n";
	print "objectClass: posixNamingProfile\n";
	print "defaultServerList: $LDAPHOST\n";
	print "defaultSearchBase: $DEFAULT_BASE\n";
	print "defaultSearchScope: one\n";

	foreach $_ (keys %NAMINGCONTEXT) {
		if (!/_/) {
			print "serviceSearchDescriptor: $_:$NAMINGCONTEXT{$_},$DEFAULT_BASE\n";
		}
	}
	print "\n";
}

sub main
{
	if ($#ARGV < 0) {
		print STDERR "Usage: $PROGRAM ldaphost\n";
		exit 1;
	}

	$LDAPHOST = $ARGV[0];
	&gen_profile();
}

&main;

