# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear all tables and reset id values
ActiveRecord::Base.transaction do
  Dir['app/models/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize }.each do |c|
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{c.table_name} RESTART IDENTITY;")
  end

  # Add Users
  User.create(email: "#{DESTROYED}@redditclone.com", username: DESTROYED, password: 'jfKdie48#5@mh39fnc_3nN')
end