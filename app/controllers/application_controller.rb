class ApplicationController < ActionController::Base

  include Refinery::ApplicationController

  before_filter :load_default_galleries, :only => [:sitemap]

  def load_default_galleries
    galleries_names = [
      'Methane gas hydrate sites by region',
      'Methane gas hydrates and human activities',
      'Methane gas hydrates in the natural system',
      'Video resources'
    ]

    @named_galleries = Gallery.where(:name => galleries_names).order('name ASC')
    @other_albumns = Gallery.where("name NOT IN (?)", galleries_names).limit(6)
  end

end
