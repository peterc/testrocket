require_relative 'helper'

class RefinementTest
  using TestRocket

  def self.test!
    describe TestRocket do
      it 'should find emptiness non-truthful by default' do
        (+->{}).must_match(/FAIL/)
        (+->{}).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should pass a simple positive assertion' do
        (+->{ 2 + 2 == 4 }).must_match(/OK/)
      end

      it 'should pass a simple negative assertion' do
        (-->{ 2 + 2 == 5 }).must_match(/OK/)
      end

      it 'should fail a simple erroneous assertion' do
        (+->{ 2 + 2 == 5 }).must_match(/FAIL/)
        (+->{ 2 + 2 == 5 }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should fail a simple correct assertion assumed to fail' do
        (-->{ 2 + 2 == 4 }).must_match(/FAIL/)
        (-->{ 2 + 2 == 4 }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should give a pending notice' do
        (~->{ 'a pending test' }).must_match(/PENDING/)
        (~->{ 'a pending test' }).must_match(/a pending test/)
        (~->{ 'a pending test' }).must_match("#{__FILE__}:#{__LINE__}")
      end

      it 'should fire a description rocket' do
        (!->{ 'a description' }).must_match(/FIRE/)
        (!->{ 'a description' }).must_match(/a description/)
      end

      it 'would influence Ruby Proc if TestRocket used explitly' do
        (
          ok = ->() { nil }
          !ok
        ).must_match(/FIRE/)
      end

      it 'should set and get out value' do
        original = TestRocket.out
        require 'stringio'
        io = StringIO.new
        begin
          TestRocket.out = io
          (TestRocket.out).must_be_same_as io
        ensure
          TestRocket.out = original
        end
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
          !ok
        ).must_equal(false)
      end
    end
  end
end

RefinementTest.test!
NoRefinementTest.test!
