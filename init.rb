if RUBY_VERSION >= "1.9"
  String.send                 :include, UnicodeOverride::String
  ActiveRecord::Base.send     :include, UnicodeOverride::ActiveRecord
  ActionController::Base.send :include, UnicodeOverride::ActionController
end
