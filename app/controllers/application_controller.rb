class ApplicationController < ActionController::Base

  include Refinery::ApplicationController

  def load_default_galleries
    @human_activities_gallery = Gallery.find_by_name('Methane gas hydrates and human activities')
    @natural_system_gallery   = Gallery.find_by_name('Methane gas hydrates in the natural system')
    @sites_by_region_gallery  = Gallery.find_by_name('Methane gas hydrates research sites by region')
  end

end
