# frozen_string_literal: true

class ApplicationService
  def call
    validate!
  end

  protected

  def validate!
    raise 'missing environment variable for SHEETS_PATH' unless ENV['SHEETS_PATH']
  end
end
