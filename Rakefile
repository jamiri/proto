DB_FILE = './db/iosie_prototype.db'

#desc "Establish the connection to the database"
task :environment do
  require 'active_record'
  require 'active_support/core_ext/string/strip'
  require 'fileutils'

  Dir.glob("./db/models/*.rb").each { |r| require r }
  ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => DB_FILE
end

namespace :db do

  desc "Remove the database"
  task :remove do
    require "active_record"

    if File.exist?(DB_FILE)
      STDOUT.print "The database file will be removed. Are you sure [yes/no]? "
      input = STDIN.gets
      if input =~ /yes/
        File.delete(DB_FILE)
        puts "The database file successfully removed."
      end
    end
  end

  desc "create an ActiveRecord migration in ./db/migrate"
  task :create_migration => :environment do
    name = ENV['NAME']
    if name.nil?
      raise "No NAME specified. Example usage: `rake db:create_migration NAME=create_users`"
    end

    migrations_dir = File.join("db", "migrate")
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")
    filename = "#{version}_#{name}.rb"
    migration_class = name.split("_").map(&:capitalize).join

    FileUtils.mkdir_p(migrations_dir)

    File.open(File.join(migrations_dir, filename), 'w') do |file|
      file.write <<-MIGRATION.strip_heredoc
      class #{migration_class} < ActiveRecord::Migration
        def up
        end

        def down
        end
      end
      MIGRATION
    end
  end

  desc "migrate the database (use version with VERSION=n)"
  task :migrate => :environment do
    version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate('db/migrate', version)
  end

  desc "rolls back the migration (use steps with STEP=n)"
  task :rollback => :environment do
    step = ENV["STEP"] ? ENV["STEP"].to_i : 1
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.rollback('db/migrate', step)
  end

end

namespace :category do

  desc "Generate fake categories"
  task :create_fake => :environment do

    require "faker"

    unless ENV["FAKE_COUNT"]
      puts "How many fake categories do you want? (ie. FAKE_COUNT=5)"
      next
    end

    cats = Faker::Lorem.words ENV["FAKE_COUNT"].to_i
    cats.each do |cat|

      c = Category.new
      c.name = cat
      c.description = cat
      c.save

    end

    puts "#{ENV['FAKE_COUNT']} fake categories created."
  end

  desc "Generate child for categories"
  task :make_child => :environment do

    require "faker"

    Category.where(:name => ENV["name"]).each do |c|

      fake_list = Faker::Lorem.words 3

      fake_list.each do |item|

        cat = Category.new
        cat.name = item
        cat.description = item
        cat.parent = c
        cat.save

      end

    end
  end


  desc "Remove all categories"
  task :clear => :environment do

    Category.delete_all
    puts "All categories removed."

  end


  desc "Run arbitrary custom commands"
  task :run => :environment do

    c = Category.find(1)

    l = Lesson.new
    l.title = "lesson 1"
    l.category = c
    p l.save

  end


end
