Job.destroy_all
Learning.destroy_all
Hobby.destroy_all
Socialization.destroy_all
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Learning.create(action:"Language", id:1)
Learning.create(action:"Mathematic", id:2)
Learning.create(action:"Coding", id:3)
Learning.create(action:"Art", id:4)

Hobby.create(action:"Sports", id:1)
Hobby.create(action:"Sing", id:2)
Hobby.create(action:"Read", id:3)
Hobby.create(action:"Draw", id:4)
Hobby.create(action:"Video game", id:5)

Socialization.create(action:"Playground", value: 1, id:1)
Socialization.create(action:"Zoo", value: 2, id:2)
Socialization.create(action:"Video game together", value: 3, id:3)
Socialization.create(action:"Theme Park", value: 4, id:4)

Job.create(title:"student", id:1)




    # @learning = w%(Language Mathematics Coding Art)
    # @hobby = w%(Reading Games Singing Drawing Sport)