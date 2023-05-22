require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './book'
require_relative './person'
require_relative './welcome'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  @start = Welcome.new

  def display_books
    if @books.empty?
      puts 'No books found'
    else
      @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    end
  end

  def display_people
    if @people.empty?
      puts 'No people found'
    else
      @people.each do |person|
        puts "[#{person[0]}]Name: #{person[1].name}, ID: #{person[1].id}, Age: #{person[1].age}"
      end
    end
  end

  def add_student
    print 'Age: '
    age = gets.chomp

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    print 'What is the student\'s classroom: '
    classroom = gets.chomp

    student = Student.new(age, name, classroom, parent_permission: permission)
    @people.push(['Student', student])
  end

  def add_teacher
    print 'Age: '
    age_input = gets.chomp

    print 'Name: '
    name_input = gets.chomp

    print 'Specialization: '
    specialization_input = gets.chomp

    teacher = Teacher.new(specialization_input, age_input, name_input)
    @people.push(['Teacher', teacher])
  end

  def add_new_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp
    if type == '1'
      add_student
      puts 'Person created successfully!!'
    elsif type == '2'
      add_teacher
      puts 'Person created successfully!!'
    else
      puts 'Incorrect choice'
    end
  end

  def create_book
    print 'Title : '
    title_input = gets.chomp

    print 'Author : '
    author_input = gets.chomp

    book = Book.new(title_input, author_input)
    @books.push(book)
    puts 'Book created successfully!!'
  end

  def rent_book
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}' , Author: #{book.author}"
    end
    book_choice = gets.chomp

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person[0]}]Name: #{person[1].name}, ID: #{person[1].id}, Age: #{person[1].age}"
    end
    person_choice = gets.chomp

    print 'Date: '
    date = gets.chomp

    Rental.new(date, @books[book_choice.to_i], @people[person_choice.to_i][1])
    puts 'Rental created successfully'
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp
    rentals = find_rental(id)
    puts 'Rentals: '
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
  end

  def find_rental(id)
    rentals_by_id = []
    @people.each do |person|
      if person[1].id == id.to_i
        rentals_by_id = person[1].rentals
        rentals_by_id
      end
    end
    rentals_by_id
  end

 
    loop do
      @start.menu
      option = gets.chomp

      break if %w[7 q quit].include?(option)

      options[option]&.call
    end

    exit_message
  end

  def exit_message
    puts 'Thank you for using this app!'
  end
end
