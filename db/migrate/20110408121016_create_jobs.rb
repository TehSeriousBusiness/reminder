class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :initiator
      t.text :destinations
      t.string :subject
      t.text :content
      t.binary :attachement
      t.date :kickOff
      t.integer :repetition
      t.integer :delay

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
