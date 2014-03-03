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
