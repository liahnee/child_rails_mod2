User.destroy_all
Child.destroy_all
Personality.destroy_all
Learning.destroy_all
Hobby.destroy_all
Socialization.destroy_all
Job.destroy_all
MainChild.destroy_all
###################################################################################
Learning.create(action:"Language", id:1)
Learning.create(action:"Mathematic", id:2)
Learning.create(action:"Coding", id:3)
Learning.create(action:"Art", id:4)

Hobby.create(action:"Sports", id:1)
Hobby.create(action:"Sing", id:2)
Hobby.create(action:"Read", id:3)
Hobby.create(action:"Draw", id:4)
Hobby.create(action:"Video game", id:5)

Socialization.create(action:"Playground", value: 0.30, id:1)
Socialization.create(action:"Zoo", value: 0.60, id:2)
Socialization.create(action:"Video game together", value: 0.25, id:3)
Socialization.create(action:"Theme Park", value: 0.70, id:4)

Job.create(title:"student", id:1)
Job.create(title:"tester", id:2)
Job.create(title:"post-secondary education student", id:3)

User.create(username: "test_user", password: "0000", id:1)

test1 = Child.create(
    first_name: "test1", 
    last_name: "child", 
    age: 23.00, 
    gender: "female", 
    ambition: "11", 
    happiness:"12", 
    social: 0.3, 
    art: 20,
    coding: 15, 
    language:20, 
    mathematic: 10, 
    job_id: 3,
    temp_job_id: 3,
    user_id:1, 
    id:1)

test2 = Child.create(
    first_name: "test2", 
    last_name: "child", 
    age: 18.00, 
    gender: "female", 
    ambition: "11", 
    happiness:"12", 
    social: 0.3, 
    art: 20, 
    coding: 15, 
    language:20, 
    mathematic: 10, 
    job_id: 1, 
    user_id:1, 
    temp_job_id: 1,
    id:2)

test3 = Child.create(
    first_name: "test3", 
    last_name: "child", 
    age: 23.00, 
    gender: "female", 
    ambition: "11", 
    happiness:"12", 
    social: 0.3, 
    art: 20, 
    coding: 15, 
    language:20, 
    mathematic: 10, 
    job_id: 3, 
    temp_job_id: 3,
    user_id:1, 
    id:3)

tp1 = Personality.create(
    child_id:1, 
    social_trait: "Introvert", 
    learning_trait: "All-rounder", 
    learning_id: 1, 
    hobby_id: 3, 
    id:1)

tp2 = Personality.create(
    child_id:2, 
    social_trait: "Introvert", 
    learning_trait: "All-rounder", 
    learning_id: 1, 
    hobby_id: 3, 
    id:2)

tp3 = Personality.create(
    child_id:3, 
    social_trait: "Introvert", 
    learning_trait: "All-rounder", 
    learning_id: 1, 
    hobby_id: 3, 
    id:3)

test1.personality_id = tp1.id
test1.save
test2.personality_id = tp2.id
test2.save
test3.personality_id = tp3.id
test3.save

MainChild.create(user_id:1, child_id:1, id:1)

Job.create(title: "unemployed", id:4)
Job.create(title: "software engineer", happiness: 10, ambition: 10, language: 10, mathematic: 8, coding: 20, art: 5, id:5)
Job.create(title: "ux/ui designer", happiness:10 , ambition:10 , language: 15, mathematic: 5, coding: 15, art: 20, id:6)
