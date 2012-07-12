require "active_record"


ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'db/iosie_prototype.db'
  )

Dir.glob('./models/*').each { |r| require r }
