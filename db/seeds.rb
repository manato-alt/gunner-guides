categories = [
  { name: 'setting' },
  { name: 'training' },
  { name: 'information' }
]

categories.each do |category|
  Category.create(category)
end

# Keywordsの初期データ
keywords = [
  { name: '感度', category: Category.find_by(name: 'setting') },
  { name: '設定', category: Category.find_by(name: 'setting') },
  { name: 'エイム', category: Category.find_by(name: 'training') },
  { name: 'コーチング', category: Category.find_by(name: 'information') },
  { name: '解説', category: Category.find_by(name: 'information') },
  { name: '講座', category: Category.find_by(name: 'information') }
]

keywords.each do |keyword|
  Keyword.create(keyword)
end
