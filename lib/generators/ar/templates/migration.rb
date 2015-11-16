class CreateArTables < ActiveRecord::Migration
  def change

    create_table :repository_resources, :force => true do |t|
      t.string :name
      t.string :full_name
      t.timestamps null: false
    end

    create_table :repository_actions, :force => true do |t|
      t.string :name
      t.references :repository_resource, index: true
      t.timestamps null: false
    end

    add_foreign_key :repository_actions, :repository_resources

    create_table :repository_roles, :force => true do |t|
      t.string :name
      t.string :description
      t.boolean :removed, default: false
      t.timestamps null: false
    end

    create_join_table :repository_actions, :repository_roles, :force => true do |t|
      t.index :repository_action_id, name: 'action_role_id'
      t.index :repository_role_id, name: 'role_action_id'
    end


  end
end
