# frozen_string_literal: true

require 'yaml'
require('pry')

class GetShortcuts < ApplicationService
  attr_reader :filters

  def initialize(filters)
    super()
    @filters = filters
  end

  def call
    super
    shortcuts
  end

  private

  def validate!
    super
    raise 'missing sheet' unless filters[:sheet]
  end

  def shortcuts
    @shortcuts ||= list.sort_by { |element| element.keys.first }
  end

  def sheet
    YAML.load_file("#{ENV['SHEETS_PATH']}/#{filters[:sheet]}.yml").as_json
  end

  def list
    sheet['shortcuts'].flat_map do |category|
      category.values.first.flat_map do |shortcut|
        serialize(category, shortcut)
      end
    end
  end

  def serialize(category, shortcut)
    {
      name: "#{category.keys.first} #{shortcut.keys.first}",
      command: shortcut.values.first['command'] || shortcut.values.first,
      require: shortcut.values.first['require']
    }
  end
end
