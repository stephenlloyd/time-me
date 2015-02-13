class Timer
  def self.starter
    File.open(".timer", "w")
    "Timer started. Go!!!"
  end

    def self.stoper
    time = Time.now - File.mtime(".timer") rescue nil
    # "It took #{humanize(time)}." rescue nil
    File.open(".timer", "a"){|f|f.puts "#{time} seconds"} if time
    time ? "It took #{humanize(time)}." : "You haven't started yet. Type 'starter' to begin and 'stoper' to end"
  end

  def self.humanize secs
    [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].map{ |count, name|
    if secs > 0
      secs, n = secs.divmod(count)
      "#{n.to_i} #{name}"
    end
    }.compact.reverse.join(' ')
  end
end