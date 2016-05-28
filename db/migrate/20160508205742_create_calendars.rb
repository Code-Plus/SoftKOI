class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :date
      t.text :description
      t.string :title
      t.time :hour
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
