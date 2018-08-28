def print_header
  puts "The students of Cerulean City Gym"
  puts "--------------"
end
def print(students)
  counter = students.length
  while counter > 0
    removed_student = students.shift
    puts "Name: #{removed_student[:name]}".center(30)
    puts "(Student status: #{removed_student[:status]})".center(30)
    puts "(Favourite Pokemon: #{removed_student[:fav_pokemon]})".center(30)
    counter -= 1
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great " + (names.count > 1 ? "students" : "student")
end
def input_break_loop?(entry)
   return true if entry == 'stop'
end
def print_by_status(students, status)
  returned_collection = []
  students.map do | student |
      if student[:status] == status
        returned_collection.push(student)
      end
  end
  print(returned_collection)
end

def input_students
  puts "Please enter the names of the students"
  puts "Followed by the current status"
  puts "Then a favourite Pokemon"
  puts "To finish, enter command 'stop'"
  students = []
  while true do
    puts "Name: "
    name = gets.chomp
    break if input_break_loop?(name)
    puts "Status: "
    status = gets.chomp
    break if input_break_loop?(status)
    puts "Favourite Pokemon: "
    pokemon = gets.chomp
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
    students << {name: name, status: status.to_sym, fav_pokemon: pokemon}
    puts "Now we have #{students.count} " + (students.count == 1?  "student" : "students")
  end
  students
end
students = input_students
print_header
print(students.clone)
print_footer(students)
print_by_status(students, :current)
