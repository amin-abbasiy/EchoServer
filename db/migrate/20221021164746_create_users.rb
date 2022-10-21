class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :password_reset_sent_at
      t.string :encrypted_otp
      t.integer :failed_attempts
      t.boolean :verified
      t.datetime :verfied_at

      t.timestamps
    end

    add_index :users, :username
  end
end
