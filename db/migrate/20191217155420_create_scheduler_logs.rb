class CreateSchedulerLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduler_logs do |t|
      t.string :kind
      t.text :list

      t.timestamps
    end
  end
end
