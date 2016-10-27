# Fiber library (symmetric co-routines) to extend Fiber class for use of `transfer`
# https://ruby-doc.org/core-2.2.0/Fiber.html
require 'fiber'

class FileList

  # Class method called by block so files manage their own lifecycle
  def self.open_and_process(*args)
    begin
      f = File.open(*args)
      yield f
    rescue
      print "Error opening and processing file"
    else
      print "File opened and processed without error"
    ensure
      f.close() unless f.closed?
    end
  end

  def self.open_find_and_count_words(arg)
    # Fiber constructor takes a block and returns a Fiber object.
    # Block not executed immediately.

    # Block until reaches Fiber.yield
    # Fiber object not executed returned when reach Fiber.yield
    words = Fiber.new do
      File.foreach(arg) do |line|
        line.scan(/\w+/) do |word|
          Fiber.yield word.downcase
        end
      end
      nil
    end

    # Calling resume on Fiber object `words.resume` causes block to start.
    # When Fiber.yield is invoked the block suspends execution and the `words.resume` returns the value assigned
    # Word counter is run for each word returned by Fiber.yield until `nil` is returned
    counts = Hash.new(0)
    while word = words.resume
      counts[word] += 1
    end
    p "Counts: " + counts.inspect
    counts.keys.sort.each {|k| print "#{k}:#{counts[k]} "}
    counts
  end

  def self.numbers_not_divisible_by_three
    result = []
    twos = Fiber.new do
      num = 2
      loop do
        Fiber.yield(num) unless num % 3 == 0
        num += 2
      end
    end
    10.times { result << twos.resume }
    result
  end

  def self.swap_between_producer_and_consumer
    # take items two at a time off queue, calling the producer if insufficient available
    consumer = Fiber.new do |producer, queue|
      5.times do
        while queue.size < 2
          # Transfer to Fiber `producer` and suspend calling Fiber `consumer`
          queue = producer.transfer(consumer, queue)
        end
        # puts "Before Consume #{queue}"
        queue.shift
        queue.shift
        # Retrieve and remove first array item
        # puts "After Consume #{queue}"
      end
      queue
    end

    # add items three at a time to the queue
    producer = Fiber.new do |consumer, queue|
      value = 1
      loop do
        puts "Producing more stuff"
        3.times { queue << value; value += 1}
        # puts "Queue size is #{queue.size}"
        # Transfer to Fiber `consumer` and suspend calling Fiber `producer`
        consumer.transfer queue
      end
    end
    # Transfer control to another Fiber and start or resume from where last stopped
    consumer.transfer(producer, [])
  end
end