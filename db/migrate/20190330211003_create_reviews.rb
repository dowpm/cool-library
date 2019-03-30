class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :stars
      t.text :comments

      t.timestamps
    end
  end
end
