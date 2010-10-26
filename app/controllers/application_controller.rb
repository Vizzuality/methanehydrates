class ApplicationController < ActionController::Base

  include Refinery::ApplicationController

  before_filter :load_default_galleries, :only => [:sitemap]

  def load_default_galleries
    @human_activities_gallery = Gallery.find_by_name('Methane gas hydrates and human activities')
    @natural_system_gallery   = Gallery.find_by_name('Methane gas hydrates in the natural system')
    all_galleries = Gallery.where("id != #{@human_activities_gallery.id} AND id != #{@natural_system_gallery.id}")
    features_galleries = Feature.all.map(&:gallery)
    @sites_by_region_galleries = all_galleries - features_galleries
  end

end
