#!/usr/bin/ruby -w

polymer = File.open("input").readlines[0].chomp

def reacts(a, b)
  return false if not a or not b
  return (a+b).swapcase == b+a
end

reacted = true
reacted_polymer = ""
until not reacted do
  reacted = false
  puts polymer

  i = 0
  while i < polymer.size do
    if reacts(polymer[i], polymer[i+1]) then
      reacted = true
      i += 1
    else
      reacted_polymer << polymer[i]
    end

    i += 1
  end

  polymer = reacted_polymer
  reacted_polymer = ""

end

puts polymer
puts polymer.size
