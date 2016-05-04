module ApplicationHelper
  def classname(path)
    "Mnormarclick" if request.url.include?(path)
  end
end
