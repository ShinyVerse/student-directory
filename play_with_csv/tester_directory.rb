


def set_student_array_length_flag
  @student_array_length_flag = @students.length
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
def change_directory
  directory_name = gets.chomp
  if @known_directories.include?(directory_name)
    @current_directory = directory_name
    @students = []
    @student_array_length_flag = "empty"
    try_load_students
  else
    puts "That directory doesn't exist yet, create it when in save option!"
    return
  end
end








def input_students
  greet_for_input_students
  get_student_info
  @students.length > 0 ? @students : @students = []
end



def save_students
  if @student_array_length_flag == @students.length
    puts "Please enter new students before saving!"
    return
  else
    puts "Where would you like to save to? Press enter to save to default: students.csv"
    filename = gets.chomp
    if @known_directories.include?(filename)
      puts "That directory already exists, please change to #{filename} directory."
      return
    end
    filename = @current_directory if filename == ""
    file = File.open(filename, "w")
    if filename != @current_directory
      counter =  @students.length - @student_array_length_flag
      puts counter
      while counter != 0
        student = @students.pop
        student_data = [student[:name], student[:status], student[:fav_pokemon]]
        csv_line = student_data.join(",")
        file.puts csv_line
        counter -= 1
      end
      @known_directories.push(filename)
      save_to_gitignore(filename)
      save_directories
      load_directories("directories.csv")
    else
      @students.each do |student|
        student_data = [student[:name], student[:status], student[:fav_pokemon]]
        csv_line = student_data.join(",")
        file.puts csv_line
      end
    end
    puts "New students have been saved!"
    @student_array_length_flag = @students.length
  end
  file.close
end
def save_to_gitignore(filename)
   file = File.open('.gitignore', 'a')
   file << filename
   file.close
end

def load_students(filename = @current_directory)
  file = File.open(filename, "r")
  line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
  if line_count == @student_array_length_flag
    puts "Students already loaded"
    return
  else
    file.readlines.each do |line|
      name, status, fav_pokemon = line.chomp.split(",")
      push_students_to_list(name, status, fav_pokemon)
      set_student_array_length_flag
    end
    puts "Students loaded!"
  end
  file.close
end

def save_directories

  file = File.open('directories.csv', 'w')
  directories = @known_directories
  csv_line = directories.join(",")
  file.puts csv_line
  file.close
end

def print_out file_path
  CSV.foreach("./doc.csv") do |row|
    $students << row
  end
  puts $students
end

def load_directories(filename)
  CSV.foreach(filename) do |row|
    @known_directories << row
  end
  file = File.open(filename, "r")
  file.readlines.each do |line|
    directory = line.chomp.split(",")
    @known_directories << directory
  end
  file.close
end

def try_load_directories
  filename = ARGV.first || "directories.csv"
  return if filename.nil?
  if File.exists?(filename)
    load_directories(filename)
  else
    return
  end
end

def try_load_students
  filename = ARGV.first || @current_directory
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
  try_load_directories
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end
interactive_menu



