require 'helper'
require 'rack/test'
require 'delayed_job_mongoid_web/application/app'

ENV['RACK_ENV'] = 'test'
require 'delayed_job_mongoid'


Mongoid.configure do |config|
  config.connect_to("dl_spec")
end

class TestDelayedJobWeb < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
    DelayedJobMongoidWeb.new
  end

  def should_respond_with_success
    assert last_response.ok?, last_response.errors
  end

  # basic smoke test all the tabs
  %w(overview enqueued working pending failed stats).each do |tab|
    should "get '/#{tab}'" do
      get "/#{tab}"
      should_respond_with_success
    end
  end
end
