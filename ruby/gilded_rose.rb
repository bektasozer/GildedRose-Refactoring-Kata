class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      pre_update_item_quality(item)
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end
      post_update_item_quality(item)
    end
  end

  def pre_update_item_quality(item)
    if item.name == "Aged Brie" || item.name == "Backstage passes to a TAFKAL80ETC concert"
      if item.quality < 50
        increment_item_quality(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
            if item.quality < 50
              increment_item_quality(item)
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              increment_item_quality(item)
            end
          end
        end
      end
    else
      if item.quality > 0
        if item.name != "Sulfuras, Hand of Ragnaros"
          decrement_item_quality(item)
        end
      end
    end
  end

  def post_update_item_quality(item)
    if item.sell_in < 0
      if item.name == "Aged Brie"
        if item.quality < 50
          increment_item_quality(item)
        end
      else
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        else
          if item.quality > 0
            if item.name != "Sulfuras, Hand of Ragnaros"
              decrement_item_quality(item)
            end
          end
        end
      end
    end
  end

  def increment_item_quality(item)
    item.quality += 1
  end

  def decrement_item_quality(item)
    item.quality -= 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
