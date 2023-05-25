require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './book'
require_relative './person'
require 'json'
require 'fileutils'
class App
  DATA_FOLDER = 'data'
  def initialize
    FileUtils.mkdir_p(DATA_FOLDER) unless Dir.exist?(DATA_FOLDER)
    @books = load_data('books.json', Book) || []
    @people = load_data('people.json', Person) || []
    @rentals = load_data('rentals.json', Rental) || []
  end
  def load_data(file_path, class_type)
    full_path = File.join(DATA_FOLDER, file_path)
    return [] unless File.exist?(full_path)
  
    begin
      json_data = JSON.parse(File.read(full_path))
      if class_type == Book
        json_data.map { |item| Book.new(item['title'], item['author']) }
      elsif class_type == Person
        json_data.map do |item|
          if item['type'] == 'Student'
            Student.new(item['age'], item['name'], item['classroom'], parent_permission: item['parent_permission'])
          elsif item['type'] == 'Teacher'
            Teacher.new(item['specialization'], item['age'], item['name'])
          end
        end
      else
        []
      end
    rescue JSON::ParserError => e
      puts "Error parsing JSON file #{full_path}: #{e.message}"
      []
    end
  end
  
  def save_data(data, file_path)
    full_path = File.join(DATA_FOLDER, file_path)
    serialized_data = []
  
    data.each do |item|
      if item.is_a?(Book)
        serialized_data << { 'title' => item.title, 'author' => item.author }
      elsif item.is_a?(Student)
        serialized_data << {
          'type' => 'Student',
          'id' => item.id,
          'name' => item.name,
          'age' => item.age,
          'classroom' => item.classroom,
          'parent_permission' => item.parent_permission
        }
      elsif item.is_a?(Teacher)
        serialized_data << {
          'type' => 'Teacher',
          'id' => item.id,
          'name' => item.name,
          'age' => item.age,
          'specialization' => item.is_a?(Teacher) ? item.specialization : nil
        }
      elsif item.is_a?(Rental)
        serialized_data << {
          'date' => item.date,
          'book' => {
            'title' => item.book.title,
            'author' => item.book.author
          },
          'person' => {
            'id' => item.person.id,
            'name' => item.person.name,
            'age' => item.person.age
          }
        }
      end
    end
  
    if serialized_data.empty?
      puts "Unsupported data format for saving: #{data.class}"
      return
    end
  
    File.open(full_path, 'w') do |file|
      file.write(JSON.generate(serialized_data))
    end
  end  
  
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
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
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
    @people.push(student)
    save_data(@people, 'people.json')
    puts 'Student created successfully!'
  end
  
  def add_teacher
    print 'Age: '
    age_input = gets.chomp
  
    print 'Name: '
    name_input = gets.chomp
  
    print 'Specialization: '
    specialization_input = gets.chomp
  
    teacher = Teacher.new(age_input, name_input, specialization_input)
    @people.push(teacher)
    save_data(@people, 'people.json')
    puts 'Teacher created successfully!'
  end
  
  def add_new_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = gets.chomp
    if type == '1'
      add_student
    elsif type == '2'
      add_teacher
    else
      puts 'Incorrect choice'
    end
  end

  def create_book
    print 'Title: '
    title_input = gets.chomp
  
    print 'Author: '
    author_input = gets.chomp
  
    book = Book.new(title_input, author_input)
  
    @books.push(book)
    save_data(@books, 'books.json')
    puts 'Book created successfully!'
  end

  def rent_book
    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
    end
    book_choice = gets.chomp.to_i
  
    puts 'Select a person from the following list by number (not id):'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.correct_name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_choice = gets.chomp.to_i
  
    print 'Date: '
    date = gets.chomp
  
    rental = Rental.new(date, @books[book_choice], @people[person_choice])
  
    @rentals.push(rental)
    save_data(@rentals, 'rentals.json')
    puts 'Rental created successfully!'
  end  

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    rentals = find_rentals(id)
    puts 'Rentals:'
    rentals.each do |rental|
      puts "#{rental['date']}, Book: #{rental['book'].title} by #{rental['book'].author}"
    end
  end

  def find_rentals(id)
    rentals = @rentals || []
    rentals.select { |rental| rental['person']['id'] == id }
  end

  def exit_app
    save_data(@books, 'books.json')
    save_data(@people, 'people.json')
    save_data(@rentals, 'rentals.json')
    puts 'Data saved. Exiting the app.'
  end
end