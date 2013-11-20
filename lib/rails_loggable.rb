require 'rails_loggable/config'
require 'rails_loggable/loggable'

module RailsLoggable
  def self.enabled=(value)
    RailsLoggable.config.enabled = value
  end  

  def self.enabled?
    !!RailsLoggable.config.enabled 
  end

  def self.config
    @@config ||= RailsLoggable::Config.instance
  end

  require 'rails_loggable/log'

  # Require frameworks
  # require 'rails_loggable/frameworks/rails'
  # require 'rails_loggable/frameworks/sinatra'
  # require 'rails_loggable/frameworks/rspec' if defined? RSpec
  # require 'rails_loggable/frameworks/cucumber' if defined? World

  ActiveSupport.on_load(:active_record) do
    include RailsLoggable::Model
  end

  # if defined?(ActionController)
  #   ActiveSupport.on_load(:action_controller) do
  #     include RailsLoggable::Rails::Controller
  #   end
  # end

end
