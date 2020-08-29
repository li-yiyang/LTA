require "json"

class MainLand < Shoes
  url "/",      :welcome
  url "/main/(\w+)",  :main
  url "/step/(\w+)",  :step



  def welcome
    image("resource/icon.png", :top => 125, :left => 75, :width => 150, :height => 150)
    @@data = JSON.parse(File.open("data/main.json").read)
    #visit "/main/all"
  end

  def main(type)
    
  end

  def step(index_number)
    index = index_number.to_i

  end
end
Shoes.app(:width => 300, :height => 400, :resizable => false)
