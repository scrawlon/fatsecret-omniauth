# FatSecret OmniAuth Gem

First things first - This is NOT an [OmniAuth] Strategy. This is not meant to be used as a Login 
method for web apps. This gem leverages OmniAuth's OAuth Strategy to obtain __auth tokens__ and 
__auth secrets__ for use with the [FatSecret REST API].  

[OmniAuth]: https://github.com/intridea/omniauth "OmniAuth"   
[FatSecret REST API]: http://platform.fatsecret.com/api/Default.aspx?screen=rapih "FatSecret REST API"
 ___
## Installing

Add the strategy to your `Gemfile`:
```
gem 'fatsecret-omniauth'
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

__NOTE:__ Add your callback route in  `config/routes.rb`:  
```
provider :fatsecret, :callback_path => "YOUR_PATH_HERE"  
```  
*This is different than the normal OmniAuth callback route*  

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

