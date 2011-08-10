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

Ruby 1.9. That's it. It'll probably work on Ruby 1.8 if you use 1.8 lambda syntax but I haven't tried it and you shouldn't be using 1.8 anymore anyway ;-)

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