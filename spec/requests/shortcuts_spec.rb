# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Shortcuts', type: :request do
  before do
    ENV['SHEETS_PATH'] = 'app/sheets'
  end
  describe 'GET /sheets/:sheet_id/shortcuts' do
    context('mac') do
      let(:result) do
        {
          'shortcuts' => [
            { 'command' => 'F11', 'name' => false, 'require' => nil },
            { 'command' => '^ F2', 'name' => false, 'require' => nil },
            { 'command' => '^ F3', 'name' => false, 'require' => nil },
            { 'command' => '^ F4', 'name' => false, 'require' => nil },
            { 'command' => '^ F5', 'name' => false, 'require' => nil },
            { 'command' => '^ F6', 'name' => false, 'require' => nil },
            { 'command' => '⌘ `', 'name' => false, 'require' => nil },
            { 'command' => '⌘ Shift /', 'name' => false, 'require' => nil },
            { 'command' => '^ OPT ⌘ SPACE', 'name' => false, 'require' => nil },
            { 'command' => '^ ⌘ SPACE', 'name' => false, 'require' => nil },
            { 'command' => 'OPT ⌘ SPACE', 'name' => false, 'require' => nil },
            { 'command' => '^ UP', 'name' => false, 'require' => nil },
            { 'command' => '^ DOWN', 'name' => false, 'require' => nil },
            { 'command' => '^ RIGHT', 'name' => false, 'require' => nil },
            { 'command' => '^ LEFT', 'name' => false, 'require' => nil },
            { 'command' => 'Shift ⌘ 4', 'name' => false, 'require' => nil },
            { 'command' => 'Shift ⌘ 5', 'name' => false, 'require' => nil },
            { 'command' => 'Shift  F10', 'name' => false, 'require' => nil },
            { 'command' => '⌘ Enter', 'name' => false, 'require' => nil },
            { 'command' => 'OPT ⌘ 8', 'name' => false, 'require' => nil },
            { 'command' => 'OPT ⌘ ;', 'name' => false, 'require' => nil },
            { 'command' => "OPT ⌘ '", 'name' => false, 'require' => nil },
            { 'command' => '^ OPT M', 'name' => false, 'require' => nil },
            { 'command' => '^ OPT R', 'name' => false, 'require' => nil },
            { 'command' => '^ OPT UP', 'name' => false, 'require' => nil },
            { 'command' => '^ OPT DOWN', 'name' => false, 'require' => nil },
            { 'command' => '^ OPT RIGHT', 'name' => false, 'require' => nil },
            { 'command' => '^ OPT LEFT', 'name' => false, 'require' => nil }
          ]
        }
      end
      it 'list available sheets' do
        get sheet_shortcuts_path('mac')

        expect(
          JSON.parse(response.body).with_indifferent_access
        ).to match(result)
      end
    end

    context('all') do
      let(:list) do |_f|
        Dir.children(ENV['SHEETS_PATH'])
           .map { |f| f.remove('.yml') }
      end

      it 'list available sheets' do
        list.each do |sheet|
          get sheet_shortcuts_path(sheet)

          expect(response.code).to eq('200')
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
