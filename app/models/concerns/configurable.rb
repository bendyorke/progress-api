module Configurable
  extend ActiveSupport::Concern

  included do
    class_attribute :config_attributes, instance_accessor: false
    self.config_attributes = {}
  end

  module ClassMethods
    def config_accessor config_attribute, *keys
      keys = keys.flatten

      _config_accessors_module.module_eval do
        keys.each do |key|
          define_method(key) do |**args|
            read_config_attribute config_attribute, key, args[:user_id]
          end

          define_method("#{key}=") do |**args|
            write_config_attribute config_attribute, key, args[:value], args[:user_id]
          end
        end
      end

      define_method("#{config_attribute}_has_changed!") do
        self.send(config_attribute).reject! do |_,v|
          v.empty?
        end
      end

      self.config_attributes = {} if self.config_attributes.blank?
      self.config_attributes[config_attribute] ||= []
      self.config_attributes[config_attribute] |= keys
    end

    def _config_accessors_module
      @_config_accessors_module ||= begin
        mod = Module.new
        include mod
        mod
      end
    end
  end

  protected
    def read_config_attribute config_attribute, key, current_user
      ConfigAccessor.read self, config_attribute, key.to_s, current_user
    end

    def write_config_attribute config_attribute, key, value, current_user
      ConfigAccessor.write self, config_attribute, key.to_s, value.to_s, current_user
    end

  private
    class ConfigAccessor
      def self.read object, attribute, key
        object.public_send(attribute)[key]
      end
      def self.write object, attribute, key, value
        if value != ConfigAccessor.read(object, attribute, key)
          object.public_send :"#{attribute}_will_change!"
          object.public_send(attribute)[key] = value
          object.public_send :"#{attribute}_has_changed!"
        end
      end
    end
end
