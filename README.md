# Working from:
* [Google Calendar API and Ruby on Rails](http://blog.baugues.com/google-calendar-api-oauth2-and-ruby-on-rails)
* [Get a Google OAuth2 Access Token via Ruby in minutes](http://jonathanotto.com/blog/google_oauth2_api_quick_tutorial.html)
* [GoogleDrive::login_with_oauth docs](http://gimite.net/doc/google-drive-ruby/GoogleDrive.html#method-c-login_with_oauth)
* [RailsCast #304 OmniAuth Identity](http://railscasts.com/episodes/304-omniauth-identity)

----

----

Pursued differently in student's own project, using [google-api-ruby-client](https://github.com/google/google-api-ruby-client)'s in-built refresh token machinery, like:

```ruby
def load_client
  @client = Google::APIClient.new
  @client.authorization.client_id     = ENV['GOOGLE_ID']
  @client.authorization.client_secret = ENV['GOOGLE_SECRET']
  @client.authorization.refresh_token = current_user.refresh_token
  @client.refresh!
  @client
end
```
