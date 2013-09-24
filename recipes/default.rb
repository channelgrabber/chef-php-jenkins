include_recipe "jenkins"
include_recipe "ant"

include_recipe "php"
execute "enable pear auto discover" do
    command "pear config-set auto_discover 1"
end

execute "install phpqatools" do
    command "pear install --force --alldeps pear.phpqatools.org/phpqatools"
end

execute "install phpdox" do
    command "sudo pear install -f pear.netpirates.net/phpDox-0.5.0"
end

#workaround for https://github.com/fnichol/chef-jenkins/issues/9
directory "#{node['jenkins']['server']['home']}/updates/" do
  owner node['jenkins']['server']['user']
  group node['jenkins']['server']['user']
  action :create
end

execute "update jenkins update center" do
  command "wget http://updates.jenkins-ci.org/update-center.json -qO- | sed '1d;$d'  > #{node['jenkins']['server']['home']}/updates/default.json"
  user node['jenkins']['server']['user']
  group node['jenkins']['server']['user']
  creates "#{node['jenkins']['server']['home']}/updates/default.json"
end
