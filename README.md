# FatSecret OmniAuth Gem v0.0.2

First things first - This is NOT an [OmniAuth] Strategy. This is not meant to
be used as a Login method for web apps. This gem leverages OmniAuth's OAuth
Strategy to obtain __auth tokens__ and __auth secrets__, and to make calls to
the [FatSecret REST API].  

[OmniAuth]: https://github.com/intridea/omniauth "OmniAuth"   
[FatSecret REST API]: http://platform.fatsecret.com/api/Default.aspx?screen=rapih "FatSecret REST API"
 ___
## Installing

* Add the strategy to your `Gemfile`:

```
gem 'fatsecret-omniauth'
```
Then run `bundle install`

* Add the following to `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fatsecret, 'consumer_key', 'consumer_secret'
end
```

* Add your callback route in  `config/routes.rb`:  
```
get '/auth/fatsecret/callback', to: 'YOUR_CREATE_METHOD'
```  
__NOTE:__ *OmniAuth strategies use `get '/auth/:provider/callback', to: 'sessions#create'`.
The FatSecret OmniAuth gem requires a custom controller/create method to save the
auth tokens in a database for future API calls.*

 ___
## Authentication

To authenticate with FatSsecret, and obtain auth tokens:  

* Load `/auth/fatsecret` in your browser  
* You'll be redirected to FatSecret.com to authenticate  
* If you agree to authenticate, you'll be redirected back `/auth/fatsecret/callback`  
* The `request.env['omniauth.auth']` hash will contain your FatSecret data.  

    * __FatSecret profile data__ is contained in:  
    `request.env['omniauth.auth']['info']` -- see the [FatSecret profile.get page] for more details.
    
    * __FatSecret auth token and auth secret__ are contained in:  
    `request.env['omniauth.auth']['credentials']`

* Save the auth tokens to make future API calls for user data

[FatSecret profile.get page]: http://platform.fatsecret.com/api/Default.aspx?screen=rapiref&method=profile.get "FatSecret profile.get page"  

---
## API calls

The fatsecret-omniauth gem provides a simple way to make FatSecret API calls. Here's the structure of an API call:
```ruby
Fatsecret::Api.new({}).api_call(
  CONSUMER_KEY,
  CONSUMER_SECRET, 
  params, 
  auth_token,
  auth_secret
)`
```

CONSUMER_KEY and CONSUMER_SECRET are the keys FatSecret provided when you
signed up for an API account. The auth_token and auth_secret are optional, and
only needed when making calls to a user's Fatsecret account. The actual API
request data is contained in the params hash. Simply read the [FatSecret REST
API method docs] and supply the required parameters in the params hash. 

**NOTE** The following required parameters are automatically handled by the
gem: __oauth_signature_method, oauth_timestamp, oauth_nonce, oauth_version and
oauth_signature__. Also, you'll include your CONSUMER_KEY and CONSUMER_SECRET
with every API call, so __oauth_consumer_key__ is taken care of as well.

As an example, if you wanted to call the __foods.search__ API method, the first
thing you would do is look up __foods.search__ in the FatSecret API docs and
find out what are the required parameters. Aside from the automatic parameters
listed above, the only required parameter is  __method__, and it must be set to
"foods.search".

There are also several optional parameters: __format__, __oauth_token__,
__search_expression__, __page_number__, and __max_results__. Since the
__search_expression__ contains the actual search terms, we should include it.

If you had an apis_controller with a foods_search method, it might look like this:

```ruby
class ApisController < ApplicationController
  def foods_search
    params ||= {}
    params['method'] = 'foods.search'
    request = Fatsecret::Api.new({}).api_call(
      ENV['FATSECRET_KEY'], 
      ENV['FATSECRET_SECRET'], 
      params
    )   
    @response = request.body
  end
end
```

Now you can create a form with a __'search_expression'__ field that submits to
the __foods_search__ method of the apis_controller, and the FatSecret API will
return your results in @response.

[FatSecret REST API method docs]: http://platform.fatsecret.com/api/Default.aspx?screen=rapiref "FatSecret RESR API method docs"


---
Copyright (c) 2013 Scott McGrath. See [LICENSE] for details.

[LICENSE]: https://github.com/scrawlon/omniauth-fatsecret/blob/master/MIT-LICENSE "LICENSE"
