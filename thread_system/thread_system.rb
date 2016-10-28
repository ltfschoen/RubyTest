require 'thread'
require "monitor"

class ThreadSystem

  # main thread waits for subthreads that each finish in random order
  def self.process_subthreads
    count = 0
    threads = 10.times.map do |i|
      Thread.new do
        sleep(rand(0.2))
        # possible race condition if multiple threads set this variable
        # fix by synchronising access to shared resources (i.e. `count`)
        Thread.current[:mycount] = count
        count += 1
      end
    end
    threads.each { |t|
      t.join
      # print t[:mycount], ", "
    }
    count
  end

  def self.process_subthreads_handling_exception
    # Thread.abort_on_exception = true
    threads = 4.times.map do |number|
      Thread.new(number) do |i|
        raise "Boom!" if i == 1
        # print "#{i}\n"
        end
    end
    # puts "Waiting"
    # threads.each(&.join)
    threads.each do |t|
      begin
        t.join
      rescue RuntimeError => e
        # puts "Failed: #{e.message}"
      end
    end
    # puts "Done"
    return nil
  end

  def self.process_threads_race_condition_without_mutex
    sum = 0
    threads = 10.times.map do
      Thread.new do
        100_000.times do
          new_value = sum + 1
          # Race condition and data loss caused by this `print` call that causes another thread to spawn
          # print "#{new_value} " if new_value % 250_000 == 0
          print "" # cause the race condition without output
          sum = new_value
        end
      end
    end
    threads.each(&:join)
    # puts "\nsum = #{sum}"
    sum
  end

  def self.process_threads_with_mutex
    sum = 0
    mutex = Mutex.new
    threads = 10.times.map do
      Thread.new do
        100_000.times do
          # automatic mutex lock and unlock block
          mutex.synchronize do          # permit only one thread at a tme
            new_value = sum + 1         #
            # print "#{new_value} " if new_value % 250_000 == 0
            sum = new_value             #
          end                           #
        end
      end
    end
    threads.each(&:join)
    # puts "\nsum = #{sum}"
    sum
  end

  # Mutex-protected regions can NOT be re-entered by the same thread.
  # Monitor-protected regions CAN be re-entered by the same thread.
  def self.monitor_vs_mutex_regions
    # This file is in public domain. Obtained from post by Martin Vahi
    mx_monitor=Monitor.new
    mx_mutex=Mutex.new

    ob_thread_for_monitor = Thread.new do
      mx_monitor.synchronize do
        puts "Monitor buoy 1a { "
        mx_monitor.synchronize do
          puts "    Monitor buoy 2"
        end # mx_monitor
        puts "} Monitor buoy 1b"
      end # mx_monitor
    end # ob_thread_for_monitor
    ob_thread_for_monitor.join # makes the main thread to wait for it

    ob_thread_for_mutex = Thread.new do
      mx_mutex.synchronize do
        puts "Mutex buoy 1a { "
        mx_mutex.synchronize do
          puts "    Mutex buoy 2 (will never be reached)"
        end # mx_mutex
        puts "} Mutex buoy 1b (there's a crash before this line)"
      end # mx_mutex
    end # ob_thread_for_mutex
    ob_thread_for_mutex.join # for code artistic values
  end

end