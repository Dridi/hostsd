.. hostsd - Hosts file updater daemon

   Copyright (C) 2014, Dridi Boukelmoune <dridi.boukelmoune@gmail.com>
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:

   1. Redistributions of source code must retain the above
      copyright notice, this list of conditions and the following
      disclaimer.
   2. Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials
      provided with the distribution.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
   FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
   COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
   STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
   OF THE POSSIBILITY OF SUCH DAMAGE.

======
hostsd
======

-------------------------
Hosts file updater daemon
-------------------------

:Author: Written by Dridi Boukelmoune
:Version: 0.1
:Manual section: 8

SYNOPSIS
========

**hostsd** [-d *HOSTSD_DIR*] [-f *HOSTS_FILE*] [-p *PIDFILE*]

**hostsd** -h

DESCRIPTION
===========

With hostsd, it becomes possible to modularize the monolithic /etc/hosts file.
Put your hosts fragments in /etc/hosts.d, let hostsd monitor them and update
/etc/hosts for you.

The hostsd program isn't actually a **daemon**\ (3). It won't detach itself
from its terminal and run in the background. It is meant to run as a service,
and the init system should handle this behaviour.

OPTIONS
=======

.. |defaults| replace::

   but is not meant to be changed. It exists mainly for testing purposes but
   could prove useful to modularize /etc/hosts in a **chroot**\ (1) environment.

**-d** *HOSTSD_DIR*
   The drop-in directory to watch. HOSTSD_DIR defaults to /etc/hosts.d
   |defaults|

**-f** *HOSTS_FILE*
   The hosts file to modularize. HOSTS_FILE defaults to /etc/hosts |defaults|

**-h**
   Displays hostsd's usage summary and exits.

**-p** *PIDFILE*
   Write the process's PID to the specified file. PIDFILE defaults to
   /var/run/hostsd.pid |defaults|

SEE ALSO
========

**hosts**\ (5)
