require 'spec_helper'

describe 'gina_id::web' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node, server|
      setup_data_bags(server)
    end.converge(described_recipe)
  end

  it 'should include chef-vault' do
    expect(chef_run).to include_recipe('chef-vault')
  end

  it 'should include the user recipe' do
    expect(chef_run).to include_recipe('gina_id::_user')
  end

  it 'should include the ruby recipe' do
    expect(chef_run).to include_recipe('gina_id::_ruby')
  end

  it 'should include the ruby recipe' do
    expect(chef_run).to include_recipe('gina_id::_nginx')
  end

  it 'should include the application recipe' do
    expect(chef_run).to include_recipe('gina_id::_application')
  end


  it 'should add web user' do
    expect(chef_run).to create_user('webdev')
  end

  it 'should create application directory' do
    expect(chef_run).to create_directory('/www/gina_id')
  end

  it 'should create application shared directory' do
    expect(chef_run).to create_directory('/www/gina_id/shared')
  end

  it 'should create application bundle directory' do
    expect(chef_run).to create_directory('/www/gina_id/shared/bundle')
  end

  # it 'should create database template' do
  #   expect(chef_run).to create_template('/www/gina_id/config/database.yml')
  # end

  # it 'should squish database attributes' do
  #   expect(chef_run).to run_ruby_block('squish-database-attributes')
  # end

  # it 'should create rails secrets config' do
  #   expect(chef_run).to create_template('/www/gina_id/config/secrets.yml')
  # end
end
