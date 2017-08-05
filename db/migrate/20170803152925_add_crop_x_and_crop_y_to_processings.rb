class AddCropXAndCropYToProcessings < ActiveRecord::Migration[5.1]
  def change
    add_column :processings, :crop_x, :integer
    add_column :processings, :crop_y, :integer
  end
end
