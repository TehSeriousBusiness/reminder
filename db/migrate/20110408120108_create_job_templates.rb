class CreateJobTemplates < ActiveRecord::Migration
  def self.up
    create_table :job_templates do |t|
      t.string :templateName
      t.string :templateSubject
      t.text :templateContent

      t.timestamps
    end
  end

  def self.down
    drop_table :job_templates
  end
end
