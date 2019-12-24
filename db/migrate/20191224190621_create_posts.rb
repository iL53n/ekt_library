class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.belongs_to :book
      t.belongs_to :user
      t.date :end_date

      t.timestamps
    end
  end
end
