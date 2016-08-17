class AddIndexesToTable < ActiveRecord::Migration[5.0]
  def change
      add_index :people, :name
      add_index :people, :birthday
      add_index :people, :phone
  end
end
