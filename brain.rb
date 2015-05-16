class Brain
  def self.fuck(file)
    initialize file
    i, len = 0, @contents.size
    while i < len
      case @contents[i]
      when '>' then @ptr += 1
      when '<' then @ptr -= 1
      when '+' then @data[@ptr] += 1
      when '-' then @data[@ptr] -= 1
      when '.' then print @data[@ptr].chr
      when '[' then @loop_start = i
      when ']' then i = @loop_start if @data[@ptr] > 0
      else  p 'invalid character'
      end
      i += 1
    end
    puts
  end

  private

  def self.initialize(file)
    @ptr, @loop_start = 0, 0
    @data = Array.new(100) { 0 }
    @contents = File.open(file) do |f|
      f.each_line.to_a.reduce('') { |acc, line| acc + line.chomp }
    end
  end
end
