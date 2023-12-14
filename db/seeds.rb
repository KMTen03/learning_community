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

def find_or_create_end_user(name)
  email = "#{name}@example.com"
  password = "password"
  introduce = "#{name}です。よろしくお願いします。"
  min_days_ago = 1
  max_days_ago = 365
  random_days_ago = rand(min_days_ago..max_days_ago)
  random_date = Time.now - random_days_ago.days
  
  end_user = EndUser.find_or_create_by!(email: email) do |u|
    u.name = name
    u.password = password
    u.introduce = introduce
    u.created_at = random_date
    u.updated_at = random_date
  end
end

def find_or_create_post
  initial_date = Time.now - (count - 1).days
  
  count.times do |i|
    title = "投稿#{i + 1}"
    learning_content = "サンプルの投稿#{i + 1}です。適当な文章を入力してください。"
    learning_time = 3
    tag_list = tags.sample(2)
  
    post_date = initial_date + i.days

    post_params = {
      title: title,
      user_id: user.id
    }
  
    post = Post.find_or_create_by!(post_params) do |p|
      p.title = title
      p.learning_content = learning_content
      p.learning_time = learning_time
      p.created_at = post_date
      p.updated_at = post_date
      p.tag_list.add(tag_list) 
    end
  
    puts "Createing post with title: #{title}, end_user_name: #{end_user.name}, tag_list: #{tag_list}"
  end
end
  
EndUser.where.not(account: 'guest').each do |user|
  statuses = [0] * 12 + [1] * 3 + [2] * 3
  create_posts_for_user_with_ordered_dates(user, 12, statuses, tags)
end