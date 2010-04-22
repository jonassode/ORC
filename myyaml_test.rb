require 'test/unit'
require 'MyYaml'

class MyYamlTest < Test::Unit::TestCase

  def test_save_hash_save_load
    # Save
    hash = Hash.new()
    hash['one'] = 'first_value'
    hash['two'] = 'second_value'
    MyYamlHash.save(hash, 'test_save_hash')
    # Load
    hash2 = MyYamlHash.load('test_save_hash')
    assert(hash2['one'] == 'first_value', "First value is incorrect")
    assert(hash2['two'] == 'second_value', "Second values is incorrect")
    assert(hash == hash2, "Hashes are not the same")
  end


end

#MyYamlTest.new().test_save_hash()