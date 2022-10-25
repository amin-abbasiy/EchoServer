class CreateEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :endpoints do |t|
      t.string :verb
      t.string :path
      t.string :code
      t.integer :endpoint_type
      t.jsonb :headers, default: {}
      t.jsonb :body, default: {}
      t.json :response, default: {}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :endpoints, :verb
    add_index :endpoints, [:user_id, :path, :verb] , unique: true
  end
end
