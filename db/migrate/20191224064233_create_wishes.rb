class CreateWishes < ActiveRecord::Migration[5.2]
  def change
    create_table :wishes do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.index(%i[user_id book_id], unique: true)

      t.timestamps
    end
  end
end
