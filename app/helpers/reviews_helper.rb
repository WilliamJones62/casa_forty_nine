# frozen_string_literal: true

# This module contains review helper logic
module ReviewsHelper
  def display_date_range(date1, date2)
    if date1 && date2
      "#{date1.strftime('%m/%d/%Y')} - #{date2.strftime('%m/%d/%Y')}"
    else
      ' '
    end
  end
end
