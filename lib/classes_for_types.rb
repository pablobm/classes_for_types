module ClassesForTypes

  module TagHelper
    def self.included(base)
      base.class_eval do
        alias_method_chain :tag, :type_as_class
      end
    end
        
    def tag_with_type_as_class(name, options = nil, open = false, escape = true)
      options = ClassesForTypes.add_class_for_type(options)
      tag_without_type_as_class(name, options, open, escape)
    end
  end

  module InstanceTag
    def self.included(base)
      base.class_eval do
        alias_method_chain :tag, :type_as_class
      end
    end
        
    def tag_with_type_as_class(name, options)
      options = ClassesForTypes.add_class_for_type(options)
      tag_without_type_as_class(name, options)
    end
  end
  
  
  def self.add_class_for_type(options)
      options = options.stringify_keys
      options['class'] = ((options['class'] or '').split(' ') << options['type'].to_s).join(' ') if options['type'] && ! options['type'].empty?
      options
  end
  
end
