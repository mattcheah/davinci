class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-./ ", "_").
    downcase
  end
end

def clean_directory_path(path)
  if path[0] == "/"
    path = path[1..-1]
  end
  
  if path[-1] == "/"
    path = path[0..-2]
  end
  
  path
end