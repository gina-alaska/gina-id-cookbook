node.override['nginx']['default_site_enabled'] = false

include_recipe 'chef_nginx'
include_recipe 'chef-sugar'

app = chef_vault_item('apps', node['app']['data_bag'])

ssl_crt = '/etc/ssl/certs/id.gina.alaska.edu.crt'
ssl_key = '/etc/ssl/certs/id.gina.alaska.edu.key'

nginx_site node['app']['name'] do
  template 'nginx_site.erb'
  variables({
    install_path: "#{app['install_path']}/current",
    name: node['app']['host'],
    environment: node['app']['environment'],
    port: node[node['app']['name']]['puma_port'],
    enable_ssl: node['app'].attribute?('ssl_data_bag'),
    ssl_cert: ssl_crt,
    ssl_key: ssl_key
  })
end

node.default['acme']['contact'] = 'mailto:support@gina.alaska.edu'

include_recipe 'acme::default'

acme_selfsigned 'id.gina.alaska.edu' do
  crt ssl_crt
  key ssl_key
  notifies :restart, 'service[nginx]'
end

acme_certificate 'id.gina.alaska.edu' do
  crt '/etc/ssl/certs/vctr.crt'
  key '/etc/ssl/certs/vctr.key'
  method 'http'
  wwwroot node.default['nginx']['default_root']
  not_if { vagrant? }
end

include_recipe 'firewall::default'
firewall_rule 'http_https' do
  port [80, 443]
  command :allow
end
