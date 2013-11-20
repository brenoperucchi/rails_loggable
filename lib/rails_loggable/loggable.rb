module RailsLoggable
  module Model

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def loggable(options = {})
        send :include, InstanceMethods

        class_attribute :loggable_class_name
        self.loggable_class_name = options[:class_name] || 'RailsLoggable::Log'

        class_attribute :loggable_association_name 
        self.loggable_association_name = options[:association_name] || :logs

        class_attribute :loggable_options_log_attributes
        self.loggable_options_log_attributes = {:id => "id"}
        
        class_attribute :loggable_options
        self.loggable_options = options.dup

        [:ignore, :log_attributes].each do |k|
          loggable_options[k] = [loggable_options[k]].flatten.compact.map { |attr| attr.is_a?(Hash) ? attr.stringify_keys : attr.to_sym }
        end

        before_update :loggable_update
        after_create :loggable_create

        #Active ActiveRecord to Plugin
        has_many self.loggable_association_name,
          :class_name => self.loggable_class_name, :as => :loggable

        def i18n_description(klass, *params)
          message, before, after = *params
          attrs  = if message == :loggable_update
                      {model: klass.class.name.to_underscore, :before => before.join(', '), :after => after.join(', '),
                      scope:[:rails_loggable]} 
                    else
                      {model: klass.class.name.to_underscore, scope:[:rails_loggable]}
                    end
          loggable_options[:log_attributes].each do |k|
            attrs.merge!(k => klass.send(loggable_options_log_attributes[k]))
          end
          I18n.t(message, attrs)
        end
      end
    end

    module InstanceMethods
      def loggable_update
          if changed?
            before, after = [], []
            attrs = changes
            loggable_options[:ignore].each{|k| attrs.delete(k)}
            attrs.keys.each do |attr|          
              next if changes[attr].first.blank? && changes[attr].second.blank?
              attribute_t = I18n.t('activerecord.attributes.' + self.class.name.to_underscore + '.' + attr)
              before << "#{attribute_t}: #{changes[attr].first}"
              after << "#{attribute_t}: #{changes[attr].second}"
            end
            Log.logger(self, self.class.i18n_description(self, :loggable_update, before, after))
          end
      end

      def loggable_create
        Log.logger(self, self.class.i18n_description(self, :loggable_create))
      end
    end
  end
end