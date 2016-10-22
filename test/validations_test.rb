require 'test_helper'

class ValidationsTest < ActiveSupport::TestCase

  test 'methods' do
    with_models.each do |model|
      %i(complexity count time).each do |validator|
        method = "validates_#{validator}_of"
        assert model.respond_to?(method)
      end
    end
  end

  test 'complexity' do
    with_models{
      attr_accessor :password
      validates :password, complexity: true
    }.each do |model|
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
    with_models{
      attr_accessor :list
      validates :list, count: true
    }.each do |model|
      instance = model.new(list: nil)
      assert_not instance.valid?
      assert instance.errors.added?(:list, :uncountable)
    end

    with_models{
      attr_accessor :list
      validates :list, count: { within: 1..2 }
    }.each do |model|
      instance = model.new(list: [1, 2, 3])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_many)

      instance = model.new(list: [])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_few)

      instance = model.new(list: [1])
      assert instance.valid?
    end

    with_models{
      attr_accessor :list
      validates :list, count: { in: 1..2 }
    }.each do |model|
      instance = model.new(list: [1, 2, 3])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_many)

      instance = model.new(list: [])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_few)

      instance = model.new(list: [1])
      assert instance.valid?
    end

    with_models{
      attr_accessor :list
      validates :list, count: { maximum: 2 }
    }.each do |model|
      instance = model.new(list: [1, 2, 3])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_many)

      instance = model.new(list: [])
      assert instance.valid?
    end

    with_models{
      attr_accessor :list
      validates :list, count: { minimum: 1 }
    }.each do |model|
      instance = model.new(list: [])
      assert_not instance.valid?
      assert instance.errors.added?(:list, :too_few)

      instance = model.new(list: [1])
      assert instance.valid?
    end
  end

  test 'time' do
    with_models{
      attr_accessor :delivered_at
      validates :delivered_at, time: true
    }.each do |model|
      instance = model.new(delivered_at: nil)
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :not_a_time)
    end

    with_models{
      attr_accessor :delivered_at
      validates :delivered_at, time: { before: Proc.new { Date.today } }
    }.each do |model|
      instance = model.new(delivered_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :before)

      instance = model.new(delivered_at: (Time.now + 1.day))
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :before)

      instance = model.new(delivered_at: (Date.today - 1.day))
      assert instance.valid?
    end

    with_models{
      attr_accessor :delivered_at
      validates :delivered_at, time: { before_or_equal_to: Date.today }
    }.each do |model|
      instance = model.new(delivered_at: (Time.now + 1.day))
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :before_or_equal_to)

      instance = model.new(delivered_at: Date.today)
      assert instance.valid?

      instance = model.new(delivered_at: (Date.today - 1.day))
      assert instance.valid?
    end

    with_models{
      attr_accessor :processed_at, :delivered_at
      validates :delivered_at, time: { after: ->(instance) { instance.processed_at } }
    }.each do |model|
      instance = model.new(delivered_at: Date.today, processed_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :after)

      instance = model.new(delivered_at: (Date.today - 1.day), processed_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :after)

      instance = model.new(delivered_at: (Time.now + 1.day), processed_at: Date.today)
      assert instance.valid?
    end

    with_models{
      attr_accessor :processed_at, :delivered_at
      validates :delivered_at, time: { after_or_equal_to: :processed_at }
    }.each do |model|
      instance = model.new(delivered_at: (Date.today - 1.day), processed_at: Date.today)
      assert_not instance.valid?
      assert instance.errors.added?(:delivered_at, :after_or_equal_to)

      instance = model.new(delivered_at: Date.today, processed_at: Date.today)
      assert instance.valid?

      instance = model.new(delivered_at: (Date.today + 1.day), processed_at: Date.today)
      assert instance.valid?
    end
  end

  private

  def with_models(&block)
    record = Class.new(ActiveRecord::Base)
    model = Class.new do
      include ActiveModel::Model
    end
    if block_given?
      record.class_eval(&block)
      model.class_eval(&block)
    end
    [set_constant('Record', record), set_constant('Model', model)]
  end

  def set_constant(name, value)
    if self.class.const_defined?(name)
      self.class.send :remove_const, name
    end
    self.class.const_set(name, value)
  end

end
