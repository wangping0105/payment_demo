# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

current_user = User.create(name: :admin, email: "qq@qq.com", password: "111111", phone: "18000000000", role: 1, confirmed_at: Time.now)
current_user.user_account = UserAccount.new(user: current_user )
category = Category.create(name: '默认分类')
file = File.new("/home/jackping/rails_projects/payment_demo/app/assets/images/demo_product.jpg")
demo_prods = [
  {name: '钱包', price: 18, introduction: '一个精致的钱包'},
  {name: '戒指', price: 1888, introduction: '一个精致的戒指'},
  {name: '铃铛', price: 12, introduction: '一个精致的铃铛'},
  {name: '洗发露(初)', price: 18, introduction: '这是初级洗发露'},
  {name: '洗发露(中)', price: 188, introduction: '这是中级洗发露'},
  {name: '洗发露(高)', price: 388, introduction: '这是高级洗发露'},
  {name: '洗发露(特)', price: 688, introduction: '这是特级洗发露'}
]
demo_prods.each do |dp|
  commodity = category.commodities.build(no: "#{Time.now.to_i}0001", name: dp[:name], price: dp[:price], introduction: dp[:introduction], stock: 10)
  Attachment.create(file: file, user: current_user, attachmentable: commodity)
end

