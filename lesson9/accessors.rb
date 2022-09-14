module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      name.each do |name|
        history_var = "@#{name}_history".to_sym
        var_name = "@#{name}".to_sym

        define_method(name) { instance_variable(var_name) }

        history = instance_variable_get(history_var) || []

        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          history << value
          instance_variable_set(history_var, history)
        end
        define_method("#{name}_history") {instance_variable_get(history_var)}
      end
    end
  end
  
  module InstanceMethods
    def strong_attr_accessor(attribute, klass)
      name = "@#{attribute}".to_sym
      define_method(attribute) { instance_variable_get(name) }
      define_method("#{attribute}=".to_sym) do |value|
        raise "#{value} должно быть класса #{klass}" unless value.is_a?(klass)
        instance_variable_set(name, value)
      end
    end
  end
end
