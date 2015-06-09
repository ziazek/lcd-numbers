#!/usr/bin/env ruby

require 'yaml'
require 'pp'
require 'optparse'

class LCD
  # build arrays of expected display.
  def initialize(size:, digits:)
    @template = YAML.load_file('template.yml')
    @size = size.to_int
    @digits = digits.gsub(/\s+/, "")
  end

  def display
    puts row_1
    puts row_2
    puts row_3
    puts row_4
    puts row_5
  end

  def row_1
    result = ""
    digits.each_char do |d|
      bar = template.fetch(d.to_i).fetch("top") ? "-" : " "
      digit_bars = " " + (bar * size) + " "
      result += digit_bars + " "
    end
    result
  end

  def row_2
    result = ""
    size.times do
      digits.each_char do |d|
        bar_left = template.fetch(d.to_i).fetch("top-left") ? "|" : " "
        bar_right = template.fetch(d.to_i).fetch("top-right") ? "|" : " "
        digit_bars = bar_left + (" " * size) + bar_right
        result += digit_bars + " "
      end
      result += "\n"
    end
    result
  end

  def row_3
    result = ""
    digits.each_char do |d|
      bar = template.fetch(d.to_i).fetch("middle") ? "-" : " "
      digit_bars = " " + (bar * size) + " "
      result += digit_bars + " "
    end
    result
  end

  def row_4
    result = ""
    size.times do
      digits.each_char do |d|
        bar_left = template.fetch(d.to_i).fetch("bottom-left") ? "|" : " "
        bar_right = template.fetch(d.to_i).fetch("bottom-right") ? "|" : " "
        digit_bars = bar_left + (" " * size) + bar_right
        result += digit_bars + " "
      end
      result += "\n"
    end
    result
  end

  def row_5
    result = ""
    digits.each_char do |d|
      bar = template.fetch(d.to_i).fetch("bottom") ? "-" : " "
      digit_bars = " " + (bar * size) + " "
      result += digit_bars + " "
    end
    result
  end

  private

  attr_accessor :template, :size, :digits
end

# expected syntax: lcd.rb 012345
# or: lcd.rb -s 1 6789

Options = Struct.new(:size)

args = Options.new(2)
OptionParser.new do |o|
  o.on('-s INT', 'Size of LCD digits') { |b| args.size = b.to_i }
  o.on('-h', 'Help') { puts o; exit }
  o.parse!
end

# ensure there is an argument and there is at least one digit
exit unless (ARGV.size == 1 && ARGV[0].gsub(/\D/, "").size > 0)

lcd = LCD.new(size: args.size, digits: ARGV[0].gsub(/\D/, ""))
lcd.display