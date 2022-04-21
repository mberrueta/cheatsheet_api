# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shortcuts', type: :request do
  before do
    ENV['SHEETS_PATH'] = 'spec/test_sheets'
  end
  describe 'GET /sheets/:sheet_id/shortcuts' do
    let(:result) do
      [
        { command: 'F11', name: 'view desktop', 'require' => nil },
        { command: '^ RIGHT', name: 'view right_desk', 'require' => nil },
        { command: 'OPT COMMAND SPACE', name: 'finder finder_search', 'require' => nil },
        { command: '^ F2', name: 'quick_access menu_bar', 'require' => nil },
        { command: '^ OPT LEFT', name: 'quick_access windows_left', require: 'rectangle' }
      ]
    end
    it 'list available sheets' do
      get sheet_shortcuts_path('mac')

      expect(
        JSON.parse(response.body).with_indifferent_access
      ).to match(shortcuts: result)
    end
  end
end
