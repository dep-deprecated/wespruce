class AddStateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :state, :string, default: 'new'
  end
end
