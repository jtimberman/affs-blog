#
# Cookbook Name:: irene
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

(1..5).each { |i|
  wine_bottles "wine_bottle-#{i}" do
    action :create
  end
}

99.downto(1).each { |i|
  bottles_of_beer "beer_bottle-#{i}" do
    action [:take_down, :pass_around]
    not_if { ::Beer.kind_of?(PBR) }
  end
}

(1..1).each { |i|
  kegs_of_beer "keg-#{i}" do
    brand "twobrothers"
    action [:tap, :empty]
  end
}

(1..2).each { |i|
  bottles_of_whiskey "whiskey-#{i}" do
    type "fancy"
    action [:serve_neat, :drink]
  end
}


