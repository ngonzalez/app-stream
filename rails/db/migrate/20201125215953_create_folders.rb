class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.string :folder
      t.text :details
      t.string :formatted_name
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
      t.string :subfolder
      t.string :year
      t.string :source
      t.datetime :folder_created_at
      t.datetime :folder_updated_at
      t.string :data_url
      t.index [:data_url], name: :index_folders_on_data_url, unique: true
      t.index [:folder], name: :index_folders_on_folder, unique: true
      t.index [:name], name: :index_folders_on_name, unique: true
      t.index [:subfolder], name: :index_folders_on_subfolder, unique: true
    end
  end
end
