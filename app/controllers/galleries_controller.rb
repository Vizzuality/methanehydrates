class GalleriesController < ApplicationController

  before_filter :find_all_galleries, :except => [:index]
  before_filter :find_page

  def index
    load_default_galleries
    @galleries_without_features = Gallery.first(2)

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @gallery_entry in the line below:
    present(@page)
  end

  def show
    load_default_galleries

    @gallery = Gallery.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @gallery_entry in the line below:
    present(@page)
  end

protected

  def find_all_galleries
    @galleries = Gallery.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/galleries")
  end

end
