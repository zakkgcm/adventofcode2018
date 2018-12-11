#!/usr/bin/ruby -w

two_letters = 0
three_letters = 0

box_ids = []

File.open("input", "r").readlines.each do |new_id|
  box_ids.each do |id|
    hdist = 0
    diff_id = ""
    id.chars.zip(new_id.chars).each do |a,b|
      hdist += 1 if a != b
      diff_id << a if a == b
    end

    puts diff_id if hdist <= 1
  end
  box_ids << new_id
end

checksum = two_letters * three_letters
puts checksum
