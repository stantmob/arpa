class CreateArTables < ActiveRecord::Migration
  def change

    create_table :repository_resources, :force => true do |t|
      t.string :name
      t.string :full_name
      t.timestamps null: false
    end

  end
end
