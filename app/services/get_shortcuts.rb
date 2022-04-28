# frozen_string_literal: true

require 'yaml'
require 'pry'

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
    @shortcuts ||= list.flatten
  end

  def sheet
    YAML.load_file("#{ENV.fetch('SHEETS_PATH', nil)}/#{filters[:sheet]}.yml").as_json
  end

  def list
    sheet['shortcuts'].map do |category_hash|
      category = category_hash.keys.first
      category_hash.values.flatten.map do |shortcut_hash|
        name = shortcut_hash.keys.first
        shortcut = shortcut_hash.values.first.strip
        serialize(category, name, shortcut)
      end
    end
  end

  def serialize(category, name, shortcut)
    {
      name: category == "#{category}.#{name}",
      command: shortcut['command'] || shortcut,
      require: shortcut['require']
    }
  end
end
