module InstanceCounter
  attr_writer :instances

  # возвращает кол-во экземпляров класса
  def instances
    @instances ||= 0
  end

  protected

  # увеличивает счетчик экземпляров класса
  def register_instances
    self.instances ||= 0
    self.instances += 1
  end
end
