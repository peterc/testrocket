require_relative 'helper'

class RefinementTest
  using TestRocket

  def self.test!
    describe TestRocket do
      it 'should find emptiness non-truthful by default' do
        _(+->{}).must_match(/FAIL/)
        _(+->{}).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should pass a simple positive assertion' do
        _(+->{ 2 + 2 == 4 }).must_match(/OK/)
      end

      it 'should pass a simple negative assertion' do
        _(-->{ 2 + 2 == 5 }).must_match(/OK/)
      end

      it 'should fail a simple erroneous assertion' do
        _(+->{ 2 + 2 == 5 }).must_match(/FAIL/)
        _(+->{ 2 + 2 == 5 }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should fail a simple correct assertion assumed to fail' do
        _(-->{ 2 + 2 == 4 }).must_match(/FAIL/)
        _(-->{ 2 + 2 == 4 }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should give a pending notice' do
        _(~->{ 'a pending test' }).must_match(/PENDING/)
        _(~->{ 'a pending test' }).must_match(/a pending test/)
        _(~->{ 'a pending test' }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should fire a description rocket' do
        _(!->{ 'a description' }).must_match(/FIRE/)
        _(!->{ 'a description' }).must_match(/a description/)
      end

      it 'would influence Ruby Proc if TestRocket used explitly' do
        (
          ok = ->() { nil }
          _(!ok)
        ).must_match(/FIRE/)
      end
    end
  end
end

class NoRefinementTest
  def self.test!
    describe 'Without `using TestRocket`' do
      it 'should not influence global Ruby scope and other libs' do
        (
          ok = ->() { nil }
          _(!ok)
        ).must_equal(false)
      end
    end
  end
end

RefinementTest.test!
NoRefinementTest.test!