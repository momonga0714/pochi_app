class Genre < ActiveHash::Base
  include ActiveHash::Associations
  has_many :mains
  has_many :subs
  has_many :soops

  self.data = [
      {id: 1, name: '和食'}, {id: 2, name: '洋食'}, {id: 3, name: '中華'},
      {id: 4, name: 'イタリアン'}, {id: 5, name: 'フレンチ'}, {id: 6, name: 'メキシコ'},
      {id: 7, name: 'その他'}
  ]
end