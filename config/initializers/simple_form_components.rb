module SimpleForm
  module Components
    module Icons
      def icon(wrapper_options = nil)
        if options[:icon].blank?
          template.content_tag(:i, '', class: "icon file")
        else
          icon_class
        end
      end

      def icon_class
        icon_tag = template.content_tag(:i, '', class: "icon " + options[:icon])
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icons)