#
# Cookbook Name:: munin
# Recipe:: default
#
# Copyright 2010-2011, afistfulofservers
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

include_recipe "munin::client"
munin_servers = search(:node, "munin_server:true")

unless munin_servers.empty?
  package "perl-Cache-Memcached"

  link "/etc/munin/plugins/memcached_rates" do
    to "/usr/share/munin/plugins/memcached_"
    notifies :restart, "service[munin-node]"
  end

  link "/etc/munin/plugins/memcached_bytes" do
    to "/usr/share/munin/plugins/memcached_"
    notifies :restart, "service[munin-node]"
  end

  link "/etc/munin/plugins/memcached_counters" do
    to "/usr/share/munin/plugins/memcached_"
    notifies :restart, "service[munin-node]"
  end

  link "/etc/munin/plugins/memcached_counters" do
    to "/usr/share/munin/plugins/memcached_"
    notifies :restart, "service[munin-node]"
  end
end
