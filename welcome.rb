require_relative './app'
class Welcome
  def initialize(app)
    @app = app
  end

  def greet
    puts 'Welcome to School Library App!'
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
    @app.exit_app
  end

  def run
    greet

    options = {
      '1' => method(:display_books),
      '2' => method(:display_people),
      '3' => method(:add_new_person),
      '4' => method(:create_book),
      '5' => method(:rent_book),
      '6' => method(:list_rentals),
      '7' => method(:exit_message),
      'q' => method(:exit_message),
      'quit' => method(:exit_message)
    }

    loop do
      display_menu

      option = gets.chomp

      action = options[option]
      if action
        action.call
        break if %w[7 q quit].include?(option)
      else
        puts 'Invalid option. Please try again.'
      end
    end
  end

  def display_menu
    puts 'Please choose an option by entering a number:'
    puts "\t1 - List all books"
    puts "\t2 - List all people"
    puts "\t3 - Create a person"
    puts "\t4 - Create a book"
    puts "\t5 - Create a rental"
    puts "\t6 - List all rentals for a given person id"
    puts "\t7 - Exit"
  end
end

app = App.new
welcome = Welcome.new(app)
welcome.run
