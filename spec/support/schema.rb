ActiveRecord::Schema.define do
  self.verbose = false

  create_table :test_repositories, :force => true do |t|
    t.string :name
    t.timestamps null: false
  end

end
