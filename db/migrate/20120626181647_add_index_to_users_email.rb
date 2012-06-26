class AddIndexToUsersEmail < ActiveRecord::Migration
  def 
    add_index :users, :email, unique: true
  end
end
