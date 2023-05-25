require 'rspec'
require_relative '../classroom'
require_relative '../student'

RSpec.describe Classroom do
  let(:classroom) { described_class.new('Class A') }

  describe '#initialize' do
    it 'creates a new classroom with a label' do
      expect(classroom.label).to eq('Class A')
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      student = Student.new(15, 'John Doe', classroom)
      classroom.add_student(student)
      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
