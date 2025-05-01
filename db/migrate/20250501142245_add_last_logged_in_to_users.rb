class AddLastLoggedInToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :last_logged_in, :datetime
  end
end
