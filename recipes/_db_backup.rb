
include_recipe 'chef-vault'
app = chef_vault_item('apps', node['app']['data_bag'])

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

  schedule({
    :minute => 0,
    :hour   => 0
  })
end
