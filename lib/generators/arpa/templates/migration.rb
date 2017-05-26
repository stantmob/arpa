class CreateArpaTables < ActiveRecord::Migration
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

    create_table :repository_profiles, :force => true do |t|
      t.string :name
      t.string :description
      t.boolean :removed, default: false
      t.timestamps null: false
    end

    create_join_table :repository_roles, :repository_profiles, :force => true do |t|
      t.index :repository_role_id, name: 'role_profile_id'
      t.index :repository_profile_id, name: 'profile_role_ids'
    end

    create_join_table :repository_profiles, <%= ":#{@associate_table}" %>, :force => true do |t|
      t.index :repository_profile_id, name: 'profile_user_id'
      t.index <%= ":#{@associate_primary_key}"  %>, name: 'user_profile_id'
    end

    add_column <%= ":#{@associate_table}" %>, :is_arpa_admin, :boolean, default: false

    add_column :repository_profiles, :entity_id, :integer, default: nil
    add_column :repository_profiles, :entity_class, :string, default: nil

  end
end
