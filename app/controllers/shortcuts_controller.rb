# frozen_string_literal: true

class ShortcutsController < ApplicationController
  def index
    render json: { shortcuts: GetShortcuts.new(filters).call }
  end

  private

  def filters
    {
      sheet: base_params[:sheet_id]
    }
  end

  def base_params
    params.require(:sheet_id)
    params.permit(:sheet_id, :category, :tag)
  end
end
