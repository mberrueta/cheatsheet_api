# frozen_string_literal: true

require 'open3'

class BuildAllDefaultSheets < ApplicationService
  def call
    super

    build
  end

  private

  def build
    call_cheat_cmd do |result|
      result.drop(1).each do |line|
        name, _, tags = line.split(' ')
        # print "#{name}, #{tags.split(',')}"
        puts name
        begin
          BuildSheet.new(name, tags.split(',')).call
        rescue => e
          puts "failed to build #{name} #{e}"
        end
      end
    end
  end

  def call_cheat_cmd
    _, stdout, stderr = Open3.popen3('cheat', '-l')
    result = stdout.readlines
    stdout.close
    stderr.close

    yield(result)
  end
end
