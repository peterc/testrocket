require_relative 'helper'

class RefinementTest
  using TestRocket

  def self.test!
    describe TestRocket do
      it 'finds emptiness non-truthful by default' do
        _(+->{}).must_match(/FAIL/)
        _(+->{}).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'passes a simple positive assertion' do
        _(+->{ 2 + 2 == 4 }).must_match(/OK/)
      end

      it 'passes a simple negative assertion' do
        _(-->{ 2 + 2 == 5 }).must_match(/OK/)
      end

      it 'fails a simple erroneous assertion' do
        _(+->{ 2 + 2 == 5 }).must_match(/FAIL/)
        _(+->{ 2 + 2 == 5 }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'fails a simple correct assertion assumed to fail' do
        _(-->{ 2 + 2 == 4 }).must_match(/FAIL/)
        _(-->{ 2 + 2 == 4 }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'gives a pending notice' do
        _(~->{ 'a pending test' }).must_match(/PENDING/)
        _(~->{ 'a pending test' }).must_match(/a pending test/)
        _(~->{ 'a pending test' }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'fires a description rocket' do
        _(!->{ 'a description' }).must_match(/FIRE/)
        _(!->{ 'a description' }).must_match(/a description/)
      end

      it 'influences Ruby Proc if TestRocket used explicitly' do
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
      it 'does not influence global Ruby scope and other libs' do
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