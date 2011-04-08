class CreateMailServers < ActiveRecord::Migration
  def self.up
    create_table :mail_servers do |t|
      t.string :address
      t.string :password
      t.string :host
      t.integer :port

      t.timestamps
    end
  end

  def self.down
    drop_table :mail_servers
  end
end
