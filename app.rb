require_relative('student')
require_relative('teacher')
require_relative('book')
require_relative('rental')
require_relative('person')

class App
  attr_accessor :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def init
    puts 'Please choose an option by enterin a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals '
    puts '7 - Exit '
    option = gets.chomp.to_i
    option_selected(option)
  end

  def option_selected(option)
    case option
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rental
    when 7
      quit
    else puts 'Please enter a valid option'
         init
    end
  end

  def list_books
    puts 'No data yet' if @books.empty?
    @books.each { |book| puts "Title: #{book.title} Author: #{book.author}" }
    init
  end

  def list_people
    puts 'No data yet' if @people.empty?
    @people.each { |person| puts "[#{person.class.name}] Name: #{person.name} ID: #{person.id} Age: #{person.age}" }
    init
  end

  def create_person
    puts 'Do you want to create a student (1) or a techer (2)? [Input the number]'
    option_person = gets.chomp.to_i
    case option_person
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Please, enter a valid number'
      create_person
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp
    puts 'Clasroom:'
    classroom = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Parent Permission Y or N:'
    permission = gets.chomp
    case permission.upcase
    when 'Y'
      parent_permission = true
    when 'N'
      parent_permission = false
    else
      puts 'Enter a valid option'
      create_student
    end
    @people.push(Student.new(age, classroom, name, parent_permission: parent_permission))
    puts 'Person created successfully'
    init
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Specialization'
    specialization = gets.chomp
    @people.push(Teacher.new(age, specialization, name))
    puts 'Person created successfully'
    init
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
    init
  end

  def create_rental
    puts 'Select a book from the following list by number'
    puts 'No data yet' if @books.empty?
    i = 0
    @books.each { |book| puts "#{i += 1}) Title: #{book.title} Author: #{book.author}" }
    book_option = gets.chomp.to_i
    book = @books[book_option - 1]
    puts 'Select a person from the following list by number (not id)'
    puts 'No data yet' if @people.empty?
    j = 0
    @people.each do |person|
      puts "#{j += 1}) [#{person.class.name}] Name: #{person.name} ID: #{person.id} Age: #{person.age}"
    end
    person_option = gets.chomp.to_i
    person = @people[person_option - 1]
    puts 'Date [yyyy-mm-dd]:'
    date = gets.chomp
    @rentals.push(Rental.new(date, person, book))
    puts 'Rental created successfully'
    init
  end

  def list_rental
    puts 'No data yet' if @rentals.empty?
    puts 'ID of Person:'
    person_id = gets.chomp.to_i
    person_selected = @people.select { |person| person.id == person_id }
    puts 'The user ID does not exist'
    puts 'Rentals:' if person_selected.rentals.empty?
    rental_selected = person_selected.rentals
    rental_selected.each do |rental|
      puts "Date: #{rental.date} Book #{rental.book.title} by #{rental.book.author}"
    end
    init
  end

  def quit
    puts 'Do you want to leave Y or N'
    quit_app = gets.chomp
    case quit_app.upcase
    when 'Y'
      puts 'Thanks for use this app'
    when 'N'
      init
    else
      puts 'Enter a valid option'
      quit
    end
  end
end
