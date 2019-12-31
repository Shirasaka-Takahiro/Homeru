class CreateDescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :descriptions do |t|

      t.timestamps
    end
  end
end
