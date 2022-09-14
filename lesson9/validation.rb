module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(name, validation_type, validation_param = nil)
      options = {
        name: name, validation_type: validation_type, validation_param: validation_param
      }
      instance_variable_set(:@validations, validations << options)
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |options| 
        name, validaton_type, optional_parameter = options.values
        value = instance_variable_get("@#{name}".to_sym)

        case validaton_type
        when :presence
          raise ArgumentError, 'Должно быть название или номер!' if value.nil? || value.to_s.empty?
        when :format
          raise ArgumentError, 'Неверный формат!' unless value =~ optional_parameter
        when :type
          raise TypeError, 'Неверный тип!' unless value.is_a?(optional_parameter)
        end
      end
    end
  end
end
