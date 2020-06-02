class CreateUserSkillLevel < ActiveRecord::Migration[6.0]
  def change
    create_table :user_skill_levels do |t|
      t.string :user_name
      t.string :skill
      t.integer :level
    end
  end
end
