#!/usr/bin/ruby -w

polymer_in = File.open("input").readlines[0].chomp
ptypes = polymer_in.downcase.chars.uniq

def reacts(a, b)
  return false if not a or not b
  return (a+b).swapcase == b+a
end

def react(polymer)
  reacted = true
  reacted_polymer = ""
  until not reacted do
    reacted = false
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

  return polymer
end

ptypes.map!{|t|
  [t, react(polymer_in.tr(t + t.swapcase, ''))]
}

puts (ptypes.min{|a,b| a[1].size <=> b[1].size})[1].size
