require_relative '../../thread_system/thread_system.rb'

RSpec.describe ThreadSystem, "#thread_system" do

  context "with thread system" do

    it "count returned from subthreads as expected" do
      expect(ThreadSystem.process_subthreads).to eq 10
    end

    it "raises exception and aborts when abort on exception flag true as expected" do
      Thread.abort_on_exception = true
      expect { ThreadSystem.process_subthreads_handling_exception }.to raise_error(RuntimeError)
    end

    it "bypasses exception when abort on exception flag false as expected" do
      Thread.abort_on_exception = false # default
      expect(ThreadSystem.process_subthreads_handling_exception).to eq nil
    end

    it "causes race condition resulting in values returned being less than expected" do
      expect(ThreadSystem.process_threads_race_condition_without_mutex).to_not eq 1000000
    end

    it "using mutex to get correct result returned" do
      expect(ThreadSystem.process_threads_with_mutex).to eq 1000000
    end

    it "uses monitor and mutex regions causes deadlock when mutex protected region reentered by same thread" do
      expect { ThreadSystem.monitor_vs_mutex_regions  }.to raise_error(ThreadError)
    end

  end
end