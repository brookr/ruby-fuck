class Brain
  def self.fuck(file)
    init file
    setup_ops
    len = @contents.size
    while @pos < len
      char = @contents[@pos]
      @ops[@contents[@pos]].call if @ops.keys.include? char
      @pos += 1
    end
    puts
  end

  private

  def self.setup_ops
    @ops = {}
    @ops['>'] = ->{ @ptr += 1 }
    @ops['<'] = ->{ @ptr -= 1 }
    @ops['+'] = ->{ @data[@ptr] += 1 }
    @ops['-'] = ->{ @data[@ptr] -= 1 }
    @ops['.'] = ->{ print @data[@ptr].chr }
    @ops['['] = ->{ @loop_start = @pos }
    @ops[']'] = ->{ @pos = @loop_start if @data[@ptr] > 0 }
    @ops[','] = ->{ @data[@ptr] = gets[0].ord }
  end

  def self.init(file)
    @ptr, @pos, @loop_start = 0, 0, 0
    @data = Array.new(20) { 0 }
    @contents = File.open(file) do |f|
      f.each_line.to_a.reduce('') { |acc, line| acc + line.chomp }
    end
  end
end
