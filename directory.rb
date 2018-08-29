@students = []

def print_menu
  puts "[1] Input students"
  puts "[2] Show the students"
  puts "[3] Save the list to students.csv"
  puts "[9] Exit"
end

def show_students
  if !@students.empty?
    print_header
    print_students_list
    print_footer
  else
    puts "\nThere are no students yet :("
  end
end

def process(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def print_students_list
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

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:status], student[:fav_pokemon]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
