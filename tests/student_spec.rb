require 'rspec'
require_relative '../student'
require_relative '../person'

RSpec.describe Student do
  let(:classroom) { double('Classroom', students: []) }
  let(:student) { described_class.new(16, 'Amir', classroom) }

  describe '#initialize' do
    it 'creates a new student with age, name, classroom, and parent permission' do
      expect(student.age).to eq(16)
      expect(student.name).to eq('Amir')
      expect(student.classroom).to eq(classroom)
      expect(student.parent_permission).to be(true)
    end
  end

  describe '#play_hooky' do
    it 'returns the play hooky message' do
      expect(student.play_hooky).to eq('¯(ツ)/¯')
    end
  end

  describe '#classroom=' do
    let(:classroom) { double('Classroom', students: []) }
    let(:other_classroom) { double('Other Classroom', students: []) }

    it 'changes the student\'s classroom' do
      student.classroom = other_classroom
      expect(student.classroom).to eq(other_classroom)
    end

    it 'adds the student to the new classroom' do
      student.classroom = other_classroom
      expect(other_classroom.students).to include(student)
    end

    it 'does not add the student to the same classroom again' do
      student.classroom = classroom
      expect(classroom.students).to include(student)

      student.classroom = classroom
      expect(classroom.students.count(student)).to eq(1)
    end
  end
end
