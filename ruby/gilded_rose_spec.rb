require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    subject { described_class.new([item]).update_quality }

    let(:sell_in) { 10 }
    let(:quality) { 20 }
    let(:item) { Item.new(name, sell_in, quality) }

    context "with a normal item" do
      let(:name) { "foo" }

      it "decrements sell_in" do
        subject
        expect(item.sell_in).to eq sell_in - 1
      end

      context "when before sell date" do
        it "decrements item quality" do
          subject
          expect(item.quality).to eq quality - 1
        end
      end

      context "when on sell date" do
        let(:sell_in) { 0 }

        it "decreases item quality by 2" do
          subject
          expect(item.quality).to eq quality - 2
        end
      end

      context "when after sell date" do
        let(:sell_in) { -10 }

        it "decreases item quality by 2" do
          subject
          expect(item.quality).to eq quality - 2
        end
      end

      context "when the item quality is 0" do
        let(:quality) { 0 }

        it "does not update item quality" do
          subject
          expect(item.quality).to eq 0
        end
      end
    end
  end
end
