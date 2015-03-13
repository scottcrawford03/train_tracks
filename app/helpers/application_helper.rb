module ApplicationHelper
  def prettify_milliseconds(length_in_milliseconds)
    seconds = length_in_milliseconds / 1000
    minutes, secs = seconds.divmod(60)
    "%d:%0.2d" % [minutes, secs]
  end
end
