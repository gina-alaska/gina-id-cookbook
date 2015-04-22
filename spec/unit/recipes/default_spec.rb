#
# Cookbook Name:: gina_id
# Spec:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2015 GINA
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


require 'spec_helper'

describe 'gina_id::default' do
  context 'When all attributes are default, on an unspecified platform' do
    before do
      configure_chef
      stub_command("ls /var/lib/pgsql/9.3/data/recovery.conf").and_return(false)
      stub_command('git --version >/dev/null').and_return(false)
      stub_command('which nginx').and_return(false)
    end

    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node,server|
        setup_data_bags(server)
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
    it 'should include the database recipe' do
      expect(chef_run).to include_recipe('gina_id::database')
    end
    it 'should include the web recipe' do
      expect(chef_run).to include_recipe('gina_id::web')
    end
  end
end
