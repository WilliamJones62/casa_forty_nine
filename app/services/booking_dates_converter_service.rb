# frozen_string_literal: true

# service to convert calendar selected dates to the start and end dates
class BookingDatesConverterService < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    @selected_dates = JSON.parse(@params[:selected])
    extract_dates
    format_dates
    @start_end_dates
  end

  private

  def extract_dates
    @keys = @selected_dates.keys
    @values = @selected_dates.values
    extract_start_date
    extract_end_date
  end

  def extract_start_date
    @start_year = @keys.first
    start_value = @values.first
    @start_month = start_value.keys.first
    start_days = start_value.values.first
    @start_day = start_days.first
  end

  def extract_end_date
    @end_year = @keys.last
    end_value = @values.last
    @end_month = end_value.keys.last
    end_days = end_value.values.last
    @end_day = end_days.last
  end

  def format_dates
    puts "@start_year = #{@start_year}"
    puts "@start_month = #{@start_month}"
    puts "@start_day = #{@start_day}"
    start_date = Date.new(@start_year.to_i, @start_month.to_i + 1, @start_day)
    end_date = Date.new(@end_year.to_i, @end_month.to_i + 1, @end_day)
    @start_end_dates = { start_date: start_date, end_date: end_date }
  end
end
