require 'helper'

describe TestRocket do

  it "should find emptiness non-truthful by default" do
    (+->{}).must_match(/FAIL/)
  end
  
  it "should pass a simple positive assertion" do
    (+->{ 2 + 2 == 4 }).must_match(/OK/)
  end

  it "should pass a simple negative assertion" do
    (-->{ 2 + 2 == 5 }).must_match(/OK/)
  end
  
  it "should fail a simple erroneous assertion" do
    (+->{ 2 + 2 == 5 }).must_match(/FAIL/)
  end

  it "should fail a simple correct assertion assumed to fail" do
    (-->{ 2 + 2 == 4 }).must_match(/FAIL/)
  end
  
  it "should give a pending notice" do
    (~->{ "a pending test" }).must_match(/PENDING/)
    (~->{ "a pending test" }).must_match(/a pending test/)
  end
  
  it "should fire a description rocket" do
    (!->{ "a description" }).must_match(/FIRE/)
    (!->{ "a description" }).must_match(/a description/)
  end

end
 
describe TestRocketLauncher do
  
  it "should parse a whole 'fire block'" do
    (fire "my test suite" do
      +-> { 1 + 2 == 3 }
      --> { 1 - 2 == 3 }
    end).must_match(/FIRED/)
  end
  
  it "should also work with nested fire blocks" do
    (fire "my test suite" do
      fire "my nested tests 1" do
        +-> { 1 + 2 == 3 }
        --> { 1 - 2 == 3 }
      end
      fire "my nested tests 2" do
        +-> { 23 != 42 }
        --> { 23 == 42 }
      end
    end).must_match(/\/FIRED/)
  end
  
  it "should launch the rocket!" do
    result = (launcher "my test suite" do
      fire "my nested tests 1" do
        fire "my nested test 1.1" do
          +-> { 1 + 2 == 3 }
        end
        fire "my nested test 1.2" do
          --> { 1 - 2 == 3 }
        end
        fire "my nested test 1.3" do
          ~-> { "not defined yet" }
        end
      end
      fire "my nested tests 2" do
        +-> { 23 != 42 }
        --> { 23 == 42 }
        --> { true }
      end
    end).must_match("HIT 4 of 6 TARGET(S) AND MISSED 1, LOST 1 ROCKET(S)")
  end

end
