class FeaturesController < ApplicationController

  before_filter :find_all_features
  before_filter :find_page
  layout false, :only => 'index'

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @feature in the line below:
    present(@page)
  end

  def show
    @feature = Feature.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @feature in the line below:
    present(@page)
  end

  # Return a random feature and redirect to it
  def random
    feature = Feature.find(:first, :offset => rand(Feature.count))
    redirect_to feature_url(feature) and return
  end

protected

  def find_all_features
    @features = Feature.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/features")
  end

end
