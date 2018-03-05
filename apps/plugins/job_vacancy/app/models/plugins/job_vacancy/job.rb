class Plugins::JobVacancy::Job < ActiveRecord::Base
  include CamaleonCms::Metas
  self.table_name = 'plugins_job'
  belongs_to :job, foreign_key: :job_id, class_name: 'CamaleonCms::Post'

end
