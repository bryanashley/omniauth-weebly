# Weebly OmniAuth Strategy

This gem provides a simple way to authenticate to Weebly Web API using OmniAuth with OAuth2.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-weebly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-weebly

## Usage

You'll need to register an app on Weebly, you can do this here - https://weebly.com/developer-admin

Usage of the gem is very similar to other OmniAuth strategies.
You'll need to add your app credentials to `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weebly, 'app_id', 'app_secret', scope: 'read:site,write:site'
end
```

Please replace the example `scope` provided with your own.
Read more about scopes here: https://dev.weebly.com/about-rest-apis.html

Or with Devise in `config/initializers/devise.rb`:

```ruby
config.omniauth :weebly, 'app_id', 'app_secret', scope: 'read:site,write:site'
```

## Auth Hash Schema

Here's an example auth hash, available in `request.env['omniauth.auth']`:


```ruby
{
  :provider => "weebly",
  :uid => "1111111111",
  :email => "bryan@weebly.com",
  :language => "en"
  :name => "Bryan Ashley"
}

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request