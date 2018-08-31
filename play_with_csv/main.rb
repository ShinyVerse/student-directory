require 'csv'

$students = []
$known_directories = []


def print_out (file_path, collection)
  CSV.foreach(file_path) do |row|
    collection << row
  end
end
#
# def new_name (name)
#   CSV.open("./doc.csv", "a+") do |csv|
#     csv << [name]
#   end
# end


def save_directories
  CSV.open(filepath('directory.csv'), "w") do |csv|
    $known_directories.each do |directory|
      csv << [directory]
      # TO INSPECT ARGUMENT: csv.inspect or interpolation!!!!!!
    end
  end
end

def file_path(filename)
  file_path = File.expand_path(filename, File.dirname(__FILE__))
end

# save_directories
# file_path = File.expand_path('studentcol.csv', File.dirname(__FILE__))
# puts "#{file_directory}/studentcol.csv"
# print_out("#{file_directory}/studentcol.csv", $students)
# puts file_path('studentcol.csv')

print_out(file_path('studentcol.csv'), $students)
print_out(file_path('directory.csv'), $known_directories)
# puts $students
puts $known_directories
