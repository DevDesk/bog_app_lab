class CreateCreaturesTags < ActiveRecord::Migration
  def change
    create_table :creatures_tags do |t|
      t.references :creature, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
