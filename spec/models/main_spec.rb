require 'rails_helper'

  describe Main do
    describe "#create" do
      it "画像がなくても登録できること" do
        main = build(:main)
        main.resipi_images = []
        main.valid?
        expect(main.save).to be_falsey
      end

      it "カテゴリーがなければ登録できないこと" do
        main = build(:main, genre: nil)
        main.valid?
        expect(main.save).to be_falsey
      end

      it "料理の種類がなければ登録できないこと" do
        main = build(:main, type: nil)
        main.valid?
        expect(main.save).to be_falsey
      end

      it "料理名がなければ登録できないこと" do
        main = build(:main, main_name: nil)
        main.valid?
        expect(main.save).to be_falsey
      end
    end

    describe "#update" do
      it "画像がなくても登録できること" do
        main = build(:main)
        main.resipi_images = []
        main.valid?
        expect(main.save).to be_falsey
      end

      it "カテゴリーがなければ登録できないこと" do
        main = build(:main, genre: nil)
        main.valid?
        expect(main.save).to be_falsey
      end

      it "料理の種類がなければ登録できないこと" do
        main = build(:main, type: nil)
        main.valid?
        expect(main.save).to be_falsey
      end

      it "料理名がなければ登録できないこと" do
        main = build(:main, main_name: nil)
        main.valid?
        expect(main.save).to be_falsey
      end
    end
  end