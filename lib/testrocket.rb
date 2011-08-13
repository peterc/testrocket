module TestRocket
  module Out; attr_accessor :out; end; extend Out
  
  def _test(a, b)
    send((call rescue()) ? a : b)
  end
  
  def launched?
    !!($launched rescue())
  end

  def +@; r = _test :_pass, :_fail; (TestRocket.out || $>).puts r; r end
  def -@; r = _test :_fail, :_pass; (TestRocket.out || $>).puts r; r end
  def ~@; r = _pend;                (TestRocket.out || $>).puts r; r end
  def !@; r = _desc;                (TestRocket.out || $>).puts r; r end
  
  def _pass; ($targets += 1; $hits += 1) if launched?; '    OK'; end
  def _fail; ($targets += 1)             if launched?; "    FAIL @ #{source_location.join(':')}"; end
  def _pend; ($targets += 1; $lost += 1) if launched?; "    PENDING '#{call.to_s}' @ #{source_location.join(':')}"; end
  def _desc;                                           "  FIRE '#{call.to_s}'!"; end

end
Proc.send :include, TestRocket

