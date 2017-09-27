[![Gem Version](https://badge.fury.io/rb/tuning.svg)](http://badge.fury.io/rb/tuning)
[![Code Climate](https://codeclimate.com/github/museways/tuning/badges/gpa.svg)](https://codeclimate.com/github/museways/tuning)
[![Build Status](https://travis-ci.org/museways/tuning.svg)](https://travis-ci.org/museways/tuning)
[![Dependency Status](https://gemnasium.com/museways/tuning.svg)](https://gemnasium.com/museways/tuning)

# Tuning

Common tools used in rails extracted into a gem.

## Why

I did this gem to:

- Make features I commonly need work nice together.
- Have an extensible container to continue adding new general purpose tools.

## Install

Put this line in your Gemfile:
```ruby
gem 'tuning'
```

Then bundle:
```
$ bundle
```

## Usage

### Controllers

New callbacks before, after, around render are available:
```ruby
class ProductsController < ApplicationController

  before_action :set_product
  before_render :prepare_product

  def edit
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def prepare_product
    @product.build_picture
  end

end
```

### Mailers

Text email templates will normalize spaces and new lines like html:
```erb
<% if @order.confirmed? %>
  Your order has been confirmed.

  Will be delivered right the way.
<% end %>
```

Will produce:
```
Your order has been confirmed.

Will be delivered right the way.
```

### Views

New content_tag_if method to wrap content into some tag if certain condition it's true:
```erb
<%= content_tag_if request.path == home_path, :h1 do %>
  <%= link_to 'Home', home_path, id: 'logo' %>
<% end %>
```

New active_trail? method to check if some path is on active trail:
```erb
<li class="<%= 'active' if active_trail? some_path %>"></li>
```

New extending method to extend layouts:
```erb
<%= extending :application do %>
  <p>content</p>
<% end %>
```

### Template Handlers

Ruby template handlers will automatically call to_json or to_xml:
```ruby
@users.map do |user|
  user.slice :name
end
```

### Records

Empty strings will be nilify in the database to avoid sql errors or complex queries:
```ruby
shop = Shop.new(name: '')
shop.save
shop.name # Will be nil
```

New method validate is available to allow a more expressive syntax:
```ruby
record.validate
```

### Validations

New complexity validator to avoid weak passwords:
```ruby
class User < ActiveRecord::Base
  validates_complexity_of :password
end
```

New time validator to validate Date/Time using after, after_or_equal_to, before or before_or_equal_to:
```ruby
class Schedule < ActiveRecord::Base
  validates_time_of :opens_at
  validates_time_of :closes_at, after: :opens_at
end
```

New count validator to express count messages using minimum, maximum, in o within:
```ruby
class Product < ActiveRecord::Base
  validates_count_of :pictures, minimum: 1, maximum: 4
end
```

NOTE: Take a look at lib/tuning/locales to know the i18n keys.

## Contributing

Any issue, pull request, comment of any kind is more than welcome!

I will mainly ensure compatibility to Rails, AWS, PostgreSQL, Redis, Elasticsearch and FreeBSD 

## Credits

This gem is maintained and funded by [museways](https://github.com/museways).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
