class Brain
  def self.fuck(file)
    init file
    setup_ops
    len = @contents.size
    while @pos < len
      char = @contents[@pos]
      @ops[char].call if @ops.keys.include? char
      @pos += 1
    end
  end

  private

  def self.setup_ops
    @ops = {}
    @ops['>'] = ->{ @ptr += 1 }
    @ops['<'] = ->{ @ptr -= 1 }
    @ops['+'] = ->{ @data[@ptr] = (@data[@ptr] + 1) % 256 }
    @ops['-'] = ->{ @data[@ptr] = (@data[@ptr] - 1) % 256 }
    @ops['.'] = ->{ print @data[@ptr].chr }
    @ops[','] = ->{ @data[@ptr] = gets[0].ord }
    @ops['['] = ->{ 
      if @data[@ptr] == 0
        @pos += 1
        while @depth > 0 || @contents[@pos] != ']'
          @depth += 1 if @contents[@pos] == '['
          @depth -= 1 if @contents[@pos] == ']'
          @pos += 1
        end
      end
    }
    @ops[']'] = ->{ 
      @pos -= 1
      while @depth > 0 || @contents[@pos] != '['
        @depth += 1 if @contents[@pos] == ']'
        @depth -= 1 if @contents[@pos] == '['
        @pos -= 1
      end
      @pos -= 1
    }
  end

  def self.init(file)
    @ptr, @pos, @depth = 0, 0, 0
    @data = Array.new(27) { 0 }
    @contents = File.open(file) do |f|
      f.each_line.to_a.reduce('') { |acc, line| acc + line.chomp }
    end
  end
end
