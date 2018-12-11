#!/usr/bin/ruby -w

# part 2
repeats = {}
changelist = []
File.open("input", "r").readlines.each do |line|
  changelist << line.to_i()
end

freq = 0
found = false
while !found do
  changelist.each do |f|
    freq += f
    if repeats[freq] != nil then
      puts freq
      found = true
      break
    end

    repeats[freq] = 1
  end
end
