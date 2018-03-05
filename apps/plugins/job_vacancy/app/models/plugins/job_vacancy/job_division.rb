class Plugins::JobVacancy::JobDivision < CamaleonCms::TermTaxonomy
  default_scope { where(taxonomy: :job_vacancy_job_division) }
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key: :parent_id
  scope :actives, -> {where(status: '1')}

  def the_name
    "#{name}"
  end

end