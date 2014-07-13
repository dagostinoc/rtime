require 'rtime/executor'
require 'rtime/results_collector'

class Rtime::Client
  def initialize(redis: nil, set: nil)
    set ||= 'rtime'
    @results_collector = Rtime::ResultsCollector.new(redis: redis, set: set)
    @executor          = Rtime::Executor.new
  end

  # The redis client that is used.
  def redis
    @results_collector.redis
  end

  attr_reader :result # The result of the last execute process if any.

  # The name of the redis set used for storing
  def set
    @results_collector.set
  end

  # The name of the last executed process if any.
  def name
    result && result.name
  end

  def execute(*argv, name: nil)
    @result = @executor.execute(*argv, name: name)
    @results_collector.add(@result)
    self
  end

  def clear_results
    @results_collector.clear
    self
  end

  def count_results
    @results_collector.count
  end

  def results(from: Time.at(0), to: (Date.today + 2).to_time)
    @results_collector.range(from: from, to: to)
  end

  def results_as_csv(from: Time.at(0), to: (Date.today + 2).to_time)
    @results_collector.to_csv(from: from, to: to)
  end
end
