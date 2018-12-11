#!/usr/bin/ruby -w

two_letters = 0
three_letters = 0

File.open("input", "r").readlines.each do |line|
  letters = Hash.new(0)
  
  line.each_char { |c| letters[c] += 1 }
  two_letters += 1 if letters.values.any? { |v| v == 2 }
  three_letters += 1 if letters.values.any? { |v| v == 3 }
end

checksum = two_letters * three_letters
puts checksum
