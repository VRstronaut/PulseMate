class CreateHealthMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :health_metrics do |t|
      t.string :name
      t.boolean :ok
      t.datetime :last_date_tested

      t.timestamps
    end
  end
end
