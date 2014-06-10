require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |file| require file }
  Dir[Rails.root.join("spec/helpers/*.rb")].each     { |file| require file }

  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"

    # You shall not call FactoryGirl
    config.include FactoryGirl::Syntax::Methods

    config.include ControllerSpecHelpers, :type => :controller

    config.before(:each, auth: :skip) { authenticate }

  end
end

Spork.each_run do
  FactoryGirl.reload
end
