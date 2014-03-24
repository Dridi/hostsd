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
BuildRequires:  systemd

Requires:       inotify-tools

%systemd_requires


%description
With hostsd, it becomes possible to modularize the monolithic /etc/hosts file.

Put your hosts fragments in /etc/hosts.d, let hostsd monitor them and update
/etc/hosts for you.


%prep
%setup -q


%build
make build docs


%install
rm -rf %{buildroot}
%make_install prefix=%{_prefix}


%check
make check


%files
%doc LICENSE README.html
%{_sbindir}/%{name}
%{_mandir}/man8/%{name}.8*
%{_unitdir}/%{name}.service


%post
%systemd_post %{name}.service


%preun
%systemd_preun %{name}.service


%postun
%systemd_postun_with_restart %{name}.service


%changelog
* Tue Mar 25 2014 Dridi Boukelmoune <dridi.boukelmoune[at]gmail.com> 0.1-1
- Initial spec
