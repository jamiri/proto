DB_FILE = './db/iosie_prototype.db'

#desc "Establish the connection to the database"
task :environment do
  require 'active_record'
  require 'active_support/core_ext/string/strip'
  require 'fileutils'
  require 'logger'

  Dir.glob("./db/models/*.rb").each { |r| require r }
  ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => DB_FILE
  #ActiveRecord::Base.logger = Logger.new(STDOUT)
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

    count = ENV['COUNT'] ? ENV['COUNT'].to_i : 1

    count.times do
      Category.create!(:name => Faker::Lorem.words(rand(1..3)).join(' '),
                       :description => Faker::Lorem.sentences(1))

    end

    puts "#{count} fake categories were created."
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

end

namespace :lesson do

  desc "Create fake lessons"
  task :create_fake => :environment do

    require "faker"

    count = ENV['COUNT'] ? ENV['COUNT'].to_i : 1

    count.times do
      lesson = Lesson.new
      lesson.title = Faker::Lorem.sentence rand(1..7) # maximum title length = 7 words
      lesson.description = Faker::Lorem.paragraph rand(1..3) # maximum description length = 7 sentences
      script = Faker::Lorem.paragraphs(rand(5..30)) # maximum script length = 30 paragraphs
      lesson.script = script.join('<br>')
      lesson.author = Faker::Name.name

      # category
      categories = Category.find(:all)
      lesson.category = categories[rand(categories.count)]

      # objectives
      rand(1..5).times do
        lesson.objectives << Objective.new(:title => Faker::Lorem.sentence(rand(5..10)))
      end

      # references
      rand(1..5).times do
        lesson.references << Reference.new(
          :title => Faker::Lorem.words(rand(2..5)).join(' '),
          :description => Faker::Lorem.sentences(rand(1..3)).join(' ')
        )
      end

      # questions
      rand(2..5).times do
        lesson.questions << Question.new(
          :user => User.find(:all).sample,
          :question => Faker::Lorem.sentence(rand(5..20)),
          :answer => Faker::Lorem.sentences(rand(1..5)).join(' '),
          :answered_by => Faker::Name.name
        )
      end

      # glossary
      script_words = script.join(' ').scan(%r{\w+}).uniq
      sample_words = script_words.sample(rand(5..20))
      lesson.glossary_words = sample_words.join(',')

      sample_words.each do |word|
        if word.length > 2
          GlossaryEntry.new(
            :entry => word,
            :short_definition => Faker::Lorem.sentences(1).first
          ).save
        end
      end

      # microblog
      rand(0..10).times do
        blogpost = BlogPost.new(
          :title => Faker::Lorem.sentence(rand(2..10)),
          :content => Faker::Lorem.paragraphs(rand(1..5)).join(' ')
        )

        rand(0..10).times do
          blogpost.comments << Comment.new(
            :comment => Faker::Lorem.sentences(rand(1..5)).join(' '),
            :user => User.find(:all).sample
          )
        end

        lesson.blog_posts << blogpost
      end

      # Save the lesson!
      lesson.save

      puts "A new lesson created. The id is #{lesson.id}."
    end
  end
end

namespace :doc do

  desc "Create ERD for the project and saves it to /docs/erd.pdf"
  task :erd => :environment do

    require "rails_erd/diagram/graphviz"
    require "fileutils"

    RailsERD::Diagram::Graphviz.create()

    FileUtils.mkdir("docs") unless File.directory?("docs")

    # the "erd" file name format is: erd_{current datetime}_{current schema version}
    FileUtils.mv('erd.pdf',
                 "docs/erd_#{Time.now.strftime('%Y%m%d%H%M%S')}_#{ActiveRecord::Migrator.current_version}.pdf")

  end

end

namespace :user do

  desc "Create fake users"
  task :create_fake => :environment do

    require "faker"

    count = ENV['COUNT'] ? ENV['COUNT'].to_i : 1

    count.times do
      User.create!(:name => Faker::Name.name,
                   :mail_address => Faker::Internet.email,
                   :password => "12345",
                   :enable => true)
    end

    puts "#{count} fake users were created."
  end

end
