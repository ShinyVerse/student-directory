@students = []

def print_students
  @students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]}".center(30)
      puts "Student status: #{student[:status]}".center(30)
      puts "Favourite Pokemon: #{student[:fav_pokemon]}".center(30)
      puts "\n"
    end
end

def input_break_loop?(entry)
   return true if entry == 'stop'
end

def input_students
  local_students = []
  puts "Please enter the names of the students"
  puts "Followed by the current status"
  puts "Then a favourite Pokemon"
  puts "To finish, enter command 'stop'"
  while true do
    puts "Name: "
    name = gets.chomp
    break if input_break_loop?(name)
    puts "Status: "
    status = gets.chomp
    break if input_break_loop?(status)
    puts "Favourite Pokemon: "
    # Use of someting other than chomp.
    pokemon = gets.strip
    break if input_break_loop?(pokemon)
    if name.empty?
      name = "Unknown"
    end
    if status.empty?
      status = :current
    end
    if pokemon.empty?
      pokemon = "Jigglypuff"
    end
    local_students << {name: name, status: status.to_sym, fav_pokemon: pokemon}
    puts "Now we have #{local_students.count} " + (local_students.count == 1?  "student\n" : "students\n")
  end
  if local_students.length > 0
     @students = local_students
  else
    @students = []
  end
end

def print_header
  puts "The students of Cerulean City Gym"
  puts "--------------".center(30)
end

def print_footer
  puts "\nOverall, we have #{@students.count} great " + (@students.count > 1 ? "students\n" : "student\n")
end

def interactive_menu
  loop do
    # 1. print the menu and ask the user what to do
    puts "[1] Input students"
    puts "[2] Show the students"
    puts "[9] Exit"
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      @students = input_students
    when "2"
      if !@students.empty?
        print_header
        print_students
        print_footer
      else
        puts "\nThere are no students yet :("
      end
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
  end
end

interactive_menu
