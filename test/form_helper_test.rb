#require 'test_helper'

silence_warnings do
  Post = Struct.new(:title, :author_name, :body, :secret, :written_on, :cost)
  Post.class_eval do
    alias_method :title_before_type_cast, :title unless respond_to?(:title_before_type_cast)
    alias_method :body_before_type_cast, :body unless respond_to?(:body_before_type_cast)
    alias_method :author_name_before_type_cast, :author_name unless respond_to?(:author_name_before_type_cast)
    alias_method :secret?, :secret

    def new_record=(boolean)
      @new_record = boolean
    end

    def new_record?
      @new_record
    end
  end

  class Comment
    attr_reader :id
    attr_reader :post_id
    def save; @id = 1; @post_id = 1 end
    def new_record?; @id.nil? end
    def name
      @id.nil? ? 'new comment' : "comment ##{@id}"
    end
  end
end

class Comment::Nested < Comment; end

class FormHelperTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper

  def setup
    @account = Account.new
    def @account.errors()
      Class.new{
        def on(field); "can't be empty" if field == "holder_name"; end
        def empty?() false end
        def count() 1 end
        def full_messages() [ "Holder name can't be empty" ] end
      }.new
    end
    def @account.id; 123; end
    def @account.id_before_type_cast; 123; end
    def @account.to_param; '123'; end

    @account.holder_name = ""
    @account.number      = "12345678"
    @account.sort_code1  = "12"
    @account.sort_code2  = "34"
    @account.sort_code3  = "56"

    @controller = Class.new do
      attr_reader :url_for_options
      def url_for(options)
        @url_for_options = options
        "http://www.example.com"
      end
    end
    @controller = @controller.new
  end
    
  def test_form_for
    _erbout = ''
  
    form_for(:post, @post, :html => { :id => 'create-post' }) do |f|
      _erbout.concat f.label(:title)
      _erbout.concat f.text_field(:title)
      _erbout.concat f.text_area(:body)
      _erbout.concat f.check_box(:secret)
      _erbout.concat f.submit('Create post')
    end
  
    expected =
      "<form action='http://www.example.com' id='create-post' method='post'>" +
      "<label for='post_title'>Title</label>" +
      "<input name='post[title]' size='30' type='text' id='post_title' value='Hello World' class='text' />" +
      "<textarea name='post[body]' id='post_body' rows='20' cols='40'>Back to the hill and over it again!</textarea>" +
      "<input name='post[secret]' checked='checked' type='checkbox' id='post_secret' value='1' class='checkbox' />" +
      "<input name='post[secret]' type='hidden' value='0' class='hidden' />" +
      "<input name='commit' id='post_submit' type='submit' value='Create post' class='submit' />" +
      "</form>"
  
    assert_dom_equal expected, _erbout
  end
  
  
  protected
  
  def protect_against_forgery?
    false
  end
end
