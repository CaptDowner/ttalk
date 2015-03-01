module ApplicationHelper

  def show_flash(options={})
    options = {:fade => 1, :display => 2, :highlight => 3}.merge(options)
    html = content_tag(:div, flash.collect{ |key,msg| content_tag(:div, msg, :class => key, :attributes => "style = display: none;") }, :id => 'flash-message')
    html << content_tag(:script, "new Effect.Highlight('flash-message', {duration: #{options[:highlight]}});") if options[:highlight]
    html << content_tag(:script, "setTimeout(\"$('flash-message').fade({duration: #{options[:fade]}});\", #{options[:display]*1000}); return false;")
  end
end
