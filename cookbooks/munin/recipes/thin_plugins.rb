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
  # thin memory
  cookbook_file "/usr/share/munin/plugins/thin_memory_" do
    source "plugins/thin_memory-v1.txt"
    mode 0755
  end

  link "/etc/munin/plugins/thin_memory_" do
    to "/usr/share/munin/plugins/thin_memory_"
    notifies :restart, "service[munin-node]"
  end

  # thin threads
  cookbook_file "/usr/share/munin/plugins/thin_threads_" do
    source "plugins/thin_threads-v1.txt"
    mode 0755
  end

  link "/etc/munin/plugins/thin_threads_" do
    to "/usr/share/munin/plugins/thin_threads_"
    notifies :restart, "service[munin-node]"
  end

  # thins peak memory
  cookbook_file "/usr/share/munin/plugins/thins_peak_memory_" do
    source "plugins/thins_peak_memory-v1.txt"
    mode 0755
  end

  link "/etc/munin/plugins/thins_peak_memory_" do
    to "/usr/share/munin/plugins/thins_peak_memory_"
    notifies :restart, "service[munin-node]"
  end

end

