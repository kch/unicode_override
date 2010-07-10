module UnicodeOverride

  module String
    def force_utf8!
      return self if encoding == "UTF-8"
      e = encoding
      force_encoding('UTF-8')
      force_encoding(e) unless valid_encoding?
      self
    end
  end

  module ActiveRecord
    def self.included(base)
      base.alias_method_chain :attributes, :unicode_override
    end

    def attributes_with_unicode_override
      attributes_without_unicode_override.tap { |attrs| attrs.values.select { |v| v.is_a?(String) }.each(&:force_utf8!) }
    end
  end
  
  
  module ActionController

    def self.included(base)
      base.extend(ClassMethods)
      base.singleton_class.alias_method_chain :inherited, :unicode_override
    end

    module ClassMethods
      def inherited_with_unicode_override(child)
        inherited_without_unicode_override(child)
        call_super_with_utf8    = lambda { |*args, &block| super(*args, &block).tap { |v| v.force_utf8! if v.is_a?(String) } }
        rails_helper_methods    = ActionView::Helpers::constants.map(&:to_s).grep(/Helper$/).map { |s| ActionView::Helpers.const_get(s) }.map(&:instance_methods).flatten.sort.uniq
        unicode_override_module = Module.new() { rails_helper_methods.each { |m| define_method(m, &call_super_with_utf8) } }
        child.helper(unicode_override_module)
      end
    end

  end


end
