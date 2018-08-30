@students = []
@student_array_length_flag = "empty"

def push_students_to_list(name, status, pokemon)
  @students << {name: name, status: status.to_sym, fav_pokemon: pokemon}
end

def set_student_array_length_flag
  @student_array_length_flag = @students.length
end

def greet_for_input_students
  puts "Please enter the names of the students"
  puts "Followed by the current status"
  puts "Then a favourite Pokemon"
  puts "To finish, enter command 'stop'"
end

def pluralization_of_students
  " we have #{@students.count}" + " great " + (@students.count == 1?  "student\n" : "students\n")
end

def print_menu
  options = ["[1] Input students",
  "[2] Show the students",
  "[3] Save the list to students.csv",
  "[4] Load the list from students.csv",
  "[9] Exit"]
  options.each {|option| puts option}
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
  actions_for_selection = {
    "1" => lambda { @students = input_students},
    "2" => lambda { show_students },
    "3" => lambda { save_students },
    "4" => lambda { load_students },
    "9" => lambda { exit } }
  if actions_for_selection.key?(selection)
     actions_for_selection[selection].call
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

def get_student_info
  while true do
    puts "Name: "
    name = STDIN.gets.chomp
    break if input_break_loop?(name)
    puts "Status: "
    status = STDIN.gets.chomp
    break if input_break_loop?(status)
    puts "Favourite Pokemon: "
    # Use of someting other than chomp.
    pokemon = STDIN.gets.strip
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
    push_students_to_list(name, status, pokemon)
    puts "Now" + pluralization_of_students
  end
end

def input_students
  greet_for_input_students
  get_student_info
  @students.length > 0 ? @students : @students = []
end

def print_header
  puts "The students of Cerulean City Gym"
  puts "--------------".center(30)
end

def print_footer
  puts "\nOverall," + pluralization_of_students
end

def save_students
  if @student_array_length_flag == @students.length
    return
  else
    file = File.open("students.csv", "w")
    @students.each do |student|
      student_data = [student[:name], student[:status], student[:fav_pokemon]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  file.close
end

def load_students(filename ="students.csv")
  file = File.open(filename, "r")
  line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
  if line_count == @student_array_length_flag
    nil
  else
    file.readlines.each do |line|
      name, status, fav_pokemon = line.chomp.split(",")
      push_students_to_list(name, status, fav_pokemon)
      set_student_array_length_flag
    end
  end
  file.close
end

def try_load_students
  filename = ARGV.first || "students.csv"
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end
interactive_menu
