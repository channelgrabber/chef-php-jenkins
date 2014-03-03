include_recipe "jenkins"
include_recipe "ant"

include_recipe "php"

include_recipe "php-jenkins::#{node['php-jenkins']['install_method']}"

#workaround for https://github.com/fnichol/chef-jenkins/issues/9
directory "#{node['jenkins']['server']['home']}/updates/" do
  owner node['jenkins']['server']['user']
  group node['jenkins']['server']['group']
  action :create
end

execute "update jenkins update center" do
  command "wget http://updates.jenkins-ci.org/update-center.json -qO- | sed '1d;$d'  > #{node['jenkins']['server']['home']}/updates/default.json"
  user node['jenkins']['server']['user']
  group node['jenkins']['server']['group']
  creates "#{node['jenkins']['server']['home']}/updates/default.json"
end