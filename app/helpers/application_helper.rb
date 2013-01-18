module ApplicationHelper
  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " + button_to(name, 'javavscript:history.go(-1);', :class => 'cancel')
  end
end
