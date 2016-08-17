class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.date :birthday
      t.string :phone
      t.string :picture
      t.string :country
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
