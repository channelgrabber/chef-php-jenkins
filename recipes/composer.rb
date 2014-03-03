include_recipe "composer::install"

packages = {
    "phpunit/phpunit=3.7.*" => "phpunit",
    "squizlabs/php_codesniffer=1.5.*" => "phpcs",
    "phploc/phploc=2.0.*" => "phploc",
    "pdepend/pdepend=1.1.*" => "pdepend",
    "phpmd/phpmd=1.4.*" => "phpmd",
    "sebastian/phpcpd=2.0.*" => "phpcpd",
    "theseer/phpdox=0.6.*" => "phpdox"
}

packages.each do |require, executable|
    execute "composer global require '#{require}'" do
        user node['jenkins']['server']['user']
        group node['jenkins']['server']['group']
        action :run
    end

    link File.join("/usr/local/bin", executable) do
        to File.join(File.expand_path("$COMPOSER_HOME/vendor/bin"), executable)
        owner node['jenkins']['server']['user']
        group node['jenkins']['server']['group']
    end
end