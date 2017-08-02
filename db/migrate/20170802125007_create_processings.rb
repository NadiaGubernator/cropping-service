class CreateProcessings < ActiveRecord::Migration[5.1]
  def change
    create_table :processings do |t|
      t.string :image
      t.string :remote_image_url

      t.timestamps
    end
  end
end
