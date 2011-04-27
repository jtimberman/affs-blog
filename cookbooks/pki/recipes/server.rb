#
# Cookbook Name:: pki
# Recipe:: server
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

######
# Clients check to see if they have a certificate for their FQDN.
# If not, a resource provider is called that generates a private key and a CSR.
# The node then sets a node attribute with the CSR as its value
#
# When the server side runs, it searches for a list of clients with the attribute
# set. When it finds a certificate request, it will automatically sign it and place
# the resulting certificate in a directory that is exposed via rsync. Since these
# are public keys, there are no security concerns here.
#
# When a client is satisfied about its certificate, it will remove the attribute.
# 
# When the ca certificate has been deleted, the clients will re-key
#
# -s

node.set[:pki][:server] = true
pki_servers = search(:node, "pki_server:true")
pki_clients = search(:node, "pki_client:true")

################################################################################

# Nodes come up and "negotiate" for master.
pki_masters = search(:node, "pki_master:true")
if pki_masters.empty? then
  node.set[:pki][:master] = true
end


# Common packages
package "openssl"
package "rsync"
package "xinetd"

### Do master stuff
if node[:pki][:master] then

  # create CA if one does not exist
  pki_selfsignedca "ca" do
    action [:create]
  end

  # make a directory to place requests in
  directory "/etc/pki/CA/requests" do
    action [:create]
    mode 0700
  end

  # process requests
  needy_nodes = search(:node, "pki_csr:[* TO *]" )
  unless needy_nodes.empty? then
    needy_nodes.each do |needy_node|
      needy_node[:pki][:csr].keys.each do |key| 

        # write the CSR to disk
        file "/etc/pki/CA/requests/#{key}.csr" do
          content needy_node[:pki][:csr][:"#{key}"]
        end
        
        # sign the request and place it into data dir
        cmd = "openssl x509"
        cmd += " -req"
        cmd += " -CA /etc/pki/CA/certs/ca.crt"
        cmd += " -CAkey /etc/pki/CA/private/ca.key"
        cmd += " -in /etc/pki/CA/requests/#{key}.csr"
        cmd += " -out /etc/pki/CA/certs/#{key}.crt"
        system(cmd) 
      end
    end
  end

  # rsync xinetd configuration
  template "/etc/xinetd.d/rsync" do
    source "rsync.xinetd.erb"
    notifies :restart, "service[xinetd]"
  end

  # rsyncd config
  template "/etc/rsyncd.conf" do
    source "rsyncd.conf.erb"
  end

  # ensure xinetd is running
  service "xinetd" do
    action[:enable,:start]
  end

end

### Do non-master stuff
unless node[:pki][:master] then
  # implement copy from master logic here

  service "xinetd" do
    action[:disable,:stop]
  end
end

