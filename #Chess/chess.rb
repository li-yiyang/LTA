Shoes.app(:width => 300, :height => 400, :resizable => false, :title => "#Chess Game") do
  @map = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  @player = 1
  Shoes.APPS[0].set_window_icon_path("ui-pic/icon.png")
  def draw_window
    clear() do
      stack(:width => 300, :height => 300, :top => 0, :left => 0) do
        for i in 0..2
          for j in 0..2
            chess(i, j)
          end
        end
      end
    end
  end
  def chess(line, row)
    image("ui-pics/chess#{@map[line * 3 + row]}.png", :height => 100, :width => 100, :top => line * 100, :left => row * 100) do |chess|
      if @map[line * 3 + row] == 0 then
        @map[line * 3 + row] = @player
        @player *= -1
        draw_window
        if count_chess == nil then
          alert("No Winer.")
          reload
        else
          if count_chess < 0 then
            alert("P2 Win.")
            reload
          elsif count_chess > 0 
            alert("P1 Win.")
            reload
          end
        end
      end
    end
  end
  def count_chess
    @line = [0, 0, 0]
    @row = [0, 0, 0]
    @cross = [0, 0]
    for i in 0..2
      for j in 0..2
        @line[i] = @line[i] + @map[i * 3 + j]
        @row[j] = @row[j] + @map[i * 3 + j]
        @cross[0] = @cross[0] + @map[i * 3 + j] if i == j
        @cross[1] = @cross[1] + @map[i * 3 + j] if i + j == 2
      end
    end
    @line.each do |l|
      return l if l.abs == 3
    end
    @row.each do |r|
      return r if r.abs == 3
    end
    @cross.each do |c|
      return c if c.abs == 3
    end
    if @map.include?(0) then
      return 0
    else
      return nil
    end
  end
  def reload
    @map = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @player = 1
    draw_window
  end
  reload
end