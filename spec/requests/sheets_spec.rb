# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe SheetsController, type: :request do
  before do
    ENV['SHEETS_PATH'] = 'spec/test_sheets'
  end
  describe 'GET /index' do
    it 'list available sheets' do
      get sheets_path

      expect(
        JSON.parse(response.body).symbolize_keys
      ).to eq(sheets: %w[mac vscode])
    end
  end
end
