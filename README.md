# OmniAuth FatSecret Strategy

This gem is an [OmniAuth] - [OAuth 1.0+] Strategy for the [FatSecret REST API]

[FatSecret REST API]: http://platform.fatsecret.com/api/Default.aspx?screen=rapih "FatSecret REST API"
[OmniAuth]: https://github.com/intridea/omniauth "OmniAuth"
[OAuth 1.0+]: https://github.com/pelle/oauth "OAuth 1.0+"

___
## Caveat

A basic requirement for OmniAuth strategies is obtaining user names and user ids
from API providers. Unfortunately, FatSecret doesn't provide either. Instead,
FatSecret returns users' physical data profiles: height, weight, goal weight,
etc. Furthermore, none of this data can be stored for more than 24 hours, as
per the [Developer Terms of Service]. 

Rather than authentication, the best use of this gem is to obtain 
__auth_tokens__ and __auth_secrets__ from FatSecret. Use these to make API
requests on users' behalf.

[Developer Terms of Service]: http://platform.fatsecret.com/api/Default.aspx?screen=rapisd "Developer Terms of Service"  
 
 ___
## Installing

Add the strategy to your `Gemfile`:
```
gem 'omniauth-fatsecret'
```
Then run `bundle install`

 ___
## Usage
Add the following to your middleware in `config/initializers/omniauth.rb`:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fatsecret, 'consumer_key', 'consumer_secret'
end
```

Now, configure `/auth/:provider` as per the [OmniAuth] guide.
When your app calls FatSecret and the user authorizes, the `request.env['omniauth.auth']` 
hash will contain your user data.  

* __FatSecret profile data__ is contained in:  
`request.env['omniauth.auth']['info']` -- see the [FatSecret profile.get page] for more details.

* __FatSecret auth token and auth secret__ are contained in:  
`request.env['omniauth.auth']['credentials']`

[FatSecret profile.get page]: http://platform.fatsecret.com/api/Default.aspx?screen=rapiref&method=profile.get "FatSecret profile.get page"  

---
Copyright (c) 2013 Scott McGrath. See [LICENSE] for details.

[LICENSE]: https://github.com/scrawlon/omniauth-fatsecret/blob/master/MIT-LICENSE "LICENSE"
