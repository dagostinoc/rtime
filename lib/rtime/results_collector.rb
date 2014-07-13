require 'redis'
require 'time'
require 'date'
require 'csv'

class Rtime::ResultsCollector
  def initialize(redis: nil, set: nil)
    @set    = derive_set_name(set)
    @redis  =
      if Redis === redis
        redis
      elsif redis.respond_to?(:to_str)
        Redis.new(url: redis.to_str)
      else
        Redis.new
      end
  end

  attr_reader :redis

  attr_reader :set

  def add(result, time = Time.now)
    redis.zadd @set, time.to_i, JSON(result)
    self
  end

  def clear
    redis.del @set
    self
  end

  def count(from: Time.at(0), to: (Date.today + 2).to_time)
    redis.zcount @set, from.to_i, to.to_i
  end

  def range(from: Time.at(0), to: (Date.today + 2).to_time)
    redis.zrange(@set, from.to_i, to.to_i).map { |r| JSON.load(r) }
  end

  def to_csv(from: Time.at(0), to: (Date.today + 2).to_time)
    CSV.generate(col_sep: ?\t, force_quotes: true) do |csv|
      csv << %w[ start stop duration pid exitstatus name argv]
      for result in range(from: from, to: to)
        csv << [
          result.start.strftime('%FT%T%:z'),
          result.stop.strftime('%FT%T%:z'),
          result.duration,
          result.pid,
          result.exitstatus,
          result.name,
          result.argv,
        ]
      end
    end
  end

  private

  def derive_set_name(set)
    rails_env and set = "#{rails_env}/#{set}"
    set.freeze
  end

  def rails_env
    ENV['RAILS_ENV']
  end
end
