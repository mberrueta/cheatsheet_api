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
            { 'command' => 'F11', 'name' => 'default.Desktop', 'require' => nil },
            { 'command' => '^ F2', 'name' => 'default.Menu Bar', 'require' => nil },
            { 'command' => '^ F3', 'name' => 'default.Dock', 'require' => nil },
            { 'command' => '^ F4', 'name' => 'default.Next Win', 'require' => nil },
            { 'command' => '^ F5', 'name' => 'default.Tool Bar', 'require' => nil },
            { 'command' => '^ F6', 'name' => 'default.floating windows', 'require' => nil },
            { 'command' => '⌘ `', 'name' => 'default.Next window', 'require' => nil },
            { 'command' => '⌘ Shift /', 'name' => 'default.Help menu', 'require' => nil },
            { 'command' => '^ OPT ⌘ SPACE', 'name' => 'default.Launchpad', 'require' => nil },
            { 'command' => '^ ⌘ SPACE', 'name' => 'default.emojis', 'require' => nil },
            { 'command' => 'OPT ⌘ SPACE', 'name' => 'default.Finder search', 'require' => nil },
            { 'command' => '^ UP', 'name' => 'default.Mission control', 'require' => nil },
            { 'command' => '^ DOWN', 'name' => 'default.App window', 'require' => nil },
            { 'command' => '^ RIGHT', 'name' => 'default.Right Desk', 'require' => nil },
            { 'command' => '^ LEFT', 'name' => 'default.Left Desk', 'require' => nil },
            { 'command' => 'Shift ⌘ 4', 'name' => 'default.Screen Shot', 'require' => nil },
            { 'command' => 'Shift ⌘ 5', 'name' => 'default.Screen Shot Opt', 'require' => nil },
            { 'command' => 'Shift  F10', 'name' => 'default.Context Menu', 'require' => nil },
            { 'command' => '⌘ Enter', 'name' => 'default.FullScreen/Restore', 'require' => nil },
            { 'command' => 'OPT ⌘ 8', 'name' => 'default.ZOOM', 'require' => nil },
            { 'command' => 'OPT ⌘ ;', 'name' => 'default.ZOOM red', 'require' => nil },
            { 'command' => "OPT ⌘ '", 'name' => 'default.ZOOM inc', 'require' => nil },
            { 'command' => '^ OPT M', 'name' => 'default.Maximize', 'require' => nil },
            { 'command' => '^ OPT R', 'name' => 'default.Restore', 'require' => nil },
            { 'command' => '^ OPT UP', 'name' => 'default.Windows up', 'require' => nil },
            { 'command' => '^ OPT DOWN', 'name' => 'default.Windows down', 'require' => nil },
            { 'command' => '^ OPT RIGHT', 'name' => 'default.Windows right', 'require' => nil },
            { 'command' => '^ OPT LEFT', 'name' => 'default.Windows left', 'require' => nil }
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
        Dir.children(ENV.fetch('SHEETS_PATH', nil))
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
