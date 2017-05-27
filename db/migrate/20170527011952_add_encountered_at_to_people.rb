class AddEncounteredAtToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :encountered_at, :datetime
  end
end
