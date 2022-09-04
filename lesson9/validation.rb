module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, validation_type, option = nil)
      args = args[0]
      @validations ||= []
      @validations.push(attr_name: attr_name, validation_type: validation_type, options: args)

      def validations
        @validations
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = self.send(validation[:attr_name])

        case validation[:validation_type]
        when :presence
          raise "@#{value} is empty or nil." if value.nil? || value.to_s.empty?
        when :type
          raise "Wrong type of @#{value}." unless value.is_a? validation[:options]
        when :format
          raise "Wrong format of @#{value}." unless value.match?(validation[:options])
        end
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
