class CreateSkillsAndUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :skills_users do |t|
      t.belongs_to :skill
      t.belongs_to :user

      t.timestamps
    end
  end
end
