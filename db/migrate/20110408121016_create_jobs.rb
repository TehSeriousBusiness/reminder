class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :user_id
	  t.string :sender
      t.text :destinations
      t.string :subject
      t.text :content
      t.binary :attachement
      t.datetime :kickOff
      t.integer :repetition
      t.integer :delay

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
