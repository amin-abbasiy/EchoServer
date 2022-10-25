class CreateAuthTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_tokens do |t|
      t.string :name
      t.text :value
      t.integer :token_type
      t.datetime :expire_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
