[![Gem Version](https://badge.fury.io/rb/tuning.svg)](http://badge.fury.io/rb/tuning) [![Code Climate](https://codeclimate.com/github/museways/tuning/badges/gpa.svg)](https://codeclimate.com/github/museways/tuning) [![Build Status](https://travis-ci.org/museways/tuning.svg?branch=0.2.3)](https://travis-ci.org/museways/tuning)

# Tuning

Common tools used in rails extracted into a gem.

## Install

Put this line in your Gemfile:
```ruby
gem 'tuning'
```

Then bundle:
```
$ bundle
```

## Controllers

Use error method to respond with status 500 and show 500.html (if format it's html) in your controller:
```ruby
error
```

Use not_found to respond with status 404 and show 404.html (if format it's html) in your controller:
```ruby
not_found
```

Use unauthorized to respond with status 401 and show 422.html (if format it's html) in your controller:
```ruby
unauthorized
```

Use forbidden to respond with status 403 and show 422.html (if format it's html) in your controller:
```ruby
forbidden
```

Use unprocessable_entity to respond with status 422 and show 422.html (if format it's html) in your controller:
```ruby
unprocessable_entity
```

NOTE: If any exception is raised, error will be called to force debug information in development.

## Views

Use seo_options to customize the options of the title, description and keywords:
```erb
<% seo_options name: @record.name %>
```

Use content_tag_if if you want wrap content into some tag if certain condition it's true:
```erb
<%= content_tag_if request.path == home_path, :h1 do %>
  <%= link_to 'Home', home_path, id: 'logo' %>
<% end %>
```

Use active_trail? if you want to check if some path is on active trail:
```erb
<li class="<%= 'active' if active_trail? some_path %>"></li>
```

The method submit_tag outputs a button with span inside:
```html
<button name="commit" value="submit">
  <span>Send</span>
</button>
```

NOTE: For each template @title, @description and @keywords will be set using lazy loaders.

## Credits

This gem is maintained and funded by [museways](http://museways.com).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
