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

end