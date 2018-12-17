#!/usr/bin/ruby -w

claims = {}
overlaps = {}
fabric_map = []
Claim = Struct.new(:id, :left, :top, :width, :height)
claim_re = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/

File.open("input", "r").readlines.each do |cline|
  claim_re.match(cline) { |m|
    m = m.to_a.map(&:to_i)
    claim = Claim.new(m[1], m[2], m[3], m[4], m[5])
    
    overlaps[claim.id] = false

    # add the claim to the fabric map and note any overlaps
    for i in claim.top .. claim.top + claim.height-1 do
      for j in claim.left .. claim.left + claim.width-1 do
        fabric_map[i] = [] if not fabric_map[i]

        # if no other claim took this square then take it
        if fabric_map[i][j] == nil then
          fabric_map[i][j] = claim.id
        else
          # someone else has taken this square
          # mark the claim owner and ourselves as overlapping
          overlaps[fabric_map[i][j]] = true
          overlaps[claim.id] = true
        end
      end
    end

    claims[m[1]] = claim
  }
end

puts overlaps.key(false)
