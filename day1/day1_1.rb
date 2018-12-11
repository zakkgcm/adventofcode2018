#!/usr/bin/ruby -w

# part 1
freq = 0
File.open("input", "r").readlines.each do |line|
  freq += line.to_i()
end

puts freq
