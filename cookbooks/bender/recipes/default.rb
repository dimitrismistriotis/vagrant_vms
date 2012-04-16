# -*- mode: ruby -*-
# vi: set ft=ruby :

gem_package "ruby-shadow" do
  action :install
  ignore_failure true
end

user "selav" do
	username "selav"
	uid 10001
	home "/home/sela"
	shell "/bin/zsh"
	supports ":manage_home => true, :non_unique => false"
	password "$6$7P47CdugmRaGsDi$p1zb2yAnlRRe8mUN0RVK/Q5/gb5Fy4QW2MuRFU/SF2i6zfQTusfhAPb2.OyhN/oKit3i9y0rV4xB654SRuooe1"
end

user "dimitry" do
	username "dimitry"
	uid 10000
	home "/home/dimitry"
	shell "/bin/zsh"
	supports :manage_home => true
	password "$6$BeA/.Ry.Fo$05J6KLN2AO2Mk7RN2YGiibAkNM73gSqSTPoVwdt3RYVU6URI6FVrtIslImtBaolkx2JNRxsSWkKlsJUSChs0i1"	
end

directory "/home/dimitry" do
  owner "dimitry"
  group "dimitry"
  mode "0755"
  recursive true
  action :create
end

directory "/home/selav" do
  owner "selav"
  group "selav"
  mode "0755"
  recursive true
  action :create
end
::Chef::Resource::Package.send(:include, AnotherOhMyZsh)

AnotherOhMyZsh.dl_oh_my_and_create_rc_files

cron "update_rubygems" do
  command "gem update"
  user "root"
  hour 5
  weekday 0
end

### Packages

package "mkpasswd" do
	action :install
end

package "vim" do
	action :install
end

#### Groups

group "www-data" do
	members ['selav', 'dimitry']
	append true
end
