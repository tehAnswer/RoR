module MailForm
  class Base
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    include ActiveModel::Validations
    extend ActiveModel::Naming
    extend ActiveModel::Translation

  	attribute_method_prefix 'clear_'
  	attribute_method_suffix '?'

    class_attribute :attribute_names
    self.attribute_names = []



    def self.attributes(*names)
      attr_accessor(*names)
      define_attribute_methods(names)
      self.attribute_names += names
    end

    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end

    def attribute?(attribute)
    	send(attribute).present?
    end

    def persisted?
      false
    end

    def deliver
      if valid?
        MailForm::Notifier.contact(self).deliver
      else
        false
      end
    end

    protected :clear_attribute, :attribute?
  end
end

