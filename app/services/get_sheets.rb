class GetSheets < ApplicationService
  def call
    super
    sheets
  end

  private

  def validate
    raise 'missing environment variable for SHEETS_PATH' unless ENV['SHEETS_PATH']
  end

  def sheets
    @sheets ||= Dir.children(ENV['SHEETS_PATH'])
                   .map { |f| f.remove('.yml') }
  end
end