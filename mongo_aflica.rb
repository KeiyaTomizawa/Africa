# /usr/local/bin ruby

require 'json'
#require 'rubygems'
require 'mongo'
#require 'bson'

##read json file
##ARGV[0]=agent_mypage.json
agent_mypage = open(ARGV[0]) do |io|
   JSON.load(io)
end

##ARGV[1]=company_mypage.json
company_mypage = open(ARGV[1]) do |io|
   JSON.load(io)
end
##ARGV[2]=offer_list.json
offer_list = open(ARGV[2]) do |io|
   JSON.load(io)
end
##ARGV[3]=offer_detail.json
offer_detail = open(ARGV[3]) do |io|
   JSON.load(io)
end

#connection = Mongo::Connection.new
#client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'Africa')
#client = Mongo::Client.new(['172.17.0.1:27017'],:database => 'Africa')
client = Mongo::Client.new(['africadev_db_1:27017'],:database => 'africa')

##choice database
#db = connection.db('Africa')
db = client.database

docs = []
docs1 = []
docs2 = []
docs3 = []
for i in 0..49 do
  ### agent_mypage collection ###
  ##choice collection
  coll = db.collection('agent_mypage')
  #make document
  docs.push({
    'agent_id' => agent_mypage[i]['agent_id'], 
    'name' => agent_mypage[i]['name'], 
    'gender' => agent_mypage[i]['gender'],
    'age' => agent_mypage[i]['age'], 
    'email' => agent_mypage[i]['email'],
    'phone' => agent_mypage[i]['phone'],
    'region' => agent_mypage[i]['region'], 
    'rating' => agent_mypage[i]['rating'],
    'profile' => agent_mypage[i]['profile'],
    'avater' => agent_mypage[i]['avater'],
    'talents' => agent_mypage[i]['talents'],
    'companies' => agent_mypage[i]['companies']
  })
  #insert document
  id = coll.insert_many(docs)
end
  
for i in 0..49 do
  ### company_mypage collection ###
  ##choice collection
  coll1 = db.collection('company_mypage')
  #make document
  docs1.push({
    'company_id' => company_mypage[i]['company_id'], 
    'name' => company_mypage[i]['name'], 
    'email' => company_mypage[i]['email'],
    'phone' => company_mypage[i]['phone'],
    'region' => company_mypage[i]['region'], 
    'rating' => company_mypage[i]['rating'],
    'profile' => company_mypage[i]['profile'],
    'avater' => company_mypage[i]['avater'],
    'agentss' => company_mypage[i]['agentss'],
  })
  #insert document
  id1 = coll1.insert_many(docs1)
end

for i in 0..49 do
  ### offer_list collection ###
  ##choice collection
  coll2 = db.collection('offer_list')
  #make document
  docs2.push({
    'company_id' => offer_list[i]['company_id'], 
    'max_offer_num' => offer_list[i]['max_offer_num'], 
    'offer_num' => offer_list[i]['offer_num'],
    'offer_end_date' => offer_list[i]['offer_end_date'],
    'offer_status' => offer_list[i]['offer_status'], 
    'offer_create_date' => offer_list[i]['offer_create_date'],
  })
  id2 = coll2.insert_many(docs2)
end

for i in 0..49 do
  ### offer_detail collection ###
  ##choice collection
  coll3 = db.collection('offer_detail')
  #make document
  docs3.push({
    'work_location' => offer_detail[i]['work_location'], 
    'work_time' => offer_detail[i]['work_time'], 
    'skills' => offer_detail[i]['skills'],
    'certificate' => offer_detail[i]['cerrificate'],
    'age_limit' => offer_detail[i]['age_limit'], 
    'salary' => offer_detail[i]['salary'],
    'treatment' => offer_detail[i]['treatment'],
    'holiday' => offer_detail[i]['holiday'],
    'offer_end_data' => offer_detail[i]['offer_end_data'],
  })
  id3 = coll3.insert_many(docs3)
end
