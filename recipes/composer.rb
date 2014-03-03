include_recipe "composer::install"

packages = [
    "phpunit/phpunit=3.7.*",
    "squizlabs/php_codesniffer=1.5.*",
    "phploc/phploc=2.0.*",
    "pdepend/pdepend=1.1.*",
    "phpmd/phpmd=1.4.*",
    "sebastian/phpcpd=2.0.*",
    "theseer/phpdox=0.6.*"
]

packages.each do |require|
    execute "composer global require '#{require}'" do
        user node['jenkins']['server']['user']
        group node['jenkins']['server']['group']
        environment(
            'HOME' => node['jenkins']['server']['home'],
            'COMPOSER_HOME' => File.join(node['jenkins']['server']['home'], '.composer'),
            'COMPOSER_BIN_DIR' => '/usr/local/bin'
        )
        action :run
    end
end