# Net::Http::Middleware

Middlewares for Net::HTTP request method.

## Usage

There are couple of requirements for middleware to be implemented
1. Chain as a first argument for initializer of your middleware
2. 2 params for call: Request-object and body to be passed to call
3. Return the result of @chain.call(req, body)

```ruby
# Example of tracer, which will add header to each outgoing request
class OpenTraceId
  def initialize(chain)
    @chain = chain
  end

  def call(req, body = nil)
    request.add_field('X-Custom-CrossService-RequestId', SecureRandom.uuid)
    @chain.call(req, body)
  end
end

# Example of Loging for 
class LogRequest
  def initialize(chain, logger)
    @chain = chain
    @logger = logger
  end

  def call(req, body = nil)
    @logger.info('We log before')
    response = @chain.call(req, body)
    @logger.info('We log after')
    response
  end
end

# Adding middlewares to configurator
Net::HTTP.configure_middleware do |chain|
  chain.use LogRequest, Logger.new(STDOUT)
  chain.use OpenTraceId
end
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'net-http-middleware'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install net-http-middleware

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/net-http-middleware.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
