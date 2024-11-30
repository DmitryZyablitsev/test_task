class CreateInterestsAndUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :interests_users do |t|
      t.belongs_to :interest
      t.belongs_to :user

      t.timestamps
    end
  end
end
