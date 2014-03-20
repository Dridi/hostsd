Name:           hostsd
Version:        %{?version}%{?!version:0}
Release:        1%{?dist}
Summary:        Service for a modular /etc/hosts
BuildArch:      noarch

License:        BSD
URL:            https://github.com/dridi/hostsd
Source0:        %{name}.tar.gz

BuildRequires:  ShellCheck
BuildRequires:  shunit2

Requires:       inotify-tools


%description
XXX


%prep
%setup -q


%build
make build


%install
rm -rf %{buildroot}

mkdir -p   %{buildroot}%{_sbindir}
cp %{name} %{buildroot}%{_sbindir}

# XXX %make_install


%check
make check


%files
# XXX %doc README
%{_sbindir}/%{name}


%changelog
