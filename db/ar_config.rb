require "active_record"


# Should I add the configure block? The book "publishing enterprise recipieces with ..." on page 336 pdf says so

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'db/iosie_prototype.db'
  )

Dir.glob('./models/*').each { |r| require r }
