class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.string :email, unique: true
      t.string :password_digest, null: false
      t.string :password_reset_sent_at
      t.string :encrypted_otp
      t.integer :failed_attempts
      t.boolean :verified
      t.datetime :verfied_at

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
