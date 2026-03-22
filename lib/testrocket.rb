# frozen_string_literal: true

##
# TestRocket Module to refine lambdas an use them for lightweight tests
#
module TestRocket
  VERSION = '1.2.0'

  extend Module.new { attr_accessor :out }

  refine Proc do
    # If we're in a production environment, the tests shall do nothing.
    if ENV['RACK_ENV'] == 'production' ||
       (defined?(Rails) && Rails.env.production?) ||
       ENV['RAILS_ENV'] == 'production'
      def _test_pass; end
      def _test_fail; end
      def _show(r); end
      def _pend; end
      def _desc; end
    else
      def _test_pass; (call rescue()) ? _pass : _fail end
      def _test_fail; (call rescue()) ? _fail : _pass end
      def _show(r); (TestRocket.out || $stderr) << r + "\n"; r end
      def _pass; '     OK' end
      def _fail; "   FAIL @ #{source_location * ':'}" end
      def _pend; "PENDING '#{call}' @ #{source_location * ':'}" end
      def _desc; "   FIRE '#{call}'!" end
    end

    def +@; _show _test_pass end
    def -@; _show _test_fail end
    def ~; _show _pend end
    def !; _show _desc end
  end
end