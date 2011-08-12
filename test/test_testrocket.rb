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
  end
end
