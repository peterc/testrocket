# frozen_string_literal: true
require 'colorize'
##
# TestRocket Module to refine lambdas an use them for lightweight tests
#
module TestRocket
  VERSION = '1.0.0'

  extend Module.new { attr_accessor :out }

  refine Proc do
    # Include TestRocket methods WITHOUT implementation selected
    Proc.send :include, TestRocket

    # If we're in a production environment, the tests shall do nothing.
    if ENV['RACK_ENV'] == 'production' ||
       (defined?(Rails) && Rails.env.production?) ||
       ENV['RAILS_ENV'] == 'production'
      def _test(a, b); end
      def _show(r); end
      def _pend; end
      def _desc; end
    else
      def _test(a, b); send((call rescue()) ? a : b) end
      def _show(r); (TestRocket.out || STDERR) << r + "\n"; r end
      def _pass; '     OK'.green end
      def _fail; "   FAIL @ #{source_location * ':'}".red end
      def _pend; "PENDING '#{call}' @ #{source_location * ':'}".cyan end
      def _desc; "   FIRE '#{call}'!".blue end
    end

    def +@; _show _test :_pass, :_fail end
    def -@; _show _test :_fail, :_pass end
    def ~; _show _pend end
    def !; _show _desc end
  end
end
