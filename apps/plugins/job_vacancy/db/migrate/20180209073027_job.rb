class Job < CamaManager.migration_class
  def change
    unless table_exists? 'plugins_job'
      create_table :plugins_job do |t|
        t.integer :job_id
        t.string :customer, :email, :phone
        t.datetime :received_at, :accepted_at, :shipped_at, :closed_at
        t.timestamps
      end
    end
  end
end
