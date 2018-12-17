#!/usr/bin/ruby -w

claims = {}
fabric_map = []
Claim = Struct.new(:id, :left, :top, :width, :height)
claim_re = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/

total_overlap = 0

File.open("input", "r").readlines.each do |cline|
  claim_re.match(cline) { |m|
    m = m.to_a.map(&:to_i)
    claim = Claim.new(m[1], m[2], m[3], m[4], m[5])
    
    # add the claim to the fabric map and note any overlaps
    for i in claim.top .. claim.top + claim.height-1 do
      for j in claim.left .. claim.left + claim.width-1 do
        fabric_map[i] = [] if not fabric_map[i]
        fabric_map[i][j] = 0 if not fabric_map[i][j]
        
        fabric_map[i][j] += 1

        total_overlap += 1 if fabric_map[i][j] == 2
      end
    end

    claims[m[1]] = claim
  }
end

puts total_overlap
