class CreateCurrentTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :current_tokens do |t|
      t.string :access_token

      t.timestamps
    end
  end
end
