# Sprangular

[![Gem Version](https://badge.fury.io/rb/sprangular.svg)](http://badge.fury.io/rb/sprangular)
[![Build Status](https://api.travis-ci.org/DynamoMTL/sprangular.png)](https://travis-ci.org/DynamoMTL/sprangular)
[![Code Climate](https://codeclimate.com/github/DynamoMTL/sprangular.png)](https://codeclimate.com/github/DynamoMTL/sprangular)

Spree + Angular.js + Bootstrap

# [Live Demo](http://sprangular-demo.herokuapp.com)

## Features Overview

- Full Spree front-end
- Single page checkout
- 1-click checkout
- Product search with auto-complete
- Easy to override templates/controllers
- Easy to add new routes/controllers/templates
- Full Google Analytics support via [Angularytics](https://github.com/mgonto/angularytics)
- Variant selection by option type
- Cart dropdown/popover
- Lookup shipping & tax by zip code (Planned)
- Newsletter signup form (optional) via [spree_chimpy](https://github.com/DynamoMTL/spree_chimpy)
- Example rails app [DynamoMTL/sprangular-demo](https://github.com/DynamoMTL/sprangular-demo)

## Installing

Create a rails project

```
rails new <your-app-name>
cd <you-app-name>
```

Add `spree`, `sprangular` and rails-assets source in your `Gemfile`. (notice we dont use the `spree` umbrella gem, because it contains the generic `spree_frontend`)

```
source 'https://rails-assets.org'

spree_branch = '2-4-stable'

gem 'spree_core',        github: 'spree/spree',             branch: spree_branch
gem 'spree_api',         github: 'spree/spree',             branch: spree_branch
gem 'spree_backend',     github: 'spree/spree',             branch: spree_branch
gem 'spree_sample',      github: 'spree/spree',             branch: spree_branch
gem 'spree_gateway',     github: 'spree/spree_gateway',     branch: spree_branch
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: spree_branch
gem 'sprangular',        github: 'DynamoMTL/sprangular'
```

Minification is not yet supported, so remove or comment the `uglifier` gem in your `Gemfile`.

And in your `config/environments/production.rb`, comment out `js_compressor`:

```
# config.assets.js_compressor = :uglifier
```

Run bundler

```
bundle
```


Then install spree into your app

```
spree install --auto-accept
```

Then install sprangular:

```
rails generate sprangular:install [AngularModuleName]
```

You can pass the `--copy-templates` flag if you'd like all of Sprangular's templates copied to the host app's `app/assets/templates` dir.

The admin is mounted at http://localhost:3000/spree/admin

### Caching

#### Templates

By default templates are fetched on-demand. Templates in `app/assets/templates/layout` are cached in the first html response for increased speed.
You can add additional templates to be pre-cached, by setting `config.cached_paths`. Example:

```
# config/initializers/sprangular.rb
Sprangular::Engine.config.cached_paths += %w(products)
```

#### Data

Configure `cache_store` in your `config/environments/production.rb`

```ruby
config.action_controller.perform_caching = true
config.cache_store = :memory_store # or :dalli_store, :mem_cache_store
```

## Overriding

### Views

Copy any template from sprangular's source to the `app/assets/templates` directory in the host app. The host app's version always takes presidence.

### Controllers/Resources

Create a `app/assets/javascripts/sprangular/controllers` or `resources` directory, and copy the gem version of the script. The host app's version always takes presidence.

## Adding

### Routes

Edit your `app/assets/javascripts/sprangular/extraRoutes.coffee` and add the route. For example:

```
angular.module('MyApp').config ($routeProvider) ->

  $routeProvider
    .when '/about',
      template: '<h1>#1 Internet Site</h1>'
    .when '/privacy',
      templateUrl: 'content/privacy.html' # maps to app/assets/templates/content/privacy.html.slim
```

## Existing Stores

Sprangular configures Rack::Rewrite to provide a 301 redirect for your existing URLs. URLs like `/products` become `/#!/products`

## Events

The following events are emitted

- cart.add
- cart.empty
- account.login
- account.logout
- loading.start
- loading.end

```coffeescript
# show modal when item added to cart
$scope.$on 'cart.add', ->
  $scope.showModal = true
```

## Development

This gem contains a dummy spree app in the `spec/dummy` folder. You can use that to test out changes when modifying this gem. Just bootstrap the database and start the server:

```
cd spec/dummy
rake db:reset AUTO_ACCEPT=1 && rake spree_sample:load
rails server
```

### Testing

```
rake spec
```

If you want to see feature specs in browser (non-headless)

```
# requires firefox
WEBDRIVER=selenium rake spec
```

## License

MIT
