module MailForm
  class Base
  	include ActiveModel::AttributeMethods
  	attribute_method_prefix 'clear_'
  	attribute_method_suffix '?'


    def self.attributes(*names)
      attr_accessor(*names)
      define_attribute_methods(names)
    end

    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end

    def attribute?(attribute)
    	send(attribute).present?
    end

    protected :clear_attribute, :attribute?
  end
end

