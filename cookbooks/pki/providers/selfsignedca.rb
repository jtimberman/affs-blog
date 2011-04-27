action :create do
  ca_name="#{new_resource.name}".upcase

  # create CA index
  unless ::File.exists?("/etc/pki/#{ca_name}/index.txt")
    log "creating PKI index file" 
    system("touch /etc/pki/#{ca_name}/index.txt")
  end

  # create CA serial
  unless ::File.exists?("/etc/pki/#{ca_name}/serial")
    log "starting PKI serial file"
    system("echo '01' > /etc/pki/#{ca_name}/serial")
  end

  # create CA crlnumber
  unless ::File.exists?("/etc/pki/#{ca_name}/certs/ca.srl")
    log "starting crlnumber" 
    system("echo '01' > /etc/pki/#{ca_name}/certs/ca.srl")
  end

  # generate self signed key
  unless ::File.exists?("/etc/pki/#{ca_name}/private/ca.key")
    unless ::File.exists?("/etc/pki/#{ca_name}/certs/ca.crt")
      log "generating CA private key" 
      cmd = "openssl req"
      cmd += " -x509"
      cmd += " -nodes" 
      cmd += " -days 3650"
      cmd += " -subj '/CN=#{node[:fqdn]}/'"
      cmd += " -newkey rsa:2048"
      cmd += " -keyout /etc/pki/#{ca_name}/private/ca.key"
      cmd += " -out /etc/pki/#{ca_name}/certs/ca.crt"
      cmd += " 2>&1>/dev/null"
      system(cmd)
    end
  end

  if ::File.exists?("/etc/pki/#{ca_name}/certs/ca.crt") then
    node.set[:pki][:cacert] = IO.read("/etc/pki/#{ca_name}/certs/ca.crt")
  end
end

