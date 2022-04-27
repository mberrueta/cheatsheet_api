# frozen_string_literal: true

require 'open3'
require 'yaml'

class BuildSheet < ApplicationService
  attr_reader :sheet, :tags

  def initialize(sheet, tags = [])
    super()
    @sheet = sheet
    @tags = tags
  end

  def call
    super

    # local_sheet
    build_yml
  end

  private

  def build_yml
    File.write("#{ENV['SHEETS_PATH']}/#{sheet}.yml", hash.to_yaml)
  end

  def hash
    @hash ||= {
      description: "Generated sheet for #{sheet}",
      tags:,
      shortcuts: {
        defaults: local_sheet
      }
    }
  end

  def local_sheet
    @local_sheet = call_cheat_cmd do |result|
      result.each { |l| build_line(l) }

      cheats
    end
  end

  def build_line(line)
    if line.start_with?('#')
      @current_cheat = line.remove('#').strip
    else
      cheats[current_cheat] = cheats[current_cheat] ? cheats[current_cheat] + line : line
    end
  end

  def call_cheat_cmd
    _, stdout, stderr = Open3.popen3('cheat', sheet)
    result = stdout.readlines
    stdout.close
    stderr.close

    yield(result)
  end

  def cheats
    @cheats ||= {}
  end

  def current_cheat
    @current_cheat ||= 'wtf'
  end
end
