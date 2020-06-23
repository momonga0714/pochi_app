require 'rails_helper'

  describe Soop do
    describe "#create" do
      it "画像がなくても登録できること" do
        soop = build(:soop)
        soop.resipi_images = []
        soop.valid?
        expect(soop.save).to be_falsey
      end

      it "カテゴリーがなければ登録できないこと" do
        soop = build(:soop, genre: nil)
        soop.valid?
        expect(soop.save).to be_falsey
      end

      it "料理の種類がなければ登録できないこと" do
        soop = build(:soop, type: nil)
        soop.valid?
        expect(soop.save).to be_falsey
      end

      it "料理名がなければ登録できないこと" do
        soop = build(:soop, soop_name: nil)
        soop.valid?
        expect(soop.save).to be_falsey
      end
    end

    describe "#update" do
      it "画像がなくても登録できること" do
        soop = build(:soop)
        soop.resipi_images = []
        soop.valid?
        expect(soop.save).to be_falsey
      end

      it "カテゴリーがなければ登録できないこと" do
        soop = build(:soop, genre: nil)
        soop.valid?
        expect(soop.save).to be_falsey
      end

      it "料理の種類がなければ登録できないこと" do
        soop = build(:soop, type: nil)
        soop.valid?
        expect(soop.save).to be_falsey
      end

      it "料理名がなければ登録できないこと" do
        soop = build(:soop, soop_name: nil)
        soop.valid?
        expect(soop.save).to be_falsey
      end
    end
  end