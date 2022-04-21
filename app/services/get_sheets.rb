# frozen_string_literal: true

class GetSheets < ApplicationService
  def call
    super
    sheets
  end

  private

  def sheets
    @sheets ||= Dir.children(ENV['SHEETS_PATH'])
                   .map { |f| f.remove('.yml') }
                   .sort
  end
end
