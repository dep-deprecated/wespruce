class AddCompletedAtAndVerifiedAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :completed_at, :datetime
    add_column :projects, :verified_at, :datetime
  end
end
