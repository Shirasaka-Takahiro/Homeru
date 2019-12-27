class CreateDescriptionEnglishes < ActiveRecord::Migration[6.0]
  def change
    create_table :description_englishes do |t|

      t.timestamps
    end
  end
end
