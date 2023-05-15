require './person'

class Student < person
  def initialize(classroom)
    super()
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
