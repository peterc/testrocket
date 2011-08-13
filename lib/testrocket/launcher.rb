module TestRocketLauncher
  def fire(d,&b)
    !->{ d.to_s }
    b.call
    r = "  /FIRED"
    (TestRocket.out || $>).puts r; r
  end
  def launcher(d,&b)
    $targets = 0; $hits = 0; $lost = 0
    (TestRocket.out || $>).puts "LAUNCHING '#{d}'"
    $launched = true
    b.call
    $launched = false
    r = "HIT #{$hits} of #{$targets} TARGET(S) AND MISSED #{$targets-$lost-$hits}, LOST #{$lost} ROCKET(S)"
    (TestRocket.out || $>).puts r; r
  end
end
self.send :include, TestRocketLauncher

