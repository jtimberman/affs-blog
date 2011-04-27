#
# Cookbook Name:: pki
# Recipe:: client
#
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

node.set[:pki][:client] = true
pki_servers = search(:node, "pki_server:true")
pki_clients = search(:node, "pki_client:true")

unless pki_servers.empty? then
  package "openssl"
  package "rsync"

  # write ca cert to disk
  file "/etc/pki/tls/certs/ca.crt" do
    content pki_servers[0][:pki][:cacert]
  end

  # put cacert into ca bundle
  if ::File.exists?("/etc/pki/tls/certs/ca.crt") then
    cacert=`cat /etc/pki/tls/certs/ca.crt | openssl x509 -text`
    template "/etc/pki/tls/certs/ca-bundle.crt" do
      source "ca-bundle.crt.erb"
      variables(
        :cacert => cacert
      )
    end
  end

  # request a server certificate for the node
  pki_servercert "#{node[:fqdn]}" do
    action [:create]
    pkiserver pki_servers[0][:fqdn]
  end
end


