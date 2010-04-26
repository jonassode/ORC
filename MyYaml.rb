#-
# MyYaml
# A yaml wrapper library for Ruby. Simplifies using yaml as a List or a Hash
# Homepage: http://github.com/jonassode/MyYaml
#
# 2010-04-26, Created, Jonas Söderström - version 0.1
# 
# Version 0.1
#-

require 'yaml'

class MyYamlList
  # It's a List
  # Each Entry Is Unique
  # Sorted Alphabetically Ascending

  def self.load(file_name)
    content = []
    if File.exist?(file_name+'.yaml')
      content = YAML::load(File.read(file_name+'.yaml'))
    end
    return content
  end

  def self.save(list, file_name)
    File.open( file_name+'.yaml', 'w+' ) do |out|
      YAML.dump( list.uniq.sort, out )
    end
  end

  def self.add(object, file_name)
    list = MyYamlList.load(file_name)
    list << object
    MyYamlList.save(list.uniq.sort, file_name)
  end

end

class MyYamlHash
  # It's a Hash
  # Saved exactly as the object

  def self.load(file_name)
    content = Hash.new()
    if File.exist?(file_name+'.yaml')
      content = YAML::load(File.read(file_name+'.yaml'))
    end
    return content
  end

  def self.save(object, file_name)
    File.open( file_name+'.yaml', 'w+' ) do |out|
      YAML.dump( object, out )
    end
  end

end
