require_relative './app'

class Welcome
    def initialize
    @app = App.new
  end
def welcome
    puts 'Welcome to School Library App!\n'
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

  def run
    @start.welcome

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

end