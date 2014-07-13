class Rtime::Timer
  attr_reader :start

  attr_reader :duration

  def time
    @start = Time.now
    yield
  ensure
    @duration = Time.now - @start
  end
end
