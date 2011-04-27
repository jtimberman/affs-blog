################################################################################
action :create do
  # If no key
  unless ::File.exists?("/etc/pki/tls/private/#{new_resource.name}.key")
    log "creating cervercert private key for #{new_resource.name}"
    system("openssl genrsa -out /etc/pki/tls/private/#{new_resource.name}.key 2048")
  end

  # If key but no cert, generate CSR
  unless ::File.exists?("/etc/pki/tls/private/#{new_resource.name}.csr")
    if ::File.exists?("/etc/pki/tls/private/#{new_resource.name}.key")
      log "generating certificate request"
      cmd = "openssl req"
      cmd += " -new"
      cmd += " -nodes"
      cmd += " -subj '/CN=#{new_resource.name}/'"
      cmd += " -key /etc/pki/tls/private/#{new_resource.name}.key"
      cmd += " -out /etc/pki/tls/private/#{new_resource.name}.csr"
      system(cmd)
    end
  end

  # put CSR into attribute
  unless ::File.exists?("/etc/pki/tls/certs/#{new_resource.name}.crt") then
    if ::File.exists?("/etc/pki/tls/private/#{new_resource.name}.key") then
      if ::File.exists?("/etc/pki/tls/private/#{new_resource.name}.csr") then
        node.set[:pki][:csr][:"#{new_resource.name}"] = IO.read("/etc/pki/tls/private/#{new_resource.name}.csr")
        log "rsyncing certificate #{new_resource.name}.crt from pki"
        system("rsync #{new_resource.pkiserver}::pki/#{new_resource.name}.crt /etc/pki/tls/certs/")
      end
    end
  end 

  # retract CSR node attribute to prevent server from acting on it
  if ::File.exists?("/etc/pki/tls/certs/#{new_resource.name}.crt") then
    #node[:pki][:csr][:"#{new_resource.name}"]
    puts "I wish I could delete this node attribute"
    new_resource.updated_by_last_action(true)
  end
end
