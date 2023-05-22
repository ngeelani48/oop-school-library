def run
  greet

  loop do
    puts 'Please choose an option by entering a number:'
    puts "\t1 - List all books"
    puts "\t2 - List all people"
    puts "\t3 - Create a person"
    puts "\t4 - Create a book"
    puts "\t5 - Create a rental"
    puts "\t6 - List all rentals for a given person id"
    puts "\t7 - Exit"

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
