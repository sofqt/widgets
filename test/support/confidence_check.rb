module TestSupport
  module ConfidenceCheck
    class ConfidenceCheckFailed < Minitest::Assertion
      def initialize(minitest_assertion)
        super("CONFIDENCE CHECK FAILED: #{minitest_assertion.message}")
        @minitest_assertion = minitest_assertion
      end

      delegate :backtrace,
               :error,
               :location,
               :result_code,
               :result_label,
               :backtrace_locations,
               :cause, to: :@minitest_assertion
    end

    # Used to indicate assertions that give confidence that
    # the test has been properly set up or that dependent
    # functionality is working
    def confidence_check(&block)
      block.call
    rescue Minitest::Assertion => e
      raise ConfidenceCheckFailed, e
    end
  end
end
