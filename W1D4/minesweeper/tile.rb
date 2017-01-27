class Tile

#tiles can have a value of BOMB or BLANK
#tile status can be SHOWN, FLAG, or HIDDEN

  attr_accessor :value, :adj_bombs
  attr_reader :status

  def intialize(value = :blank)
    @value = value
    @status = :hidden
    @adj_bombs = 0
  end

  def flag
    @status = :flag
  end

  def reveal
    @status = :shown
  end

  def display
    case @status
    when :hidden
      return "[*]"
    when :shown
      if @value == :bomb
        return "[B]"
      else
        return adj_bombs == 0 ? "[ ]" : "[#{{adj_bombs}}]"
      end
    end
  end

end
