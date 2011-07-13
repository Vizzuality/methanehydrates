class ApplicationController < ActionController::Base

  include Refinery::ApplicationController

  before_filter :load_default_galleries, :only => [:sitemap]

  def load_default_galleries
    galleries_names = [
      'Book 1: Methane gas hydrates in nature',
      'Book 2: Methane gas hydrates and human impacts',
      'Fire in the Ice',
      'Video resources'
    ]

    @named_galleries = Gallery.where(:name => galleries_names).order('name')
    @other_albumns = Gallery.where("id NOT IN (?)", @named_galleries.map(&:id)).limit(6)
  end

end
