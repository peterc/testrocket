module TestRocket
  extend Module.new { attr_accessor :out }
  
  def _test(a, b); send((call rescue()) ? a : b); end

  def +@; _show _test :_pass, :_fail end
  def -@; _show _test :_fail, :_pass end
  def ~; _show _pend;               end
  def !; _show _desc;               end
  
  def _show(r); (TestRocket.out || $>) << r; r end
  def _pass; "     OK\n"; end
  def _fail; "   FAIL @ #{source_location * ':'}\n"; end
  def _pend; "PENDING '#{call}' @ #{source_location * ':'}\n"; end
  def _desc; "   FIRE '#{call}'!\n"; end
end

Proc.send :include, TestRocket
