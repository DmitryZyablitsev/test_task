class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :patronymic, default: nil
      t.string :email, index: { unique: true }
      t.integer :age, null: false
      t.string :nationality, null: false
      t.string :country, null: false
      t.string :gender, null: false

      t.timestamps
    end
  end
end
