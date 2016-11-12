class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.text :message
      t.references :user, foreign_key: true
      t.integer :processor_id, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
