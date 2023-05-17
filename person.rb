require_relative './nameable'
require_relative './capitalize_decorator'
require_relative './trimmer_decorator'
class Person < Nameable
  attr_accessor :name, :age, :id

  def initialize(age:, name: 'Unknown', parent_permission: true)
    super()
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

person = Person.new(age: 22, name: 'maximilianus')
puts person.correct_name
capitalized_person = CapitalizeDecorator.new(nameable: person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(nameable: capitalized_person)
puts capitalized_trimmed_person.correct_name
