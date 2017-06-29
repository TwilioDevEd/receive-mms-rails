class CreateMmsResources < ActiveRecord::Migration[5.1]
  def change
    create_table :mms_resources do |t|
      t.string :filename

      t.timestamps
    end
  end
end
