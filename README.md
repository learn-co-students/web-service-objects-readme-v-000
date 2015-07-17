# Service Objects

## Using Service Objects

Congrats on getting your GitHub Repos page to work! Unfortunately, we have a bunch of API calls in our controllers, and we want to keep our controllers simple and "skinny" – so let's refactor our code to push these calls further down. Enter: __service objects__.

According to a [post by Tom Pewiński in Ruby Weekly](https://netguru.co/blog/service-objects-in-rails-will-help):

> As I understand it, a Service Object implements the user’s interactions with the application. It contains business logic that coordinates other artefacts. You could say it is the core of the application.

We're going to use service objects to execute all of our interactions with the external GitHub API.

## Refactoring Authentication

#### Object Setup

Currently, your `SessionsController` `create` action looks something like this:

```ruby
def create
  response = Faraday.post "https://github.com/login/oauth/access_token",
      client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],
      code: params[:code]}, {'Accept' => 'application/json'}
  access_hash = JSON.parse(response.body)
  session[:token] = access_hash["access_token"]
```

Create the folder `app/services` and create a file `github_service.rb` within that folder. In `github_service.rb`, define a class `GithubService`:

```ruby
# app/services/github_service.rb

class GithubService
end
```

Now, let's move the API interaction from `SessionsController` into `GithubService`. Define a method in `GithubService` called `#authenticate!`. Our arguments will be the client ID, client secret, and code that we need to authenticate with GitHub. The method `#authenticate!` ends up looking like this:

```ruby
def authenticate!(client_id, client_secret, code)
  response = Faraday.post "https://github.com/login/oauth/access_token",
      {client_id: client_id, client_secret: client_secret, code: code},
      {'Accept' => 'application/json'}
  access_hash = JSON.parse(response.body)
  @access_token = access_hash["access_token"]
end
```

Looks very familiar. Think about why we're storing our access token in an instance variable instead of the session. We want our `GithubService` to be an [idempotent](https://en.wikipedia.org/wiki/Idempotence) object – two instances of a `GithubService` with similar attributes should behave similarly. In other words, the behavior of a service object shouldn't depend on the state of the application.

#### Back to the Controller

Now that we've started to set up our `GithubService` object, what do we need to do in our `SessionsController`? Instantiate a new `GithubService` object and call our `#authenticate!` method!

```ruby
def create
  service = GithubService.new
  service.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
  session[:service] = service

  redirect_to '/'
end
```

When we save our `GithubService` object to `session[:service]`, it gets saved as a hash representing the object's attributes. In this case, the hash looks like: `{"access_token"=>"youraccesstoken12345abcde"}`.

We definitely don't want to re-authenticate with GitHub every time we hit a controller action. So you'll need to write `#initialize` such that `GithubService.new` can be called both with and without a hash as an argument.