# frozen_string_literal: true

# This module contains application helper logic
module ApplicationHelper
  def display_date(date)
    if date
      date.strftime('%m/%d/%Y')
    else
      ' '
    end
  end
end
