namespace :seeds do
  desc "Basic admin init"
  task admin: :environment do
    u = User.new(
      :email => "dkruban@gmail.com",
      :password => "Qwerty",
      :password_confirmation => "Qwerty"
    )

    u.save!
  end
end
