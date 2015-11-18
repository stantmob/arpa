class createProfilesAssociation < ActiveRecord::Migration
  def change
    create_join_table :repository_profiles, :users, :force => true do |t|
      t.index :repository_profile_id, name: 'profile_user_id'
      t.index :user_id, name: 'user_profile_id'
    end
  end
end
