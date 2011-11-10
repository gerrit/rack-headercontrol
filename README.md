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
  
  # Serve CORS headers for webfonts to enable them in Firefox
  change.path %r{\.(woff|ttf|otf)$} do |headers|
    headers['Access-Control-Allow-Origin'] = '*'
  end
  
  # Set far-future expires headers for versioned assets
  change.path %r{/style/longlived\.(.?)\.css} do |headers|
    expires_at = 10.years.from_now.utc
    max_age = (expires_at - Time.now).floor
    headers['Expires'] = expires_at.rfc2822
    headers['Cache-Control'] = "public, max-age=#{max_age}"
    # Best practice not to send Etags /w far-future expiring assets
    headers.delete('Etag')
    headers.delete 'Pragma'
    headers.delete 'Last-Modified'
  end
end
```
