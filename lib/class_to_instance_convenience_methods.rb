module Bitsy
  module ClassToInstanceConvenienceMethods
    extend ActiveSupport::Concern

    module ClassMethods
      def method_missing(method_name, *args, &block)
        if self.instance_methods.include?(method_name.to_sym)
          self.new(*args, &block).send(method_name)
        else
          super
        end
      end
    end

  end
end