# require 'csv'
#
# @students = []
# @student_array_length_flag = "empty"
# @current_directory = "studentcol.csv"
# @known_directories = []
#
# def file_path(filename)
#   file_path = File.expand_path(filename, File.dirname(__FILE__))
# end
#
# def pluralization_of_students
#   " we have #{@students.count}" + " great " + (@students.count == 1?  "student\n" : "students\n")
# end
#
# def push_students_to_list(name, status, pokemon)
#   @students << {name: name, status: status.to_sym, fav_pokemon: pokemon}
# end
#
# def print_menu
#   options = ["[1] Input students",
#   "[2] Show the students",
#   "[3] Save the list to #{@current_directory}",
#   "[4] Load the list from #{@current_directory}",
#   "[5] Change directory",
#   "[9] Exit"]
#   options.each {|option| puts option}
# end
#
# def greet_for_input_students
#   puts "Please enter the names of the students"
#   puts "Followed by the current status"
#   puts "Then a favourite Pokemon"
#   puts "To finish, enter command 'stop'"
# end
#
# def input_break_loop?(entry)
#    return true if entry == 'stop'
# end
#
# def get_student_info
#   while true do
#     puts "Name: "
#     name = STDIN.gets.chomp
#     break if input_break_loop?(name)
#     puts "Status: "
#     status = STDIN.gets.chomp
#     break if input_break_loop?(status)
#     puts "Favourite Pokemon: "
#     pokemon = STDIN.gets.chomp
#     break if input_break_loop?(pokemon)
#     if name.empty?
#       name = "Unknown"
#     end
#     if status.empty?
#       status = :current
#     end
#     if pokemon.empty?
#       pokemon = "Jigglypuff"
#     end
#     push_students_to_list(name, status, pokemon)
#     puts "Now" + pluralization_of_students
#   end
# end
#
# def input_students
#   greet_for_input_students
#   get_student_info
#   @students.length > 0 ? @students : @students = []
# end
#
# def print_students_list
#   @students.each_with_index do |student, index|
#       puts "#{index + 1}. #{student[:name]}".center(30)
#       puts "Student status: #{student[:status]}".center(30)
#       puts "Favourite Pokemon: #{student[:fav_pokemon]}".center(30)
#       puts "\n"
#     end
# end
#
# def show_students
#   if !@students.empty?
#     puts "\n"
#     print_header
#     print_students_list
#     print_footer
#     puts "\n"
#   else
#     puts "\nThere are no students yet :(\n"
#   end
# end
#
# def save_students
#   if @student_array_length_flag == @students.length
#     puts "Please enter new students before saving!"
#     return
#   else
#     puts "Where would you like to save to? Press enter to save to default: #{@current_directory}"
#     filename = gets.chomp
#     filename = @current_directory if filename == ""
#     if @known_directories.include?(filename)
#       puts "That directory already exists, please change to #{filename} directory."
#       return
#     elsif filename != @current_directory
#       counter =  @students.length - @student_array_length_flag
#       CSV.open(file_path(filename), "w") do |file|
#         while counter != 0
#           student = @students.pop
#           file << [student[:name], student[:status], student[:fav_pokemon]]
#           counter -= 1
#         end
#       end
#       @known_directories.push(filename)
#       return
#     elsif filename == @current_directory
#       CSV.open(file_path(filename), "w") do |file|
#         @students.each do |student|
#           file << [student[:name], student[:status], student[:fav_pokemon]]
#         end
#       end
#     end
#   end
# end
#
# def load_students(filepath)
#   CSV.foreach(filepath) do |line|
#     line_count = `wc -l "#{filepath}"`.strip.split(' ')[0].to_i
#     if line_count == @student_array_length_flag
#       puts "\nAll current students already loaded"
#       puts "\n"
#       return
#     else
#       name, status, fav_pokemon = line
#       push_students_to_list(name, status, fav_pokemon)
#     end
#   end
# end
#
# def process(selection)
#   actions_for_selection = {
#     "1" => lambda { @students = input_students},
#     "2" => lambda { show_students },
#     "3" => lambda { save_students },
#     "4" => lambda { load_students(file_path(@current_directory)) },
#     # "5" => lambda { change_directory},
#     "9" => lambda { exit }
#   }
#   if actions_for_selection.key?(selection)
#      actions_for_selection[selection].call
#   else
#     puts "I don't know what you mean, try again"
#   end
# end
#
# def print_header
#   puts "The students of Cerulean City Gym"
#   puts "--------------".center(30)
# end
#
# def print_footer
#   puts "\nOverall," + pluralization_of_students
# end
#
# # def save_directories
# #   CSV.open(filepath('directory.csv'), "w") do |csv|
# #     @known_directories.each do |directory|
# #       csv << [directory]
# #     end
# #   end
# #   print @known_directories
# # end
#
# def load_directories(filename)
#   CSV.foreach(filename) do |directory|
#     @known_directories << [directory]
#   end
# end
#
# def try_load_directories
#   filename = ARGV.first || file_path("directorycol.csv")
#   return if filename.nil?
#   if File.exists?(file_path(filename))
#     load_directories(file_path(filename))
#   else
#     return
#   end
# end
#
# def try_load_students
#   filename = ARGV.first || @current_directory
#   return if filename.nil?
#   if File.exists?(file_path(filename))
#     load_students(file_path(filename))
#     puts "Loaded #{@students.count} from #{filename}"
#     @student_array_length_flag = @students.length
#   else
#     puts "Sorry, #{filename} doesn't exist"
#     exit
#   end
# end
#
# def interactive_menu
#   try_load_students
#   try_load_directories
#   loop do
#     print_menu
#     process(STDIN.gets.chomp)
#   end
# end
# interactive_menu
