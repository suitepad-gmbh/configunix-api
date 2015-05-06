class CreatePuppetClasses < ActiveRecord::Migration
  def change
    create_table :puppet_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
