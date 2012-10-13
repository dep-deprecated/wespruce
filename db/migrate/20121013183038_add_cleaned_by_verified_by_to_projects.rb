class AddCleanedByVerifiedByToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :cleaned_by, :integer
    add_column :projects, :verified_by, :integer
  end
end
