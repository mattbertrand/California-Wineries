class CreateWineries < ActiveRecord::Migration[6.1]
  def change
    create_table :wineries do |t|
      t.string :name
      t.string :website
      t.string :phone
      t.text :description
      t.belongs_to :user, foreign_key: true
      t.belongs_to :region, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
