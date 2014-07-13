require 'spec_helper'

describe Rtime::Executor do
  let :executor do
    Rtime::Executor.new
  end

  describe 'execution' do
    it 'needs arguments to execute' do
      expect { executor.execute }.to raise_error(ArgumentError)
    end

    it 'times the executed process' do
      expect(executor.timer).to receive(:time).and_call_original
      executor.execute 'true'
    end

    it 'returns a filled Rtime::Result' do
      result = executor.execute('true', name: 'the name')
      expect(result).to be_a Rtime::Result
      expect(result.start).to be_a Time
      expect(result.pid).to respond_to :to_int
      expect(result.duration).to be_a Float
      expect(result.exitstatus).to eq 0
      expect(result.name).to eq 'the name'
    end
  end
end
