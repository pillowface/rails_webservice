class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.string :comment
      t.string :created_by

      t.timestamps
    end
  end
end
