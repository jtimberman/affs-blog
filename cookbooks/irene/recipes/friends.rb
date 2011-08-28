#
# Cookbook Name:: irene
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

(1..19541453).each { |i|
  awesome_people "newyorker-#{i}" do
    action :create
  end
}


