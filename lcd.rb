#!/usr/bin/env ruby

require 'yaml'
require 'optparse'

class LCD
  # build arrays of expected display.
  def initialize(size:, digits:)
    @template = YAML.load_file('template.yml')
    @size = size.to_int
    @digits = digits.gsub(/\s+/, "")
  end

  def display
    puts horizontal("top")
    puts vertical("top")
    puts horizontal("middle")
    puts vertical("bottom")
    puts horizontal("bottom")
  end

  private

  def horizontal(position)
    result = ""
    digits.each_char do |d|
      bar = template.fetch(d.to_i).fetch("#{position}") ? "-" : " "
      digit_bars = " " + (bar * size) + " "
      result += digit_bars + " "
    end
    result
  end

  def vertical(position)
    result = ""
    size.times do
      digits.each_char do |d|
        bar_left = template.fetch(d.to_i).fetch("#{position}-left") ? "|" : " "
        bar_right = template.fetch(d.to_i).fetch("#{position}-right") ? "|" : " "
        digit_bars = bar_left + (" " * size) + bar_right
        result += digit_bars + " "
      end
      result += "\n"
    end
    result
  end

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

puts "Stripping away non-digit characters..." if ARGV[0] =~ /\D/

lcd = LCD.new(size: args.size, digits: ARGV[0].gsub(/\D/, ""))
lcd.display