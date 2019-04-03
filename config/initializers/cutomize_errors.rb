ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
    html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe

    form_fields = [
      'textarea',
      'input',
      'select'
    ]
  
    elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')
  
    elements.each do |e|
      if e.node_name.eql? 'label'
        html = %(#{e}).html_safe
      elsif form_fields.include? e.node_name
        # if instance_tag.error_message.kind_of?(Array)
        #   html = %(#{e.add_class('is-invalid')}</div><span class="help-inline">&nbsp;#{instance_tag.error_message.uniq.join(', ')}</span>).html_safe
        # else
          html = %(#{e.add_class('is-invalid')}).html_safe
        # end
      end
    end
    html
end
  