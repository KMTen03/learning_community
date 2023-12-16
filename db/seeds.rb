# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
end

olivia = EndUser.find_or_create_by!(email: "olivia@example.com") do |end_user|
  end_user.name = "Olivia"
  end_user.password = "olivia1212"
end

james = EndUser.find_or_create_by!(email: "james@example.com") do |end_user|
  end_user.name = "James"
  end_user.password = "james1129"
end

post1 = Post.find_or_create_by!(title: "リーディング対策") do |post|
  post.learning_content = "TOEICの700点を目指してます！明日は2章からスタートです。"
  post.learning_time = "5"
end

post2 = Post.find_or_create_by!(title: "SPI対策") do |post|
  post.learning_content = "仕事算から割引料金と精算まで終了。"
  post.learning_time = "4"
end

tag1 = Tag.create(tag_name:"資格試験")
tag2 = Tag.create(tag_name:"TOEIC")
tag3 = Tag.create(tag_name:"就職試験")
tag4 = Tag.create(tag_name:"数学")

post1.tags << tag1
post1.tags << tag2
post2.tags << tag3
post3.tags << tag4