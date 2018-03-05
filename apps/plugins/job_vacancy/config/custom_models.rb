Rails.application.config.to_prepare do
  CamaleonCms::Site.class_eval do
    #attr_accessible :my_id

    has_many :job_divisions, :class_name => "Plugins::JobVacancy::JobDivision", foreign_key: :parent_id, dependent: :destroy

    # return all the products for current site
    def job
      post_types.where(slug: 'job').first.try(:posts)
    end
end


  CamaleonCms::SiteDecorator.class_eval do
    # return the current system currency unit

    # return all visible products fo current user in current site
    def the_job
      the_posts('job')
    end
  end

end

