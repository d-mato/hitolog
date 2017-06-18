class CreateImpressions < ActiveRecord::Migration[5.1]
  def change
    create_table :impressions do |t|
      t.references :person, foreign_key: true
      t.text :comment
      t.date :date

      t.timestamps
    end
  end
end
