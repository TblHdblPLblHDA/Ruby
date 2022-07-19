module InstanceCounter
  attr_writer :instances

  def instances  #возвращает кол-во экземпляров класса
    @instances ||= 0
  end

  protected

  def register_instances #увеличивает счетчик экземпляров класса
    self.instances ||= 0
    self.instances += 1
  end
end
