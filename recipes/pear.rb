#prerequisites
channels = ["pear.phpunit.de", "pear.pdepend.org", "pear.phpmd.org", "pear.symfony.com", "components.ez.no", "nikic.github.com/pear"]
packages = ["php5-xsl"]

channels.each do |channel|
  php_pear_channel channel do
    action :discover
  end
end

packages.each do |package_name|
  package package_name do
	action :install
  end
end

#installation
qa_channel = php_pear_channel "pear.phpqatools.org" do
  action :discover
end
php_pear "phpqatools" do
   channel qa_channel.channel_name
   preferred_state "alpha"
   action :install
end
doc_channel = php_pear_channel "pear.netpirates.net" do
  action :discover
end
php_pear "phpDox" do
   channel doc_channel.channel_name
   preferred_state "alpha"
   action :install
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
