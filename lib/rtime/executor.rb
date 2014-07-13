require 'rtime/timer'
require 'rtime/result'

class Rtime::Executor
  def initialize
    @timer = Rtime::Timer.new
  end

  attr_reader :timer

  def execute(*argv, name: nil)
    name ||= derive_process_name(argv)
    argv = Array(argv)
    argv.empty? and raise ArgumentError, 'arguments are required to execute'
    @timer.time do
      execute_command(argv)
    end
    Rtime::Result.new(@timer.start, @timer.duration, @pid, @exitstatus, name, argv)
  end

  private

  def derive_process_name(argv)
    argv * ' '
  end

  def execute_command(argv)
    system *argv
  ensure
    @pid        = process_status.pid
    @exitstatus = process_status.exitstatus
  end

  def process_status
    $?
  end
end
