#
# Cookbook Name:: munin
# Recipe:: redisplugin
#
# Copyright 2010, afistfulofservers
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

include_recipe "munin::client"
munin_servers = search(:node, "munin_server:true")

unless munin_servers.empty?
  package "perl-DBD-Pg"

#  postgresql_user "munin" do
#    action :create
#    provider "postgresql90_user"
#  end

  execute "enable munin postgresql plugins" do
    not_if "ls /etc/munin/plugins/postgres*"
    #command "munin-node-configure --shell | grep postgres > /tmp/munin-postgres-commands ; . /tmp/munin-postgres-commands"
    command "munin-node-configure --shell | grep postgres | sh"

    notifies :restart, "service[munin-node]"
  end
end
