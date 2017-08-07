class AddSlugToProcessings < ActiveRecord::Migration[5.1]
  def change
    add_column :processings, :slug, :string
    add_index  :processings, :slug, unique: true
  end
end
