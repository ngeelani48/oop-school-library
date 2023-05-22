require_relative './app'
class Welcome
  def initialize(app)
    @app = app
  end

  def greet
    puts 'Welcome to School Library App!'
  end

  def menu
    puts 'Please choose an option by entering a number:'
    puts "\t1 - List all books"
    puts "\t2 - List all people"
    puts "\t3 - Create a person"
    puts "\t4 - Create a book"
    puts "\t5 - Create a rental"
    puts "\t6 - List all rentals for a given person id"
    puts "\t7 - Exit"
  end

  def display_books
    @app.display_books
  end

  def display_people
    @app.display_people
  end

  def add_new_person
    @app.add_new_person
  end

  def create_book
    @app.create_book
  end

  def rent_book
    @app.rent_book
  end

  def list_rentals
    @app.list_rentals
  end

  def exit_message
    puts 'Thank you for using this app!'
  end

  def run
    greet
    menu

    loop do
      option = gets.chomp

      case option
      when '1'
        display_books
      when '2'
        display_people
      when '3'
        add_new_person
      when '4'
        create_book
      when '5'
        rent_book
      when '6'
        list_rentals
      when '7', 'q', 'quit'
        exit_message
        break
      else
        puts 'Invalid option. Please try again.'
      end
    end
  end
end
