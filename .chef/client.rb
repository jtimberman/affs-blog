log_level          :info
log_location       STDOUT
ssl_verify_mode    :verify_none
chef_server_url    "http://y.t.b.d:4000"
file_cache_path    "/var/cache/chef"
pid_file           "/var/run/chef/client.pid"
cache_options({ :path => "/var/cache/chef/checksums", :skip_expires => true})
signing_ca_user "chef"
Mixlib::Log::Formatter.show_time = true
validation_client_name "chef-validator"
validation_key         "/etc/chef/validation.pem"
client_key             "/etc/chef/client.pem"
