require 'faker'

# Create some users
3.times do
	user = User.new(
		email:		Faker::Internet.email,
		password:	Faker::Internet.password(10)
	)
	user.skip_confirmation!
	user.save!
end
users = User.all

15.times do
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
	email: 'standard@yahoo.com',
	password: 'password'
)

user_premium = User.last
user_premium.skip_reconfirmation!
user_premium.update_attributes!(
email: 'premium@yahoo.com',
password: 'password'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
