class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"

      pre_update_item_quality(item)
      item.sell_in -= 1
      post_update_item_quality(item)
    end
  end

  def pre_update_item_quality(item)
    case item.name
    when "Aged Brie"
      increment_item_quality(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      increment_item_quality(item)
      increment_item_quality(item) if item.sell_in < 11
      increment_item_quality(item) if item.sell_in < 6
    else
      decrement_item_quality(item)
    end
  end

  def post_update_item_quality(item)
    case item.name
    when "Aged Brie"
      increment_item_quality(item) if item.sell_in < 0
    when "Backstage passes to a TAFKAL80ETC concert"
      item.quality = 0 if item.sell_in < 0
    else
      decrement_item_quality(item) if item.sell_in < 0
    end
  end

  def increment_item_quality(item)
    return unless item.quality < 50

    item.quality += 1
  end

  def decrement_item_quality(item)
    return unless item.quality > 0

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
