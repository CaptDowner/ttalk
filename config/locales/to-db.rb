require 'yaml'
require 'pg'
require 'pry'

conn=PGconn.connect( :hostaddr=>"127.0.0.1", :port=>5432, :dbname=>"talk_dev", :user=>"captdowner", :password=>'sailing')
# Done these languages - ja, de, fr
lang_arr = %w[ar, de, el, en, fr, ja, ko, pl, pt, ru, es, zh, it, hr, iw, vi, sv, lt]
# load the YAML file
tree = YAML::load_file("th.yml")
# Now we have all of thekeys and values from the .yml file
# so we can write the values of v to the Phrase db table
# binding.pry
# set id to the next available value in the db
id =25506
$count = 0
tree['th'].each_pair do |k,v|
  # find db command for entering all fields
  # add id then id++
  q = "INSERT INTO phrases(id, text, audio_file, created_at, updated_at, abbrev) VALUES('#{id}', '#{v}', '#{k}.mp3', now(), now(), 26);"
#  puts q
#  binding.pry
  $count = $count + 1
  res = conn.exec(q);
  id = id + 1
=begin
  puts id
  id = id + 1
  # v = translated text
  puts "value =  " + v
  # k = key text
  puts "key = " + k 
  # audio_file = k + '.mp3'
  puts "audio_file = " + k + ".mp3" 
  # language id = integer (decide on order of countries and matching 2 letter language positions
  puts "language_id = " + "5"
  # in an array and store their index to this language integer
  puts "created_at = " +  Time.now.to_s
  puts "updated_at = " +  Time.now.to_s
  binding.pry
=end
end

puts 'count = ' + $count.to_s
puts 'Check and see if data is successfully posted to the database talk_dev.'
