#
# Cookbook Name:: irene
# Recipe:: default
#
# Copyright 2011, afistfulofservers
# MIT license

(1..2).each { |i|
  brisket "brisket-#{i}" do
    pounds "3"
    action :create
  end
}

(1..5).each { |i|
  bbq_leftover_parishables "bbq_leftover_parishable-#{i}" do
    oz "48"
    action :create
  end
}

(1..3).each { |i|
  packs_of_buns "packs_of_buns-#{i}" do
    action :create
  end
}

(1..3).each { |i|
  package_of_nuts "nuts-#{i}" do
    oz "9"
    action :create
  end
}

(1..2).each { |i|
  powerbar_box "powerbar_box-#{i}" do
    oz "9"
    action :create
  end
}

rice_crispy_treats "rice_crispy_treats" do
  bars "16"
  action :create
end

box_o_cookies "box_o_cookies" do
  action :create
end

(1..3).each { |i|
  pulltop_corn_can "pulltop_corn_can-#{i}" do
    oz "15.25"
    action :create
  end
}

(1..5).each { |i|
  can_of_beans "musical_fruit-#{i}" do
    oz "16"
    action :create
  end
}

(1..2).each { |i|
  can_opener "can_opener-#{i}" do
    action :create
  end
}

(1..2).each { |i|
  box_o_wheatthins "box_o_wheatthins-#{i}" do
    action :create
  end
}

(1..3).each { |i|
  bags_o_chips "box_o_wheatthins-#{i}" do
    action :create
  end
}

(1..3).each { |i|
  cans_o_salsa "cans_o_salsa-#{i}" do
    action :create
  end
}

(1..3).each { |i|
  cans_o_salsa "cans_o_salsa-#{i}" do
    action :create
  end
}


