# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Rails.env.production?

  connection = ActiveRecord::Base.connection
  connection.execute('SET FOREIGN_KEY_CHECKS = 0;')
  connection.tables.each do |table|
    connection.execute("TRUNCATE #{table}") unless table == 'schema_migrations'
  end

	connection.execute('SET FOREIGN_KEY_CHECKS = 1;')
	dumps = %w[states.sql cities.sql banks.sql users.sql members.sql account_balances.sql]
	dumps.each do |file|
		sql = File.read("db/dump/#{file}")
		statements = sql.split(/;$/)
		statements.pop
		ActiveRecord::Base.transaction do
			statements.each do |statement|
				connection.execute(statement)
			end
		end
	end
end
