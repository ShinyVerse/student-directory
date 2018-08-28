students = [
  {name: "Misty",  status: :current},
  {name: "Daisy", status: :current},
  {name: "Lily", status: :current},
  {name: "Violet", status: :current},
  {name: "Ash Ketchum", status: :current},
  {name: "Aquaman", status: :previous},
  {name: "Jar Jar Binks", status: :previous},
  {name: "Ariel", status: :previous},
  {name: "Melody", status: :current}
]
def print_header
  puts "The students of Cerulean City Gym"
  puts "--------------"
end
def print(students)
  students.each do |student|
    puts "#{student[:name]} (Student status: #{student[:status]})"
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

print_header
print(students)
print_footer(students)
