require 'spec_helper'

describe 'gina_id::database' do
  before do
    configure_chef
    stub_command("ls /var/lib/pgsql/9.3/data/recovery.conf").and_return(false)
  end

  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node,server|
      setup_data_bags(server)
    end.converge(described_recipe)
  end

  it 'should include postgresql::server' do
    expect(chef_run).to include_recipe('postgresql::server')
  end

  it 'should include database::postgresql' do
    expect(chef_run).to include_recipe('database::postgresql')
  end

  it 'Enable and start service postgresql' do
    expect(chef_run).to enable_service('postgresql')
    expect(chef_run).to start_service('postgresql')
  end

  it 'should create the gina_id database' do
    expect(chef_run).to create_postgresql_database('gina_id_production')
  end

  it 'should create the gina_id database user' do
    expect(chef_run).to create_postgresql_database_user('gina_id')
  end

  it 'should grant all priveleges to the gina_id user on the gina_id db' do
    expect(chef_run).to grant_postgresql_database_user('gina_id')
  end
end
