require 'test_helper'

class ValidationsTest < ActiveSupport::TestCase

  MODELS = [User, Session]

  test 'methods' do
    MODELS.each do |model|
      %i(complexity count time).each do |validator|
        method = "validates_#{validator}_of"
        assert model.respond_to?(method)
      end
    end
  end

  test 'complexity' do
    with_validation(
      :password, complexity: true
    ) do |model|
      instance = model.new(password: nil)
      assert_not instance.valid?

      instance = model.new(password: 'aaaa')
      assert_not instance.valid?
      assert instance.errors.added?(:password, :too_easy)

      instance = model.new(password: 'aaAA33__')
      assert instance.valid?
    end
  end

  test 'count' do
    with_validation(
      :list, count: true
    ) do |model|
      instance = model.new(list: nil)
      assert_not instance.valid?
      assert instance.errors.added?(:list, :uncountable)
    end

    with_validation(
      :list, count: { within: 1..2 }
    ) do |model|
      instance = model.new(list: [1, 2, 3])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_many)

      instance = model.new(list: [])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_few)

      instance = model.new(list: [1])
      assert instance.valid?
    end

    with_validation(
      :list, count: { in: 1..2 }
    ) do |model|
      instance = model.new(list: [1, 2, 3])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_many)

      instance = model.new(list: [])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_few)

      instance = model.new(list: [1])
      assert instance.valid?
    end

    with_validation(
      :list, count: { maximum: 2 }
    ) do |model|
      instance = model.new(list: [1, 2, 3])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_many)

      instance = model.new(list: [])
      assert instance.valid?
    end

    with_validation(
      :list, count: { minimum: 1 }
    ) do |model|
      instance = model.new(list: [])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_few)

      instance = model.new(list: [1])
      assert instance.valid?
    end
  end

  test 'time' do
    with_validation(
      :created_at, time: true
    ) do |model|
      instance = model.new(created_at: nil)
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :not_a_time)
    end

    with_validation(
      :created_at, time: { before: Proc.new { Date.today } }
    ) do |model|
      instance = model.new(created_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :before)

      instance = model.new(created_at: (Time.now + 1.day))
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :before)

      instance = model.new(created_at: (Date.today - 1.day))
      assert instance.valid?
    end

    with_validation(
      :created_at, time: { before_or_equal_to: Date.today }
    ) do |model|
      instance = model.new(created_at: (Time.now + 1.day))
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :before_or_equal_to)

      instance = model.new(created_at: Date.today)
      assert instance.valid?

      instance = model.new(created_at: (Date.today - 1.day))
      assert instance.valid?
    end

    with_validation(
      :created_at, time: { after: ->(instance) { instance.updated_at } }
    ) do |model|
      instance = model.new(created_at: Date.today, updated_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :after)

      instance = model.new(created_at: (Date.today - 1.day), updated_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :after)

      instance = model.new(created_at: (Time.now + 1.day), updated_at: Date.today)
      assert instance.valid?
    end

    with_validation(
      :created_at, time: { after_or_equal_to: :updated_at }
    ) do |model|
      instance = model.new(created_at: (Date.today - 1.day), updated_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:created_at, :after_or_equal_to)

      instance = model.new(created_at: Date.today, updated_at: Date.today)
      assert instance.valid?

      instance = model.new(created_at: (Date.today + 1.day), updated_at: Date.today)
      assert instance.valid?
    end
  end

  private

  def with_validation(*args)
    MODELS.each do |model|
      model.validates *args
      yield model
      model.clear_validators!
    end
  end

end
