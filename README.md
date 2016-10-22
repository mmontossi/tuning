[![Gem Version](https://badge.fury.io/rb/tuning.svg)](http://badge.fury.io/rb/tuning)
[![Code Climate](https://codeclimate.com/github/mmontossi/tuning/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/tuning)
[![Build Status](https://travis-ci.org/mmontossi/tuning.svg)](https://travis-ci.org/mmontossi/tuning)
[![Dependency Status](https://gemnasium.com/mmontossi/tuning.svg)](https://gemnasium.com/mmontossi/tuning)

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

## Views

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

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
