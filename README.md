#Rack::HeaderControl

Rack Middleware that allows you set/override response headers for selected paths

If you want to set headers for all responses, have a look at 
Rack::ResponseHeaders from rack-contrib

Conditions can be set using strings or regexes. It will execute the passed
block for every condition that matches

##Usage

```ruby
use Rack::HeaderControl do |change|
  change.path '/tralala' do |headers|
    headers['X-Foo'] = 'bar'
  end
  change.path /./ do |headers|
    headers.delete('X-Baz')
  end
end
```
