# encoding: utf-8

module SlidayBackup
  class Binder

    ##
    # Creates a new SlidayBackup::Notifier::Binder instance. Loops through the provided
    # Hash to set instance variables
    def initialize(key_and_values)
      key_and_values.each do |key, value|
        instance_variable_set("@#{ key }", value)
      end
    end

    ##
    # Returns the binding (needs a wrapper method because #binding is a private method)
    def get_binding
      binding
    end

  end
end