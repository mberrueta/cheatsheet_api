# frozen_string_literal: true

class GetSheets < ApplicationService
  def call
    super
    sheets
  end

  private

  def sheets
    @sheets ||= Dir.children(ENV.fetch('SHEETS_PATH', nil))
                   .map { |f| f.remove('.yml') }
                   .sort
  end
end
