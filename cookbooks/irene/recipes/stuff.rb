#
# Cookbook Name:: irene
# Recipe:: stuff
#
# Copyright 2011, afistfulofservers
# MIT license

(1..4).each { |i|
  flashlight "flashlight-#{i}" do
    action :create
  end
}

(1..3).each { |i|
  fully_charged_laptops "laptop-#{i}" do
    action :create
  end
}

(1..2).each { |i|
 cellphones "phone-#{i}" do
   action :create
 end
}

backpack "backpack-#{i}" do
   action :create
end

