module ProjectsHelper
  def project_edit_link(project, user)
    return unless user
    if project.created_by == user.id && project.state == 'new'
      link_to '<i class="icon-edit"></i>Edit this project'.html_safe, edit_project_path(project)
    end
  end

  def project_button project
    output = ""

    if project.new?
      if project.creator == current_user
        output << "<p>No one has claimed this project yet</p>"
      else
        if current_user
          output << "<p class='lead'>No one has claimed this yet. You're free to claim this problem and <strong>get it done</strong>! Just press the button below and begin.</p>"
          output += button_to "I will do this", claim_project_path(project), class: "btn btn-success btn-large" if project.new? && project.creator != current_user
        else
          output << "<p class='lead'>No one has claimed this yet. #{link_to "Sign up", new_user_registration_path} or #{link_to "sign in", new_user_session_path} to claim it.</p>"
        end
      end
    elsif project.active?
      output += link_to project.cleaner.username, profile_path(project.cleaner.username)
      output << " is currently working on this."
      output += button_to "Unclaim", unclaim_project_path(project), class: "btn btn-danger" if project.cleaner == current_user
      output += button_to "Mark as Complete", complete_project_path(project), class: "btn btn-success" if project.cleaner == current_user
    elsif project.completed?
      output += link_to project.cleaner.username, profile_path(project.cleaner.username)
      output << " has completed this project. "
      if project.cleaner == current_user
          output += link_to 'Ready to add an after photo?', edit_project_path(@project)
      end
      output += button_to "Verify as fixed", verify_project_path(project), class: "btn btn-success" if project.creator == current_user
    elsif project.verified?
      output << "<p>This project is done!</p>"
      if project.cleaner == current_user
          output += link_to 'Ready to add an after photo?', edit_project_path(@project)
      end
    end

    return output.html_safe
  end

end
