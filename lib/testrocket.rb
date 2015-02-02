module TestRocket
  VERSION = "0.0.3"

  extend Module.new { attr_accessor :out }

  module Live
    def _test(a, b); send((call rescue()) ? a : b) end  
    def _show(r); (TestRocket.out || STDERR) << r + "\n"; r end
    def _pass; "     OK" end
    def _fail; "   FAIL @ #{source_location * ':'}" end
    def _pend; "PENDING '#{call}' @ #{source_location * ':'}" end
    def _desc; "   FIRE '#{call}'!" end
  end

  module Dummy
    def _test(a, b); end
    def _show(r); end
    def _pend; end
    def _desc; end
  end

  def +@; _show _test :_pass, :_fail end
  def -@; _show _test :_fail, :_pass end
  def ~; _show _pend end
  def !; _show _desc end
end

Proc.send :include, TestRocket

# If we're in a production environment, the tests shall do nothing.
if ENV['RACK_ENV'] == 'production' || (defined?(Rails) && Rails.env.production?) || ENV['RAILS_ENV'] == 'production'
  Proc.send :include, TestRocket::Dummy
else
  Proc.send :include, TestRocket::Live
end
