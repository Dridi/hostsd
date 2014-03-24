==================================
hostsd - Hosts file updater daemon
==================================

hostsd is a :code:`/etc/hosts` file updater daemon. It allows you to add
modularity to the famous *static table lookup for hostnames*. The design is
dead-simple, it's just a program that listens to modifications in
:code:`/etc/hosts.d` and recreates a brand new :code:`/etc/hosts` file whenever
it is notified of changes.

Install
=======

.. code:: bash

   # tested only on Fedora so far
   git clone https://github.com/dridi/hostsd.git
   cd hostsd
   make rpm
   sudo yum install ./hostsd-*.noarch.rpm

History
=======

This is not a serious project. It was written as a one-week self-hackathon
almost exclusively in public transportation (mostly to and from work). The main
driver was curiosity: can you write a project in shell, with a full-blown build
system including packaging and tests ?

Answer seems to be yes.

While this was interesting, because unsurprisingly you can learn stuff even
with a stupid toy project, it was still born from a real frustration: the lack
of composition (through a drop-in directory) for :code:`/etc/hosts`. If you
think this is useful, send feedback and I'll maintain it and probably rewrite
it in a more relevant language (even though I really like the idea of a shell
daemon=).

How it works
============

Start the hostsd service, put files in :code:`/etc/hosts.d`, and hope that none
of your programs are caching :code:`/etc/hosts`. hostsd will only use files in
:code:`/etc/hosts.d`, it won't look inside sub-directories.

Known issues
============

In its current state, the service doesn't watch :code:`/etc/hosts`, it will
only update it if something happens inside :code:`/etc/hosts.d`. I haven't
figured out how I want to handle this yet.

hostsd will catch irrelevant events in :code:`/etc/hosts.d`, it should instead
watch what's really needed to avoid spurious updates of :code:`/etc/hosts`.

It currently works only on Linux (because it relies on inotifywait) with
systemd on an RPM-based distribution. If you want to see hostsd support your
favourite stack, open an `issue <https://github.com/dridi/hostsd/issues>`_ on
`github <https://github.com/dridi/hostsd>`_.
