module FileHelper

  def file_path(filename)
    file_path = File.expand_path(filename, File.dirname(__FILE__))
  end

end
