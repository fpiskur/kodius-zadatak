module ApplicationHelper

  def active_class(*link_paths)
    activeClass = ""
    link_paths.each do |link_path|
      activeClass = "active" if current_page?(link_path, check_parameters: true)
    end
    activeClass
  end

end
