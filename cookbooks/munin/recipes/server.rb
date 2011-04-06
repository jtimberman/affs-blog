#
# Cookbook Name:: munin
# Recipe:: server
#
# Copyright 2010, Opscode, Inc.
# Copyright 2011, afistfulofservers
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set[:munin][:server] = true
munin_clients = search(:node, "munin_client:true")

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "munin::client"

package "munin"

cookbook_file "/etc/cron.d/munin" do
  source "munin-cron"
  mode "0644"
  owner "root"
  group "root"
  backup 0
end

template "/etc/munin/munin.conf" do
  source "munin.conf.erb"
  mode 0644
  backup false
  variables(:munin_clients => munin_clients)
end

apache_site "000-default" do
  enable false
end

case node[:platform]
when "fedora", "redhat", "centos", "scientific"
  file "/var/www/html/munin/.htaccess" do
    action [:delete]
  end
end

template "#{node[:apache][:dir]}/sites-available/munin.conf" do
  source "localsystem.apache2.conf.erb"
  mode 0644
  backup false
  if ::File.symlink?("#{node[:apache][:dir]}/sites-enabled/munin.conf")
    notifies :reload, resources(:service => "apache2")
  end
end

apache_site "munin.conf"

