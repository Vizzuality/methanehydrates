class ApplicationController < ActionController::Base

  include Refinery::ApplicationController

  before_filter :load_default_galleries, :only => [:sitemap]

  def load_default_galleries
    galleries_names = [
      'Methane gas hydrates and human activities',
      'Methane gas hydrates in the natural system',
      'Fire in the Ice',
      'Video resources'
    ]

    @named_galleries = Gallery.where(:name => galleries_names)
    @other_albumns = Gallery.where("name NOT IN (?)", galleries_names).limit(6)
  end

end
