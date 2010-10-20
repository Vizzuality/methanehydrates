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

  def three_column_text(text)
    if text.size < 200
      "<div class=\"block\">#{text}</div>"
    elsif text.size > 200 && text.size < 400
      text_list = text.split(' ')
      text1 = text_list[0...text_list.size / 2].join(' ')
      text2 = text_list[text_list.size/2..-1].join(' ')
      "<div class=\"block\">#{text1}</div><div class=\"block\">#{text2}</div>"
    else
      text_list = text.split(' ')
      text1 = text_list[0...text_list.size / 3].join(' ')
      text2 = text_list[text_list.size/3...(2*text_list.size)/3].join(' ')
      text3 = text_list[(2*text_list.size)/3...-1].join(' ')
      "<div class=\"block\">#{text1}</div><div class=\"block\">#{text2}</div><div class=\"block last\">#{text3}</div>"
    end
  end

end
