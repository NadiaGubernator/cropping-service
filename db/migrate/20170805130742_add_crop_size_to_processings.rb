class AddCropSizeToProcessings < ActiveRecord::Migration[5.1]
  def change
    add_column :processings, :crop_size, :string
  end
end
