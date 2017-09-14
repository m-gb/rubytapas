require 'open-uri'
require 'json'
class Weather
  Report = Struct.new(:temperature)

  def initialize(options={})
    @cache = options.fetch(:cache){ {} }
  end

  def report(query)
    key  = ENV['WUNDERGROUND_KEY']
    url  = "http://api.wunderground.com/api/#{key}/conditions/q/#{query}.json"
    body = @cache.fetch(query) {
      @cache[query] = open(url).read # using a Ruby Hash as the model for the cache interface.
    }
    data = JSON.parse(body)
    Report.new(data['current_observation']['temp_f'])
  end
end

require 'rspec/autorun'
require 'webmock/rspec'
describe Weather do
  describe '#report' do
    it 'populates the cache with new values' do
      json = '{ "current_observation": { "temp_f": -60.0 } }'
      expected_url =
        %r(http://api.wunderground.com/api/.*/conditions/q/17361.json)
      stub_request(:get, expected_url).to_return(body: json)
      cache = {}
      weather = Weather.new(cache: cache)
      weather.report('17361')
      cache['17361'].should eq(json)
    end
  end
end

# it updates the cache after making a request.
