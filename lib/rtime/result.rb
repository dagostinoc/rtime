require 'json/add/core'

class Rtime::Result < Struct.new(:start, :duration, :pid, :exitstatus, :name, :argv)
  def stop
    start + duration
  end
end
