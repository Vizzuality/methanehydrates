module ApplicationHelper

  include Refinery::ApplicationHelper
  
  def to_ordinal(d)
    if d == 1
      "#{d}st"
    elsif d == 2
      "#{d}nd"
    elsif d == 3
      "#{d}rd"
    else
      "#{d}th"
    end
  end
  

end
