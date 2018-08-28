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
  puts "Overall, we have #{names.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, status: :current, fav_pokemon: "Squirtle"}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end
students = input_students
print_header
print(students.clone)
print_footer(students)
