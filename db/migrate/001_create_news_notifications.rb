class CreateNewsNotifications < ActiveRecord::Migration
  def self.up
    create_table :news_notifications, {:id => false}  do |t|
      t.integer :user_id, :null => false
      t.integer :news_id, :null => false
      t.datetime :read_on, :null => false
    end
    add_index :news_notifications, [:user_id, :news_id], :unique => true
  end

  def self.down
    drop_table :news_notifications
  end
end
