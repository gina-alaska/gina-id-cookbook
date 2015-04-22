node.override['nginx']['default_site_enabled'] = false
node.override['nginx']['repo_source'] = 'nginx'
include_recipe 'nginx'

app = chef_vault_item('apps', node['app']['data_bag'])

ruby_block 'move_nginx_confs' do
  block do
    if File.exists? '/etc/nginx/conf.d'
      FileUtils::rm_rf '/etc/nginx/conf.d'
    end
  end
end

template "/etc/nginx/sites-available/#{node['app']['name']}" do
  source 'nginx_site.erb'
  variables({
    install_path: "#{app['install_path']}/current",
    name: node['app']['name'],
    environment: node['app']['environment'],
    port: node[node['app']['name']]['puma_port']
  })
end

nginx_site node['app']['name']
