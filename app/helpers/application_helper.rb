module ApplicationHelper

  def shorten(description)
    description.split(/\s+/, 
      Settings.desc_size + 1)[0...Settings.desc_size].join(' ') + "..."
  end

  def link_to_remove_fields label, f
    field = f.hidden_field(:_destroy) 
    link = link_to label,"#", onclick: "remove_fields(this)", remote: true
    field + link
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, 
      child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to name,"#", onclick: "add_fields(this, \"#{association}\", 
      \"#{escape_javascript(fields)}\")", remote: true
  end

  def authenticate_admin!
    authenticate_admin_admin!
  end

  def current_admin
    current_admin_admin
  end

  def admin_signed_in?
    admin_admin_signed_in?
  end

  def destroy_admin_session_path
    destroy_admin_admin_session_path
  end

  def new_admin_session_path
    new_admin_admin_session_path
  end
end
