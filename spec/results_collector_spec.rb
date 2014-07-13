require 'spec_helper'
require 'tins/xt/time_dummy'

describe Rtime::ResultsCollector do
  let :results_collector do
    Rtime::ResultsCollector.new
  end

  before do
    results_collector.clear
  end

  describe 'adding' do
    it 'stores the result in redis' do
      expect(results_collector.redis).to receive(:zadd)
      results_collector.add(Rtime::Result.new)
    end
  end

  describe 'clearing' do
    it 'clears all results' do
      results_collector.add(Rtime::Result.new)
      before = results_collector.count
      expect(before).to satisfy { |c| c > 0 }
      results_collector.clear
      expect(results_collector.count).to be_zero
    end
  end

  describe 'retrieving' do
    it 'can fetch results' do
      expect(results_collector.range).to be_empty
      results_collector.add(Rtime::Result.new)
      expect(results_collector.range).to have(1).entry
      expect(results_collector.range.first).to be_a Rtime::Result
    end

    it 'can return a correct csv document' do
      Time.dummy(Time.parse('2011-11-11T11:11:11+01:00')) do
        results_collector.add(Rtime::Result.new(Time.now, 23, 666, 0, 'foo', 'foo bar baz'))
      end
      csv = results_collector.to_csv
      expect(csv).to eq <<CSV
"start"\t"stop"\t"duration"\t"pid"\t"exitstatus"\t"name"\t"argv"
"2011-11-11T11:11:11+01:00"\t"2011-11-11T11:11:34+01:00"\t"23"\t"666"\t"0"\t"foo"\t"foo bar baz"
CSV
      expect(csv.lines.first.split(?\t).size).to eq csv.lines.last.split(?\t).size
    end
  end
end
