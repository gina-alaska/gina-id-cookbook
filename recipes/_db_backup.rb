
include_recipe 'chef-vault'
app = chef_vault_item('apps', node['app']['data_bag'])

node.default['backup']['version'] = '4.3.0'
package %w( libxml2 libxml2-devel libxslt-devel ) do
  action :install
end

gem_package 'nokogiri' do
  version '1.6.6.2'
  options '-- --use-system-libraries --with-xml2-config=/usr/bin/xml2-config'
end

include_recipe 'backup::default'

backup_model :postgresql do
  description "Back up my postgresql database"

  definition <<-DEF
    split_into_chunks_of 4000

    database PostgreSQL do |db|
      db.name = '#{app['db']['name']}'
      db.host = '127.0.0.1'
      db.username = '#{app['db']['username']}'
      db.password = '#{app['db']['password']}'
      db.additional_options = ['--data-only']
    end

    compress_with Gzip

    store_with Local do |local|
      local.path = '/root/backups/#{app['db']['name']}'
      local.keep = 5
    end
  DEF

  cron_options(
    path: "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:#{node['languages']['ruby']['bin_dir']}"
  )

  schedule({
    :minute => 0,
    :hour   => 0
  })
end
