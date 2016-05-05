module ApplicationHelper
  def classname(path)
    if request.url.include?(path)
      "Mnormarclick Modulos"
    else
      "Modulos"
    end
  end
end
