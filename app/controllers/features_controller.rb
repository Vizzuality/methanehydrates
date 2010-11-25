class FeaturesController < ApplicationController

  before_filter :find_page
  layout 'application', :except => 'index'

  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::RawOutputHelper
  include ActionView::Helpers::TextHelper

  def index

    present(@page)

    respond_to do |format|
      format.html do
        @features = if params[:all]
          Feature.paginate :page => params[:page], :per_page => Feature.count, :order => 'created_at ASC'
        elsif params[:name_or_country]
          all_features = Feature.all.select{ |f| f.title == params[:name_or_country] || f.country == params[:name_or_country]}
          page = params[:page] && params[:page].to_i > 0 ? params[:page].to_i : 1
          WillPaginate::Collection.create(page, 10, all_features.size) do |pager|
            pager.replace(all_features.slice(pager.per_page * (pager.current_page-1), pager.per_page) || [])
          end
        else
          Feature.paginate :page => params[:page], :per_page => 10, :order => 'created_at ASC'
        end
      end

      format.json do

        base_json = {
          :prev_page_url => nil,
          :next_page_url => nil,
          :features => []
        }

        if params[:all]
          render :json => base_json.merge(:features => Feature.all.map{ |f| f.to_json_attributes.merge(:url => feature_url(f), :id => f.id, :description => truncate(strip_tags(f.description),
                            :omission => raw("... <a href=\"#{feature_url(f)}\">Read more</a>"),
                            :length => 250,
                            :preserve_html_tags => true)) }).to_json and return
        end

        pagination_attributes = {:page => params[:page], :per_page => 10, :order => 'created_at ASC'}
        all_features = Feature.all
        if params[:institution] && params[:institution] != 'All'
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
        all_features = WillPaginate::Collection.create(page, 10, all_features.size) do |pager|
          pager.replace(all_features.slice(pager.per_page * (pager.current_page-1), pager.per_page) || [])
        end
        if all_features.empty?
          json = base_json
        else
          json = base_json.merge(:features => all_features.map{ |f| f.to_json_attributes.merge(:url => feature_url(f), :id => f.id, :description => truncate(strip_tags(f.description),
                            :omission => raw("... <a href=\"#{feature_url(f)}\">Read more</a>"),
                            :length => 250,
                            :preserve_html_tags => true)) })
          filter_params = {:institution => params[:institution], :hydrate_depth => params[:hydrate_depth], :name_or_country => params[:name_or_country], :water_depth => params[:water_depth]}
          if all_features.current_page > 1
            json[:prev_page_url] = features_url(filter_params.merge(:page => all_features.previous_page))
          end
          if all_features.current_page < all_features.total_pages
            json[:next_page_url] = features_url(filter_params.merge(:page => all_features.next_page))
          end
        end
        render :json => json.to_json and return
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
        render :json => (['All'] + Feature.select("id, meta").map{ |f| f.primary_institution_name }).to_json
      end
    end
  end

protected

  def find_page
    @page = Page.find_by_link_url("/features")
  end

end
