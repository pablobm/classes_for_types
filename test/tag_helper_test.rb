require 'test_helper'

class TagHelperTest < ActionView::TestCase
    
  def test_tag
    results_to_arguments = {
      ['input', {'type' => 'text', :id => 'the_name', :name => 'the_name'}] =>
        '<input class="text" id="the_name" name="the_name" type="text" />',
      ['input', {'type' => 'password', :id => 'the_name', :name => 'the_name'}] =>
        '<input class="password" id="the_name" name="the_name" type="password" />',
      ['input', {'type' => 'radio', :id => 'the_name', :name => 'the_name'}] =>
        '<input class="radio" id="the_name" name="the_name" type="radio" />',
      ['unsuspectingtag', {'type' => 'something'}] =>
        '<unsuspectingtag class="something" type="something" />',
      ['p', {}, true] =>
        '<p>'
    }
    
    results_to_arguments.each do |arguments, result|
      assert_dom_equal result, send(:tag, *arguments)
    end
  end

end
