require_relative 'helper'

describe TestRocket do
  it "should find emptiness non-truthful by default" do
    (+->{}).must_match(/FAIL/)
    (+->{}).must_match("#{__FILE__}:#{__LINE__}")
  end
  
  it "should pass a simple positive assertion" do
    (+->{ 2 + 2 == 4 }).must_match(/OK/)
  end

  it "should pass a simple negative assertion" do
    (-->{ 2 + 2 == 5 }).must_match(/OK/)
  end
  
  it "should fail a simple erroneous assertion" do
    (+->{ 2 + 2 == 5 }).must_match(/FAIL/)
    (+->{ 2 + 2 == 5 }).must_match("#{__FILE__}:#{__LINE__}")
  end

  it "should fail a simple correct assertion assumed to fail" do
    (-->{ 2 + 2 == 4 }).must_match(/FAIL/)
    (-->{ 2 + 2 == 4 }).must_match("#{__FILE__}:#{__LINE__}")
  end
  
  it "should give a pending notice" do
    (~->{ "a pending test" }).must_match(/PENDING/)
    (~->{ "a pending test" }).must_match(/a pending test/)
    (~->{ "a pending test" }).must_match("#{__FILE__}:#{__LINE__}")
  end
  
  it "should fire a description rocket" do
    (!->{ "a description" }).must_match(/FIRE/)
    (!->{ "a description" }).must_match(/a description/)
  end
end
