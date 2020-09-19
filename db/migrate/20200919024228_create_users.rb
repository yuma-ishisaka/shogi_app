class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :profile
      t.string :battle_app
      t.string :kiryoku

      t.timestamps
    end
  end
end
