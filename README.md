     _            _                  _         _
    | |_  ___ ___| |_ _ __ ___   ___| | __ ___| |_
    | __|/ _ | __| __| '__/ _ \ / __| |/ // _ \ __|
    | |_|  __|__ \ |_| | | (_) | (__|   <|  __/ |_
     \__|\___|___/\__|_|  \___/ \___|_|\_\\___|\__|

Testrocket is a super simple (as simple as it gets really) testing library for Ruby 2.0 and higher.

It was initially developed for [a CodeBrawl contest](http://codebrawl.com/articles/contest-rundown-ruby-testing-libraries) and it won! People asked me to release it 'for real' so here we are.

To install:

    gem install testrocket

.. or add it to your `Gemfile` in the usual way.

As yet there are no useful bits and pieces for creating test files (look at the example, it's easy!) or Rake tasks. But it's all crazy simple. A few things may be added later on.

Dependencies
------------

- Ruby 2.1 or higher
- minitest/spec (part of MRI 1.9+ standard library)

Example
-------

```ruby
require 'testrocket'

# BASIC USAGE
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
```

As well as running tests in separate test files in the 'traditional' way, TestRocket can also be used 'inline' with real world code. A trivial example:

```ruby
class YourClass
  def initialize
  end

  def does_something
    # ...
  end

  +->{  # a test for does_something goes here }

  def does_something_else
    # ...
  end

  +->{  # a test for does_something_else goes here }
  -->{  # a test for does_something_else goes here }
end
```

In this way, your class is tested each time you run the app in development or test modes. Note that if TestRocket detects `RACK_ENV` is `production`, `RAILS_ENV` is production or Rails is running and `Rails.env.production?` is true, the usual TestRocket methods will simply pass straight through so as to not impede performance on the loading of your app.

Other Features
--------------

By default, output is written to STDERR (as well as returned by the test expressions themselves). You can override where test output goes like so:

```ruby
TestRocket.out = File.new('/dev/null', 'w')
```

TestRocket.out also supports Logger instances.

Credits
-------

Initial concept and maintenance by Peter Cooper

Extra concepts and code by Christoph Grabo

Thanks to Gary Bernhardt for often praising and shining attention on TestRocket :-)
