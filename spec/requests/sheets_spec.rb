# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe SheetsController, type: :request do
  before do
    ENV['SHEETS_PATH'] = 'app/sheets'
  end
  describe 'GET /index' do
    let(:expected_result) do
      %w[
        awk brew cat cd chmod chown convert cp curl cut date dhclient diff dnf
        docker dpkg find for git head hg history http ifconfig ip iptables iterm
        journalctl jq kill kubectl less ln ls mac markdown mkdir mount mysql
        mysqldump netstat nmap npm openssl paste patch pgrep ping pip psql pwd
        python rm ruby rubymine safari scd scp sed sort split sqlite3 sqlmap
        ssh ssh-add ssh-copy-id ssh-keygen stdout sudo systemctl systemd tail tee
        tidy tmux top tree truncate uname uniq vim vscode wget xargs zsh
      ]
    end

    it 'list available sheets' do
      get sheets_path

      expect(
        JSON.parse(response.body).symbolize_keys
      ).to eq(sheets: expected_result)
    end
  end
end
