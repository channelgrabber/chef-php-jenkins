include_recipe "jenkins"
include_recipe "ant"

include_recipe "php"

include_recipe "php-jenkins::#{node['php-jenkins']['install_method']}"