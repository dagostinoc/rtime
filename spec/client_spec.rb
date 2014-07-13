require 'spec_helper'

describe Rtime::Client do
  let :client do
    Rtime::Client.new
  end

  describe 'set name' do
    it 'has a default set name' do
      expect(client.set).to eq 'rtime'
    end

    it 'can be passed a set name' do
      client = Rtime::Client.new(set: 'foo')
      expect(client.set).to eq 'foo'
    end

    it 'prefixes sets with RAILS_ENV if the environment variable was set' do
      begin
        old, ENV['RAILS_ENV'] = ENV['RAILS_ENV'], 'production'
        expect(client.set).to eq 'production/rtime'
      ensure
        ENV['RAILS_ENV'] = old
      end
    end
  end

  describe 'redis connection' do
    it 'opens a default redis connection' do
      expect(client.redis).to be_a Redis
    end

    it 'can be passed an existing redis connection' do
      redis = Redis.new
      client = Rtime::Client.new(redis: redis)
      expect(client.redis).to eq redis
    end

    it 'opens a redis client connected to a given url' do
      expect(Redis).to receive(:new).with(url: 'my redis url')
      Rtime::Client.new(redis: 'my redis url')
    end
  end

  describe 'execution' do
    it 'needs arguments to execute' do
      expect { client.execute }.to raise_error(ArgumentError)
    end

    it 'should remember the name of the executed process' do
      client.execute 'true', name: 'my_name'
      expect(client.name).to eq 'my_name'
    end

    it 'can derive a name for an executed process' do
      client.execute 'true', '1', '2'
      expect(client.name).to eq 'true 1 2'
    end

    it 'stores the result in redis' do
      expect(client.instance_eval { @results_collector }).to receive(:add).and_call_original
      client.execute 'true', '1', '2'
    end
  end

  describe 'retrieving results' do
    it 'can retrieve stored results' do
      client.clear_results
      expect(client.results).to eq []
      client.execute 'true', '1', '2'
      expect(client.results).to have(1).entry
    end

    it 'can retrieve stored results as csv' do
      client.clear_results
      expect(client.results_as_csv).to respond_to :to_str
      expect(client.results_as_csv.lines).to have(1).entry
      client.execute 'true', '1', '2'
      expect(client.results_as_csv).to respond_to :to_str
      expect(client.results_as_csv.lines).to have(2).entries
    end
  end

  describe 'clearing results' do
    it 'clears all results' do
      client.execute 'true', '1', '2'
      before = client.count_results
      expect(before).to satisfy { |c| c > 0 }
      client.clear_results
      expect(client.count_results).to be_zero
    end
  end
end
