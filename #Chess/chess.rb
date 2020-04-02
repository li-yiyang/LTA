Shoes.app(:width => 300, :height => 400, :resizable => false, :title => "#Chess Game") do
  @map = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  @player = 1
  @playstate = -1
  Shoes.APPS[0].set_window_icon_path("ui-pics/icon.png")
  def draw_window
    clear() do
      stack(:width => 300, :height => 300, :top => 0, :left => 0) do
        for i in 0..2
          for j in 0..2
            chess(i, j)
          end
        end
      end
      @control_bar = stack(:width => 600, :height => 100, :top => 300, :left => 0) do
        image("ui-pics/play#{- @playstate}.png", :height => 100, :width => 100, :top => 0, :left => 0) do 
          @playstate *= -1
          draw_window()
        end
        image("ui-pics/end.png", :height => 100, :width => 100, :top => 0, :left => 100) do
          reload
        end
        image("ui-pics/more.png", :height => 100, :width => 100, :top => 0, :left => 200) do
          @control_bar.move(-300, 300)
        end
        image("ui-pics/play-style1.png", :height => 100, :width => 100, :top => 0, :left => 300)
        image("ui-pics/help.png", :height => 100, :width => 100, :top => 0, :left => 400) do
          window(:width => 300, :height => 400, :resizable => false, :title => "Help - #Chess Game") do
            title "HELP\n"
            para "As you may know, the '#Chess' aims to have 3 of your chess in line or row or cross, which is the mark of your winnig.\n"
            title "ABOUT\n"
            para "The game writer: li", link("li(github)", :visit => "https://github.com/li-yiyang/LTA"), "\n", "The GUI(Shoes) writer: _why\n"
          end
        end
        image("ui-pics/back.png", :height => 100, :width => 100, :top => 0, :left => 500) do
          @control_bar.move(0,300)
        end
      end
    end
  end
  def chess(line, row)
    image("ui-pics/chess#{@map[line * 3 + row]}.png", :height => 100, :width => 100, :top => line * 100, :left => row * 100) do |chess|
      if @map[line * 3 + row] == 0 and @playstate > 0 then
        @map[line * 3 + row] = @player
        @player *= -1
        draw_window
        if count_chess == nil then
          alert("No Winer.")
          reload
        else
          if count_chess < 0 then
            alert("P2 Win.")
            @playstate = -1
            reload
          elsif count_chess > 0 
            alert("P1 Win.")
            @playstate = -1
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
    @playstate = -1
    draw_window
  end
  reload
end