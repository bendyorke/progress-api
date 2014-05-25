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
      relationship = define_relationship_for current_user
      relationship.read self, config_attribute, key.to_s, current_user
    end

    def write_config_attribute config_attribute, key, value, current_user
      relationship = define_relationship_for current_user
      relationship.write self, config_attribute, key.to_s, value.to_s, current_user
    end

  private
    def define_relationship_for current_user_id
      current_user_id == user_id ? Owner : Follower
    end

    class Accessor
      def self.read object, attribute, key
        object.public_send(attribute)[key]
      end
      def self.write object, attribute, key, value
        if value != Accessor.read(object, attribute, key)
          object.public_send :"#{attribute}_will_change!"
          object.public_send(attribute)[key] = value
          object.public_send :"#{attribute}_has_changed!"
        end
      end
    end

    class Owner < Accessor
      def self.read *args
        super *args[0..-2]
      end
      def self.write *args
        super *args[0..-2]
      end
    end

    class Follower < Accessor
      def self.read object, attribute, key, current_user

      end
      def self.read object, attribute, key, value, current_user

      end
    end
end
