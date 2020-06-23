require 'rails_helper'

  describe Sub do
    describe "#create" do
      it "画像がなくても登録できること" do
        sub = build(:sub)
        sub.resipi_images = []
        sub.valid?
        expect(sub.save).to be_falsey
      end

      it "カテゴリーがなければ登録できないこと" do
        sub = build(:sub, genre: nil)
        sub.valid?
        expect(sub.save).to be_falsey
        
      end

      it "料理の種類がなければ登録できないこと" do
        sub = build(:sub, type: nil)
        sub.valid?
        expect(sub.save).to be_falsey
       
      end

      it "料理名がなければ登録できないこと" do
        sub = build(:sub, sub_name: nil)
        sub.valid?
        expect(sub.save).to be_falsey
      end
    end

    describe "#update" do
      it "画像がなくても登録できること" do
        sub = build(:sub)
        sub.resipi_images = []
        sub.valid?
        expect(sub.save).to be_falsey
      end
      it "カテゴリーがなければ登録できないこと" do
        sub = build(:sub, genre: nil)
        sub.valid?
        expect(sub.save).to be_falsey
      end
      it "料理の種類がなければ登録できないこと" do
        sub = build(:sub, type: nil)
        sub.valid?
        expect(sub.save).to be_falsey
      end
      it "料理名がなければ登録できないこと" do
        sub = build(:sub, sub_name: nil)
        sub.valid?
        expect(sub.save).to be_falsey
      end
    end
  end