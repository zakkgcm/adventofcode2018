#!/usr/bin/ruby -w

require 'date'

LogRecord = Struct.new(:timestamp, :record)
log_items = []
guards = Hash.new{|h,k| h[k] = Array.new(60) { 0 } }

log_re = /\[(.+)\] (.+)/
guard_re = /Guard #(\d+) begins shift/
asleep_re = /falls asleep/
wake_re = /wakes up/

# load log records into a list
File.open("input", "r").readlines.each do |line|
  log_re.match(line) { |m| log_items << LogRecord.new(DateTime.parse(m[1]), m[2]) }
end

log_items.sort! { |a,b| a.timestamp <=> b.timestamp }

# tally up the guard's sleeping minutes
current_guard = nil
last_sleep_min = nil
log_items.each do |item|
  case item.record
    when guard_re # a new guard shift
      current_guard = $1.to_i
    when asleep_re # mark when the guard falls asleep
      last_sleep_min = item.timestamp.to_time.min
    when wake_re # when they wake up increment their sleep minutes
      for i in last_sleep_min .. item.timestamp.to_time.min do
        guards[current_guard][i] += 1
      end
  end
end

puts guards

# i slep
sleepiest_guard, sleeps = guards.max_by{ |k,v| v.max }
longest_sleeps = sleeps.index(sleeps.max)
puts "%d: %d" % [sleepiest_guard, longest_sleeps]

puts sleepiest_guard*longest_sleeps
