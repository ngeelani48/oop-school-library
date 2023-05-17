require './nameable'
class Person < Nameable
  attr_accessor :name, :age, :id

  def initialize(age, name = 'unknown', parent_permission: true)
    super(name)
    @id = Random.rand(1...1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end
