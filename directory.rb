def print_header
  puts "The students of Cerulean City Gym"
  puts "--------------"
end
def print(students)
  students.each_with_index do |student, index|
      puts "#{index + 1}.  #{student[:name]} (Student status: #{student[:status]})"
  end
end
def print_only_K_names(students, letter)
  puts "These students are the ones whose names begin with \"K\" "
  students.each_with_index do |student, index|
      if student[:name][0].upcase == letter
        puts "#{index + 1}.  #{student[:name]} (Student status: #{student[:status]})"
      end
    end
end

def print_long_names_only(students, length)
  students.each do |student|
     if student[:name].length > length
         puts "#{student[:name]} (Student status: #{student[:status]})"
     end
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
    students << {name: name, status: :current}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end
students = input_students
print_header
print(students)
print_footer(students)
# print_only_K_names(students, "M")
print_long_names_only(students, 4)
