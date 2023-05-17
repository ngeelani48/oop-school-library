include './nameable'
class BaseDecorator < Nameable
  attr_accessor :nameable

  def intialize(nameable)
    super(nameable.name)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
