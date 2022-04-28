# frozen_string_literal: true

require 'open3'
require 'yaml'
require 'pry'

class BuildSheet < ApplicationService
  attr_reader :sheet, :tags

  def initialize(sheet, tags = [])
    super()
    @sheet = sheet.to_s
    @tags = tags
  end

  def call
    super

    build_yml
  end

  private

  def build_yml
    File.write(file_name, hash.deep_stringify_keys.to_yaml) if write?
  end

  def write?
    if File.exist?(file_name)
      tmp = YAML.load_file(file_name)
      return !tmp['edited']
    end
    true
  end

  def hash
    @hash ||= {
      description: "Generated sheet for #{sheet}",
      tags:,
      shortcuts: [
        default: local_sheet.map { |k, v| { k => v } }
      ]
    }
  end

  def local_sheet
    @local_sheet ||= call_cheat_cmd do |result|
      result.each { |l| build_line(l).strip }

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

  def file_name
    "#{ENV['SHEETS_PATH']}/#{sheet}.yml"
  end
end
