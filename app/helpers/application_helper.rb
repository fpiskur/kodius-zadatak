module ApplicationHelper

  def active_class(*link_paths)
    puts ("################## #{current_page?("/rooms")}")
    activeClass = ""
    link_paths.each do |link_path|
      activeClass = "active" if current_page?(link_path, check_parameters: true)
    end
    activeClass
  end

end
