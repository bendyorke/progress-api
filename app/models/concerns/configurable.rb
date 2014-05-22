module Configurable
  extend ActiveSupport::Concern

  module ClassMethods
    def config_accessor field_name, *keys
      keys.each do |key|
        # Getter
        define_method(key) do |**args|
          if owner_of_configurable? args[:user_id]
            (self.send field_name)[key.to_s]
          else
          end
        end

        # Setter
        define_method("#{key}=") do |**args|
          if owner_of_configurable? args[:user_id]
            if args[:value].nil? || args[:value].empty?
              self.send "clear_#{key}!", args
            else
              merged_hash =  (self.send field_name).merge(Hash[key.to_s, args[:value].to_s])
              self.send "#{field_name}=", merged_hash
            end
          else
          end
        end

        # Reset hstore
        define_method("clear_#{key}!") do |**args|
          if owner_of_configurable? args[:user_id]
            cleared_hash = (self.send field_name).except key.to_s
            self.send "#{field_name}=", cleared_hash
          else
          end
        end
      end
    end
  end

  private

    def owner_of_configurable? current_user_id
      current_user_id == user_id
    end
end
