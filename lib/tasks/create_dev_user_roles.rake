task :create_dev_users => :environment do
  User.create(email: "admin@example.com", password: "sailing", validates: false) 
end
