require 'spec_helper'
require 'time'

describe Rtime::Result do
  let :result do
    Rtime::Result.new(Time.parse('2011-11-11T11:11:11+01:00'), 42.23, 666, 0, 'foo', %w[foo bar])
  end

  it 'can compute its stop time' do
    expect(result.stop).to be_within(2).of(Time.parse('2011-11-11T11:11:53+01:00'))
  end

  it 'can be represented as JSON text' do
    expect(JSON.pretty_generate(result)).to eq <<EOT.chomp
{
  "json_class": "Rtime::Result",
  "v": [
    {
      "json_class": "Time",
      "s": 1321006271,
      "n": 0
    },
    42.23,
    666,
    0,
    "foo",
    [
      "foo",
      "bar"
    ]
  ]
}
EOT
  end
end
