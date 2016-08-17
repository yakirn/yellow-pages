# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "begin seed"
json = ActiveSupport::JSON.decode(File.read('db/seeds/people.json'))
mappings = {"avatar_origin" => "picture"}
json.each do |p|
    person = p.slice('name', 'phone', 'avatar_origin')
                .map {|k, v| [mappings[k] || k, v] }.to_h
                .merge(p['address'])
                .merge(birthday: Time.at(p['birthday']))
    Person.create(person)
end
