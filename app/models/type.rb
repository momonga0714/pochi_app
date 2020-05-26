class Type < ActiveHash::Base
  include ActiveHash::Associations
  has_many :mains
  has_many :subs
  has_many :soops

  self.data = [
      {id: 1, name: '肉料理'}, {id: 2, name: '魚料理'}, {id: 3, name: '炒め物'},
      {id: 4, name: '野菜料理'}, {id: 5, name: '麺類'}, {id: 6, name: '煮物'},
      {id: 7, name: '蒸し料理'}, {id: 8, name: '煮込み'}, {id: 9, name: '飯物'}, {id: 10, name: '揚げ物'},
      {id: 11, name: 'その他'}
  ]
end