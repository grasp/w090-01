 require 'rubygems'
 require 'mongo'
 require 'bson'
 desc "read original user and export to current user"
 task :ruser_1 do
   # Task goes here

current_mongo = Mongo::Connection.new('localhost', 27017).db('dummy_development') #first set as grasp
current_user=  current_mongo['ruser_users']

orginal_mongo = Mongo::Connection.new('localhost', 27017).db('w090_production') #first set as grasp
original_user= orginal_mongo['users']

original_user.find.each do |user|
	temp_hash = user.to_hash
	temp_hash.delete("_id")

	temp_hash['mphone'] = temp_hash['mobilephone']
    temp_hash.delete("mobilephone")

    temp_hash['mphone'] = temp_hash['mobilephone']
    temp_hash.delete("mobilephone")

    temp_hash['hpwd'] = temp_hash['hashed_password']
    temp_hash.delete("hashed_password")

    temp_hash.delete('ustatistic_id')
    

	current_user.insert(temp_hash)
end

puts "original_user =#{original_user.count}"
puts "current_user = #{current_user.count}"

 end

 desc "check activate code,if nil, make it not nil"
 task :check_activate do
    current_mongo = Mongo::Connection.new('localhost', 27017).db('dummy_development') #first set as grasp
   current_user=  current_mongo['ruser_users']
current_user.find.each do |user|
    if user["activate"] == nil
        user["activate"] = rand(Time.now.to_i+100000000000).to_s
        current_user.update({"_id" => user["_id"]}, {"$set" => {"activate" => user["activate"]}})
    end
end

 end
