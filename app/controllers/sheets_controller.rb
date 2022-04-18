# frozen_string_literal: true

class SheetsController < ApplicationController
  def index
    render json: { sheets: GetSheets.new.call }
  end
end
