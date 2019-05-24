class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :moderator, null: false

      t.timestamps
    end

    add_index :subs, :title, unique: true
    add_index :subs, :moderator
  end
end
