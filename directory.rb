students = [
  "Misty",
  "Daisy",
  "Lily",
  "Violet",
  "Ash Ketchum",
  "Aquaman",
  "Jar Jar Binks",
  "Ariel",
  "Melody"
]
def print_header
  puts "The students of Cerulean City Gym"
  puts "--------------"
end
def print(names)
  names.each do |name|
    puts name
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

print_header
print(students)
print_footer(students)
