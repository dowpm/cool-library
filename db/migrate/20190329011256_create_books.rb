class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :isbn
      t.integer :nbr_page
      t.string :summary
      t.integer :publication_year
      t.integer :user_id

      t.timestamps
    end
  end
end
