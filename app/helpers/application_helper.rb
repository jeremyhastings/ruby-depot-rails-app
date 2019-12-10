module ApplicationHelper
  # render_if partial created to determine whether cart partial should render.  December 9th, 2019.
  # TODO: I do not understand this at all.
  def render_if(condition, record)
    if condition
      render record
    end
  end
end
