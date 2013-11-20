require 'active_support/concern'

module RailsLoggable
  module LogConcern
    extend ActiveSupport::Concern
    included do
      belongs_to :loggable, :polymorphic => true
      belongs_to :user
      # belongs_to :store
    end
      
    module ClassMethods
      def logger(record, description)
        current_user = User.current unless User.current.nil?
        # current_user ||= record.user rescue nil
        # current_store = Store.current unless current_store.nil?
        # current_store ||= current_user.store rescue nil    
        record.logs.create(:user => current_user, :description => description)
      end                
    end
  end

  class Log < ::ActiveRecord::Base
    include LogConcern
  end
end