module Acсessors
  def attr_accessor_with_history(*arguments)
    arguments.each do |argument|
      var_name = "@#{argument}".to_sym
      history = "@#{argument}_history"

      arr = []

      define_method(argument) { instance_variable_get(var_name) }
      define_method("#{argument}_history".to_sym) { instance_variable_get(history)}

      define_method("#{argument}=".to_sym) do |value| 
        instance_variable_set(var_name, value)
        instance_variable_set(history, arr.push(value))
      end
    end
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}"

    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
     if value.class.to_s != klass.to_s
      raise "Wrong type"
     end
     instance_variable_set(var_name, value)
    end
  end
end
