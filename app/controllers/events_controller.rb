class EventsController < ApplicationController

  before_filter :find_page

  def index
    present(@page)

    if params[:year] && params[:month]
      raise if params[:year] !~ /\d+/ || params[:month] !~ /\d+/
      date = Date.parse("#{params[:year]}-#{params[:month]}-01")
      @events = Event.where(["events.from > ? AND events.from < ?",date.beginning_of_day,date.end_of_month.end_of_day]).order("events.from DESC")
    elsif params[:date]
      raise if params[:date] !~ /\d{4}-\d{2}-\d{2}/
      date = Date.parse(params[:date])
      @events = Event.where(["events.from > ? AND events.from < ?",date.beginning_of_day,date.end_of_day]).order("events.from DESC")
    else
      @events = Event.paginate :page => params[:page], :per_page => RefinerySetting.find_or_set(:events_per_page, 10), :order => "position ASC"
    end

    respond_to do |format|
      format.html
      format.json do
        render :json => @events.map{ |e| {:date => e.from.to_date.to_s(:db), :day => e.from.day, :url => events_url(:date => e.from.to_date.to_s(:db))} }.to_json
      end
    end
  end

  def show
    @event = Event.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @event in the line below:
    present(@page)
  end

protected

  def find_page
    @page = Page.find_by_link_url("/events")
  end

end
