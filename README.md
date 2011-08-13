     _            _                  _         _   
    | |_  ___ ___| |_ _ __ ___   ___| | __ ___| |_ 
    | __|/ _ | __| __| '__/ _ \ / __| |/ // _ \ __|
    | |_|  __|__ \ |_| | | (_) | (__|   <|  __/ |_ 
     \__|\___|___/\__|_|  \___/ \___|_|\_\\___|\__|
                                                   
Testrocket is a super simple (as simple as it gets really) testing library for Ruby.

It was initially developed for [this CodeBrawl competition](http://codebrawl.com/articles/contest-rundown-ruby-testing-libraries) and it won! People then asked me to release it 'for real' so here we are.

To install:

    gem install testrocket
    
As yet there are no useful bits and pieces for creating test files (look at the example, it's easy!) or Rake tasks. But it's all crazy simple. A few things may be added later on.
    
Dependencies
------------

- Ruby 1.9
- minitest/spec (part of MRI 1.9 stdlib)
- Unix/Unix-like/POSIX system

Example
-------

    require 'testrocket'
    
    # ===========================================================
    # EXAMPLE TEST "SUITE" FOR "DIE"
    #
    # USAGE
    # +-> { block that should succeed }
    # --> { block that should fail }
    
    +-> { Die.new(2) }
    --> { raise }
    +-> { 2 + 2 == 4 }
    
    # These two tests will deliberately fail
    +-> { raise }
    --> { true }

    # A 'pending' test
    ~-> { "this is a pending test" }

    # A description
    !-> { "use this for descriptive output and to separate your test parts" }
    
Launcher Extension
------------------

    require 'testrocket'
    require 'testrocket/launcher' # <-- has to be added manually!
    
    launcher "my bigger test suite" do
      fire "first test part" do
        +-> { true }
        --> { false }
      end
      fire "second test part" do
        +-> { true }
        --> { false }
      end
    end
    
OUTPUT will be:
    
    LAUNCHING 'my bigger test suite'
      FIRE 'first test part'!
        OK
        OK
      /FIRED
      FIRE 'second test part'!
        OK
        OK
      /FIRED
    HIT 4 of 4 TARGET(S) AND MISSED 0, LOST 0 ROCKET(S)
     => "HIT 4 of 4 TARGET(S) AND MISSED 0, LOST 0 ROCKET(S)" 

_launcher_ = something like "describe" in other test suites

The _launcher_ also collects test counts, the positive/negative hits and "lost rockets" (= pending).

_fire_ = something like "it" in other test suites

The _fire_ blocks utilize the _description rocket_, so you don't have to do it in an extra step, it also adds a closing output line for each fire-block.
    
Other Features
--------------

By default, output is written to STDOUT (as well as returned by the test expressions themselves). You can override where test output goes like so:

    TestRocket.out = File.new('/dev/null', 'w')

Authors
-------

Initial concept and maintenance by Peter Cooper

Extra concepts and code by Christoph Grabo
