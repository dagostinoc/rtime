require 'spec_helper'

describe Rtime::Timer do
  let :timer do
    Rtime::Timer.new
  end

  it 'computes duration of a block' do
    expect(timer.start).to be_nil
    expect(timer.duration).to be_nil
    expect do
      timer.time { }
    end.to change { timer.duration }
    expect(timer.start).to be_a Time
    expect(timer.duration).to be_a Float
  end
end
