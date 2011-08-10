module TestRocket
  module Out; attr_accessor :out; end; extend Out
  
  def _test(a, b)
    send((call rescue()) ? a : b)
  end

  def +@; r = _test :_pass, :_fail; (TestRocket.out || $>).puts r; r end
  def -@; r = _test :_fail, :_pass; (TestRocket.out || $>).puts r; r end

  def _pass; '  OK'; end
  def _fail; "FAIL @ #{source_location.join(':')}"; end
end

Proc.send :include, TestRocket