require 'yaml'

class MyYaml
  # It's a List
  # Unique
  # Sorted Alphabetically Ascending

  def self.load(file_name)
    content = []
    if File.exist?(file_name+'.yaml')
      content = YAML::load(File.read(file_name+'.yaml'))
    end
    return content
  end

  def self.save(object, file_name)
    File.open( file_name+'.yaml', 'w' ) do |out|
      YAML.dump( object, out )
    end
  end

  def self.add(object, file_name)
    list = MyYaml.load(file_name)
    list << object
    MyYaml.save(list.uniq.sort, file_name)
  end

end
