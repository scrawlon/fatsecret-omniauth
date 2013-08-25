# FatSecret OmniAuth Gem v0.0.2

First things first - This is NOT an [OmniAuth] Strategy. This is not meant to
be used as a Login method for web apps. This gem leverages OmniAuth's OAuth
Strategy to obtain __auth tokens__ and __auth secrets__, and to make calls to
the [FatSecret REST API].  

[OmniAuth]: https://github.com/intridea/omniauth "OmniAuth"   
[FatSecret REST API]: http://platform.fatsecret.com/api/Default.aspx?screen=rapih "FatSecret REST API"

---
## Installing

* Add the gem to your `Gemfile`:

```
gem 'fatsecret-omniauth'
```

* Run `bundle install`

---
## Authentication

* Add the following to `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fatsecret, 'consumer_key', 'consumer_secret'
end
```

You will need to sign up for a [Fatsecret API account]. You'll be issued
your own consumer_key and consumer_secret, which you should use in the
code above.

[FatSecret API account]: http://platform.fatsecret.com/api/ "FatSecret API account" 

* Add your callback route in  `config/routes.rb`:  

```
get '/auth/fatsecret/callback', to: 'YOUR_CONTROLLER#CREATE_METHOD'
```  

__NOTE:__ *OmniAuth strategies use `get '/auth/:provider/callback', to: 'sessions#create'`.
The FatSecret OmniAuth gem requires a custom controller#create method to save the
auth tokens in a database for future API calls. Also, you should place your fatsecret-omniauth
route above your other OmniAuth routes. Otherwise, your API calls will be routed to sessions#create.*

* __FOR EXAMPLE:__ If you had an ApiTokensController, you could use the following route:

    `get '/auth/fatsecret/callback', to: 'api_tokens#create'`


To authenticate with FatSecret, and obtain auth tokens:  

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

API calls are created with the `Fatsecret::Api.new({}).api_call()` method.
FatSecret consumer keys and a params hash containing
the api call are required. Optionally, you can include an auth_key and auth_secret for
authenticated calls.

The structure of an api call looks like this:

```ruby
Fatsecret::Api.new({}).api_call(
  CONSUMER_KEY,
  CONSUMER_SECRET, 
  params
)
```

The structure of an authenticated api call looks like this:

```ruby
Fatsecret::Api.new({}).api_call(
  CONSUMER_KEY,
  CONSUMER_SECRET, 
  params, 
  auth_token,
  auth_secret
)
```

The actual API
request data is contained in the params hash. Simply read the 
[FatSecret REST API method docs] and supply the required parameters in the params hash. 

[FatSecret REST API method docs]: http://platform.fatsecret.com/api/Default.aspx?screen=rapiref "FatSecret REST API method docs"

**NOTE** The following required parameters are automatically handled by the
gem: __oauth_signature_method, oauth_timestamp, oauth_nonce, oauth_version__ and
__oauth_signature__. Also, since consumer keys are required 
with every API call, __oauth_consumer_key__ is taken care of as well.

As an example, if you wanted to call the __foods.search__ API method, the first
thing you would do is look up __foods.search__ in the FatSecret API docs and
find the required parameters. Aside from the automatic parameters
listed above, the only required parameter is  __method__, and it must be set to
"foods.search".

There are also several optional parameters: __format__, __oauth_token__,
__search_expression__, __page_number__, and __max_results__. You can include
any of these as well. The __search_expression__ would contain the food(s) you're
searching for. 

If you had an apis_controller with a foods_search method, it might look like this:

```ruby
class ApisController < ApplicationController
  def foods_search
    params['method'] = 'foods.search'
    request = Fatsecret::Api.new({}).api_call(
      CONSUMER_KEY,
      CONSUMER_SECRET, 
      params
    )   
    @response = request.body
  end
end
```

Now you can create a form with a __'search_expression'__ field that submits to
the __foods_search__ method of the ApisController, and the FatSecret API will
return your results in @response.


* __FOR EXAMPLE:__  
    Assuming the ApisController mentioned above, and the following custom route:

    `get '/food_search', to: 'apis#food_search'`

    You could create the form below to allow users to search foods on FatSecret.com.

```ruby
<%= form_tag food_search_path, :method => "get" do %>
  <%= label_tag(:search_expression, "Search for food:") %>
  <%= text_field_tag(:search_expression) %>
  <%= submit_tag("Search") %>
<% end %> 
```

[FatSecret, you could use the following route: REST API method docs]: http://platform.fatsecret.com/api/Default.aspx?screen=rapiref "FatSecret RESR API method docs"


---
Copyright (c) 2013 Scott McGrath. See [LICENSE] for details.

[LICENSE]: https://github.com/scrawlon/omniauth-fatsecret/blob/master/MIT-LICENSE "LICENSE"
