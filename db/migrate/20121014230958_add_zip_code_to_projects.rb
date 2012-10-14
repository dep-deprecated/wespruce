class AddZipCodeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :zip_code, :string
  end
end
