#
# Cookbook Name:: irene
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

(1..48).each { |i|
  bottles_of_water "bottle--#{i}" do
    action :create
  end
}

(1..5).each { |i|
  jugs_of_water "jug-#{i}" do
    action :creat
  end
}

