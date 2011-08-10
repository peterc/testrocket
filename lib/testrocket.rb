module TestRocket
  def _test(a, b)
    send((call rescue()) ? a : b)
  end

  def +@; puts _test :_pass, :_fail; end
  def -@; puts _test :_fail, :_pass; end

  def _pass; '   OK'; end
  def _fail; " FAIL @ #{source_location.join(':')}"; end
end

Proc.send :include, TestRocket