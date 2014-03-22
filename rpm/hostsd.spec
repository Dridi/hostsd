Name:           hostsd
Version:        %{?version}%{?!version:0}
Release:        1%{?dist}
Summary:        Hosts file updater daemon
BuildArch:      noarch

License:        BSD
URL:            https://github.com/dridi/hostsd
Source0:        %{name}.tar.gz

BuildRequires:  ShellCheck
BuildRequires:  python-docutils
BuildRequires:  shunit2

Requires:       inotify-tools


%description
With hostsd, it becomes possible to modularize the monolithic /etc/hosts file.

Put your hosts fragments in /etc/hosts.d, let hostsd monitor them and update
/etc/hosts for you.


%prep
%setup -q


%build
make build man


%install
rm -rf %{buildroot}
%make_install prefix=%{_prefix}


%check
make check


%files
# XXX %doc README
%{_sbindir}/%{name}
%{_mandir}/man8/%{name}.8*


%changelog
