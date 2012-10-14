module ProjectsHelper
  def project_edit_link(project, user)
    if project.created_by == user.id && project.state == 'new'
      link_to 'edit', edit_project_path(project)
    elsif project.cleaned_by == user.id && project.state != 'verified'
      link_to 'add photo', edit_project_path(project)
    end
  end
end
