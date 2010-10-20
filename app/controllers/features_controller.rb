class FeaturesController < ApplicationController

  layout false, :only => 'index'

  before_filter :find_all_features
  before_filter :find_page
  layout false, :only => 'index'

  def index
    present(@page)

    respond_to do |format|
      format.html

      format.json do

        if params[:all]
          render :json => Feature.all.map{ |f| f.to_json_attributes.merge(:url => feature_url(f)) }.to_json and return
        end

        pagination_attributes = {:page => params[:page], :per_page => 4, :order => 'created_at DESC'}
        all_features = Feature.all
        if params[:institution]
          all_features = all_features.select{ |f| f.primary_institution_name == params[:institution] }
        end
        if params[:water_depth]
          all_features = all_features.select{ |f| f.water_depth.to_f <= params[:water_depth].to_f }
        end
        if params[:hydrate_depth]
          all_features = all_features.select do |f|
            if f.hydrate_depth.split(',').size == 1
              f.hydrate_depth.to_f <= params[:hydrate_depth].to_f
            else
              min_depth = f.hydrate_depth.split(',').map{ |h| h.to_f }.min
              min_depth <= params[:hydrate_depth].to_f
            end
          end.compact
        end
        if params[:name_or_country]
          all_features = all_features.select{ |f| f.title == params[:name_or_country] || f.country == params[:name_or_country]}
        end

        page = params[:page] && params[:page].to_i > 0 ? params[:page].to_i : 1
        all_features = WillPaginate::Collection.create(page, 4, all_features.size) do |pager|
          pager.replace(all_features.slice(pager.per_page * (pager.current_page-1), pager.per_page) || [])
        end
        render :json => all_features.empty? ? [].to_json : all_features.map{ |f| f.to_json_attributes.merge(:url => feature_url(f)) }.to_json and return
      end
    end

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

  # Institutions
  def institutions
    respond_to do |format|
      format.json do
        render :json => Feature.select("id, meta").map{ |f| f.primary_institution_name }.to_json
      end
    end
  end

protected

  def find_all_features
    @features = Feature.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/features")
  end

end
