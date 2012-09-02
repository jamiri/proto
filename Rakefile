# encoding: utf-8

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
      lesson_script = Faker::Lorem.paragraphs(rand(5..30))

      lesson = Lesson.new(
        :title => Faker::Lorem.sentence(rand(1..7)), # maximum title length = 7 words
        :description => Faker::Lorem.paragraph(rand(1..3)), # maximum description length = 7 sentences
        :script => lesson_script.map{ |x| "<p>#{x}</p>" }.join(''), # maximum script length = 30 paragraphs
        :author => Faker::Name.name
      )

      # category
      lesson.category = Category.find(:all).sample

      # objectives
      rand(1..5).times do
        lesson.objectives.build(:title => Faker::Lorem.sentence(rand(5..10)))
      end

      # references
      rand(1..5).times do
        lesson.references.build(
          :title => Faker::Lorem.words(rand(2..5)).join(' '),
          :description => Faker::Lorem.sentences(rand(1..3)).join(' ')
        )
      end

      # questions
      rand(2..5).times do
        lesson.questions.build(
          :user => User.find(:all).sample,
          :question => Faker::Lorem.sentence(rand(5..20)),
          :answer => Faker::Lorem.sentences(rand(1..5)).join(' '),
          :answered_by => Faker::Name.name
        )
      end

      # glossary
      sample_words = lesson_script.join(' ').scan(%r{\w+}).uniq.sample(rand(5..10))
      sample_words.each do |word|
        if word.length > 2
          lesson.glossary_entries.build(
            :name => word,
            :short_definition => Faker::Lorem.sentences(1).first,
            :full_definition => Faker::Lorem.sentences(rand(2..5)).join(''),
          )
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

      puts "A new lesson was created. The id is #{lesson.id}."
    end
  end

  desc "Create sample lesson"
  task :create_sample => :environment do

    category = Category.new(:name => "Obligatory Acts")

    lesson = Lesson.new(
        :title => "Hijab in the Qur'an",
        :author => "Sheikh Ahmed Haneef",
        :audio_file => "sample_lesson.mp3",
        :script => <<EOS
<p style="text-align: justify;">
Hijab or the Islamic modest dress is a way of covering the body according to certain
principles in order to make Muslim women identifiable in society and to minimise the social influence of sexual stimuli.
Now let's look at the most comprehensive verses on hijab or modest dress in the Qur'an.
These are verses 30 and 31 of surah al Nur.</p>
<p style="font-family: 'B Badr'; direction: rtl; text-align: center; font-size: 22px; font-weight: bold;">
قُلْ لِلْمُؤْمِنينَ يَغُضُّوا مِنْ أَبْصارِهِمْ وَ يَحْفَظُوا فُرُوجَهُمْ ذلِكَ أَزْكى‏ لَهُمْ إِنَّ اللَّهَ خَبيرٌ بِما يَصْنَعُونَ
</p>
<p>Tell the believing men to lower their gaze and protect their private parts. That is purer for them.
Indeed, Allah is All-aware of what they do. (Q, Nur/24:30)</p>
<p style="font-family: 'B Badr'; direction: rtl; text-align: center; font-size: 22px; font-weight: bold;">
وَ قُلْ لِلْمُؤْمِناتِ يَغْضُضْنَ مِنْ أَبْصارِهِنَّ وَ يَحْفَظْنَ فُرُوجَهُنَّ
</p>
<p>And tell the believing women to lower their gaze and protect their private parts</p>
<p style="text-align: justify;">
These two commands indicate the spirit of hijab. It is first and foremost, an attitude and response
towards that which is sexually improper in society by resisting their influence on the soul.
The eyes, it is said, are windows to the soul and the pious Muslim shuts the doors of his
or her soul to the influence of such stimuli. This is indicated by the phrase "lower their gaze".
The other is that the Muslims themselves should not act in sexually inappropriate ways such as
fornication as is encapsulated in the phrase, "protect their private parts."</p>
<p style="text-align: justify;">
The spirit of hijab, which includes both men and women alike, is then followed by rules on
clothing which are the outward or physical aspect of hijab. These are exclusively directed
to women, indicated by the gender of the verbs involved,</p>
<p style="font-family: 'B Badr'; direction: rtl; text-align: center; font-size: 22px; font-weight: bold;">
 وَ لا يُبْدينَ زينَتَهُنَّ إِلاَّ ما ظَهَرَ مِنْها
</p>
<p>and do not show off their adornments except that which is apparent.</p>
<p style="text-align: justify;">
This could be because, as has been scientifically proven, men are sexually more
subject to the effect of visual stimuli than women. And it is probably due to
this psycho biological fact, that the conditions determining the extent of clothing
to be worn would be logically more extensive for women than for men.</p>
<p style="text-align: justify;">
According to the hadith, "adornments" (zeenat) here means both the body as a potentially
sexually attractive object and those external accessories that are used to beautify it.</p>
<p style="text-align: justify;">
"What is apparent" means those parts of the woman's body that are allowed to be exposed to
the public and they are the face, hands and, according to a number of ulama, the feet,
whereas for the husband, the woman's entire body can be exposed.</p>
<p style="text-align: justify;">
The amount of adornment or beauty that can be seen depends upon three categories of witnesses:
the general public, the mahram, (which is a category before whom a woman can appear unveiled)
and the husband. The public, as we have mentioned earlier, can be exposed to the face, hands
and according to some ulama, feet of the non mahram woman; the mahram, for the practical purposes
of domestic life, still more; and the husband has the privilege of seeing the entire body of
his wife and all the accessories that go along with it.</p>
<p style="text-align: justify;">
This shows that Islam is not a prudish religion at all, but is just restrictive about
sexual expressions and enticements in the public sphere. The verse continues:</p>
<p style="font-family: 'B Badr'; direction: rtl; text-align: center; font-size: 22px; font-weight: bold;">
  وَ لْيَضْرِبْنَ بِخُمُرِهِنَّ عَلى‏ جُيُوبِهِنَّ
</p>
<p>and to draw their head coverings (khumurihinna) over their bosoms (juyubihinna).</p>
<p style="text-align: justify;">
This phrase indicates the origin of the classical hijab look: A head covering or khimaar,
which is a single piece of cloth that covers both the head and the chest,
and leaving the face exposed, a form of which is reflected in what we call the maqnah,
and is called the 'hijab' today even though it is not hijab in its entirety.</p>
<p style="text-align: justify;">
Thus when people say that hijab, meaning the khimaar is not in the Qur'an, this
verse makes them incorrect. Indeed the word 'hijab' does not appear in the Qu'ran in
this context and this is simply due to the fact that the word was coined after the
fact to denote this principle of Islamic dress. If the word 'hijab' doesn't appear in
these verses it does not invalidate its existence as a precise set of principles of modest dress.</p>
<p style="text-align: justify;">
If we dismiss the concept of hijab because the word does not appear in the Qur'an, we should
also be prepared to dismiss the concept of martyrdom because the word shahadat is not used
to indicate it, and the heavenly journey of the Prophet because the word Mi'raaj is not used to name it.</p>
<p style="text-align: justify;">
Thus we see that the holy Qur'an is very clear on the issue of hijab. To ignore the observance of
hijab in the form described in the Qur'an, is to directly disobey an order of Allah and in so doing,
put ourselves in danger of being agents contributing to the breakdown in social sexual morality and
the disastrous consequences that would follow in this life and the Hereafter.
</p>
EOS
    )

    lesson.category = category

    # ----- objectives -----
    ["Is hijab mentioned in the Qur'an?", "What is the philosophy of hijab according to Qur'an?",
     "What is the social importance of hijab?"].each do |objective|

      lesson.objectives.build(:title => objective)
    end

    # ----- references -----
    lesson.references.build(
      :title => "Allameh Seyyed Muhammad Husayn Tabatabaei",
      :photo => "allameh.jpg",
      :description => <<DESC
One of the most prominent thinkers of philosophy and contemporary Shia Islam.
He is famous for Tafsir al-Mizan, the Qur'anic exegesis. He was born in Tabriz
on the last day of Dhil-Hijja to an eminent scholarly family. He lost both his
parents at a young age and received his primary education in his native city.
At the age of sixteen he entered the Islamic seminary and began studying the
preliminary sciences, mastering the elements of Arabic and religious sciences
before leaving to join the great Shia Hawzah (Seminary) of Najaf, Iraq to
continue more advanced studies.
DESC
    )

    lesson.references.build(
        :title => "Tafsir al-Mizan",
        :description => <<DESC
Al-Mizan fi tafsiri'l-Qur'an, popularly known as Tafsir al-Mizan, is a Shi'a
Muslim tafsir (or exegesis of the Quran) written by Ayatollah Sayyid Muhammad
Hussein Tabataba'i. The book consists of 20 volumes. Up till now more than
three editions have been printed in Iran and Lebanon
DESC
    )

    lesson.references.build(
        :title => "Ayatollah Morteza Motahhari",
        :photo => "motahari.jpg",
        :description => <<DESC
An Iranian scholar, cleric, University lecturer, and politician. Motahhari is
considered among the important influences on the ideologies of the Islamic
Republic, and was a co-founder of Hosseiniye Ershad and the Combatant Clergy
Association (Jame'e-ye Rowhaniyat-e Mobarez). Motahhari was a disciple of
Ayatollah Khomeini during the Shah's reign and formed the Council of Revolution
of Iran at Khomeini's request. He was chairman of the council at the time of
his assassination.
DESC
    )

    lesson.references.build(
        :title => "Hijab",
        :description => <<DESC
Entitled in the English translation as “The Islamic Modest Dress” is a masterful
work on hijab. It looks at hijab from the perspectives of society and religion
and brings a historical perspective to bear as a background to the subject. The
author keeps in mind the various arguments against the hijab and seeks to
systematically answer them in this book.
DESC
    )


    # ----- microblogs -----
    lesson.blog_posts.build(
        :content => <<BLOG
Islam sees the unethical and uncontrolled practice of sexual relations as one
of the most potent forces that threaten social stability and civilization. By
destroying trust, respect and commitment between the sexes, fornication and
adultery destroy the fundamental building block of the society, the family.
BLOG
    )

    lesson.blog_posts.build(
        :content => <<BLOG
Since sexual attraction is something instinctual, it operates on the basis of
stimulus/response. Certain natural characteristics of the human body, like the
pitch of voice, the shape of certain aspects of the body, the way the different
ganders walk, even the way we smell can cause sexual attraction and elicit a
sexual response.
BLOG
    )

    lesson.blog_posts.build(
        :content => <<BLOG
Now the reaction of Western feminists is that this is discriminatory and that
it indicates male domination. However, when we look at the phenomenon of male
sexual attraction we find that the most influential sense that leads to
instinctual sexual attraction is the eyes and that it is precisely those physical
features that distinguish women form men that men find so attractive.
BLOG
    )


    # ----- questions -----
    lesson.questions.build(
        :question => "Is hijab unique to Islam, or are dress codes for women found in other religions?",
        :answered_by => "Ahmed",
        :user => User.new(:name => "George"),
        :answer => <<ANS
Yes there have been dress codes for women in other religions. In fact in
Christianity until the modern period women were also required to wear
clothes that were modest and veil themselves in church.
ANS
    )

    lesson.questions.build(
        :question => "Can a Muslim woman wear hijab and have makeup on without covering her face?",
        :answered_by => "Ahmed",
        :user => User.new(:name => "Hammud"),
        :answer => <<ANS
Apart from plucked eyebrows which can be uncovered, any other type of obvious makeup on a woman's
face would necessitate her having her face covered from the looks of non mahram men.
ANS
    )

    lesson.questions.build(
        :question => "Is there hijab for men?",
        :answered_by => "Ahmed",
        :user => User.new(:name => "Celeste"),
        :answer => <<ANS
In a technical sense, no. However, according to Islamic etiquette (akhlaq) men are encouraged to
dress modestly, covering their arms, legs and wearing loose clothing.
ANS
    )


    # ----- glossary -----
    lesson.glossary_entries.build(
        :name => "hijab",
        :short_definition => "Veil or a covering. Used as a term to refer to the distinctive
clothing worn by practising Muslim women",
        :pronun_file => "hijab.mp3"
    )

    lesson.glossary_entries.build(
        :name => "mahram",
        :short_definition => "A category of viewer that could see the woman without her hijab.
This includes such people as close relatives, like the woman's father, her sons, her children's
sons, etc.",
        :pronun_file => "mahram.mp3"
    )

    lesson.glossary_entries.build(
        :name => "ulama",
        :short_definition => "Islamic scholars.",
        :pronun_file => "ulama.mp3"
    )

    lesson.glossary_entries.build(
        :name => "khimaar",
        :short_definition => "The head covering that also covers the bosom of a woman.",
        :pronun_file => "khimaar.mp3"
    )

    lesson.glossary_entries.build(
        :name => "shahaadat",
        :short_definition => "Martyrdom",
        :pronun_file => "shahaadat.mp3"
    )

    lesson.glossary_entries.build(
        :name => "mi'raaj",
        :short_definition => "The Prophet's (s) famed nocturnal journey that took him to the heavens.",
        :pronun_file => "miraaj.mp3"
    )


    lesson.save

    %w(hijab mahram ulama khimaar shahaadat miraaj).each do |file_name|
      system "tar xzf sample_content.tar.gz -C public/assets/ #{file_name}.mp3"
    end

    %w(allameh motahari).each do |file_name|
      system "tar xzf sample_content.tar.gz -C public/assets/ref_img/ #{file_name}.jpg"
    end

    puts "The sample was created with id #{lesson.id}."
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
