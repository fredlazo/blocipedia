require 'faker'

3.times do
	user = User.new(
		username: Faker::Internet.user_name,
		email:		Faker::Internet.email,
		password:	Faker::Internet.password(10)
	)
	user.skip_confirmation!
	user.save!
end
users = User.all

10.times do
	Wiki.create!(
		user:	users.sample,
		title:	Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs(1)

	)
end
wikis = Wiki.all

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
	username: 'clark_kent',
	email: 'superman@yahoo.com',
	password: 'password'
)

user_premium = User.last
user_premium.skip_reconfirmation!
user_premium.update_attributes!(
	username: 'bruce_wayne',
	email: 'batman@yahoo.com',
	password: 'password'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
