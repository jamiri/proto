require "active_record"
require "logger"

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'db/iosie_prototype.db'
  )

Dir.glob('./models/*').each { |r| require r }

if ENV['RACK_ENV'].to_sym != :production
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
