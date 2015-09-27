first = User.new do |user|
  user.email = 'admin@gmail.com'
  user.admin!
  user.save!
end

second = User.new do |user|
  user.email = 'user@gmail.com'
  user.user!
  user.save!
end

Article.create!(title: 'article about Technology', content: 'More about this Technology', user_id: first.id)
Article.create!(title: 'article about Biology',    content: 'More about this Biology',    user_id: second.id)
Article.create!(title: 'article about Math',       content: 'More about this Math',       user_id: second.id)
