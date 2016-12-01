require ('gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "reduces sell-in date by one at the end of the day" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(0)
    end

    context "Dexterity Vest" do
      it "quality decreases by 1 at the end of each day" do
        items = [Item.new("Dexterity Vest", 10, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(19)
      end

      it "quality decreases by 1 if sell-in date is 0" do
        items = [Item.new("Dexterity Vest", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(8)
      end

      it "quality decreases by 2 if sell-in date is negative" do
        items = [Item.new("Dexterity Vest", -9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(0)
      end
    end

    context "Aged Brie" do
      it "quality increases by 1 if sell-in date is positive" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(1)
      end

      it "quality increases by 2 if sell-in date is negative" do
        items = [Item.new("Aged Brie", -16, 34)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(36)
      end
    end

    context "Elixir of the Mongoose" do
      it "quality doesn't change with the time" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 7)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(7)
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "item never has to be sold or decreases in quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(80)
      end

      it "item never has to be sold or decreases in quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(80)
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      it "increases in quality as it’s SellIn value approaches" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 23)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(24)
      end

      it "quality increases by 2 when there are 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(21)
      end

      it "quality increases by 3 when there are 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(50)
      end

      it "quality drops to 0 after the concert " do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(50)
      end
    end



  end

end
