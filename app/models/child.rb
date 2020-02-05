class Child < ApplicationRecord
    belongs_to :user
    has_many :personalities, :dependent => :destroy
    belongs_to :job
    has_many :main_child,  :dependent => :destroy

    validates :first_name, length: { in: 2..10 }, presence: true
    validates :last_name, length: { in: 2..20 }, presence: true

    def base
        self.age = 10.00
        self.gender = c_gender
    
        self.ambition = 0.00 ##accumulative
        self.happiness = 0.50 ##accumulative
        self.social = 0.50 ##range 0.00-1.00

        self.art = 0.00 ##accumulative
        self.coding = 0.00 ##accumulative
        self.language = 0.00 ##accumulative
        self.mathematic = 0.00 ##accumulative
        
        self.job_id = 1
        self.temp_job_id = 1
    end
    def c_personality
        if self.age == 7.00 || self.age == 12.00 || self.age == 16.00
            social_trait_arr = %w(Introvert, Extrovert) 
            learning = Learning.all
            hobby = Hobby.all
            mp = Personality.create(
                child_id:self.id,
                learning_id: learning.sample.id, 
                hobby_id: hobby.sample.id,
                learning_trait: learning_trait_helper,
                social_trait: social_trait_arr.sample,
                )
            self.update personality_id: mp.id

        else
            puts "Age-c_personality error"
        end
    end
                ######### attribute setup helpers ##########
                def learning_trait_helper
                    case rand(100) 
                        when 1..90 then return 'Interest only'
                        when 91..100 then return 'All-rounder' 
                    end
                end

                def c_gender
                    gender = %w(female male).sample
                end
                ############################################  

    def action(params)
        params.each do |activity, action|
            if activity.include? "activity"
                @action_id = action.split(",")[1].delete!("]")
                @activity_action = action.split(",")[0].delete!("[").delete('\\"')
                if @activity_action == "Learning"
                    self.study(Learning.find(@action_id))
                elsif @activity_action == "Hobby"
                    self.do_hobby(Hobby.find(@action_id))
                elsif @activity_action == "Socialization"
                    self.socialize(Socialization.find(@action_id))
                end
            end
        end
    end
                
                ####################### action helpers ####################### 
                def study(action)
                    my_trait = Personality.find(self.personality_id).learning_trait
                    if  my_trait == "All-rounder" 
                        self.all_rounder(action)                        
                    elsif my_trait == "Interest only"
                        self.interest_only(action)
                    end 
                end 

                def all_rounder(action)
                    add = self.learning_match(action) * 0.7
                    self.ambition += 0.10
                    case action.action
                    when "language"
                        self.language += add
                    when "mathematic"
                        self.mathematic += add
                    when "coding"
                        self.coding += add
                    when "art"
                        self.coding += art
                    end
                end

                def interest_only(action)
                    factor = self.learning_match(action)
                    if factor == 1.0
                        self.ambition += 0.12
                        case action.action
                        when "Language"
                            self.language += factor
                        when "Mathematic"
                            self.mathematic += factor
                        when "Coding"
                            self.coding += factor
                        when "Art"
                            self.art += factor
                        end
                    elsif factor == 0.7
                        self.ambition += 0.05
                        case action.action
                        when "Language"
                            self.language += factor * 0.50
                        when "Mathematic"
                            self.mathematic += factor * 0.50
                        when "Coding"
                            self.coding += factor * 0.50
                        when "Art"
                            self.art += factor * 0.50
                        end
                    end
                end

                def learning_match(action)
                    if Personality.find(self.personality_id).learning_id == action.id
                        return 1.0
                    else 
                        return 0.7
                    end 
                end 

                def do_hobby(action)
                    if Personality.find(self.personality_id).hobby_id == action.id
                        @personality =Personality.find(self.personality_id).hobby_id == action.id
                        @personality.hobby_interest == action
                        self.happiness += 1.0
                        self.ambition -= 0.02
                    else 
                        self.happiness += 0.7
                        self.ambition -= 0.05
                    end 
                end

                def socialize(action) #action should be socialization instance with value
                    activity = Socialization.find_by(action:action)
                    happy_factor = self.socialize_helper(action)
                    if happy_factor == true
                        self.happiness += 1.0
                    elsif happy_factor == false
                        self.happiness -= 1.0
                    end
                    self.social += action.value
                    if self.social > 1.0
                        self.social = 1.0
                    end
                end

                def socialize_helper(action)
                    my_trait = Personality.find(self.personality_id).social_trait
                    if my_trait == "Introvert"
                        if self.social < 0.50
                            return true
                        else 
                            return false
                        end
                    elsif my_trait == "Extrovert"
                        if self.social + action.value >= 0.70
                            return true
                        else
                            return false
                        end
                    end
                end
                ############################################################## 

    def aging(child)
        if child.age == 18.00
            child.job_id = 3
        end
        child.age += 0.25
        child.social -= 0.25            
    end
                ##################### display helpers ##################### 
                def age_i
                    self.age.floor.to_i
                end
            
                def season
                    remainder = self.age.modulo(1)
                    if remainder == 0
                        return "spring"
                    elsif remainder == 0.25
                        return "summer"
                    elsif remainder == 0.50
                        return "fall"
                    elsif remainder == 0.75
                        return "winter"
                    end
                end
            
                def full_name
                    self.first_name + " " + self.last_name
                end

                def his_her
                    if self.gender == "female"
                        return "her"
                    else 
                        return "his"
                    end
                end

                def he_she
                    if self.gender == "female"
                        return "she"
                    else 
                        return "he"
                    end
                end
                ###########################################################

    def c_job
        possibilities = []
        Job.all.each do |job|
            if job.id > 3
                if c_job_helper(job)
                    possibilities << job.id
                end
            end
        end
        self.temp_job_id = possibilities.sample
        self.save
        Job.find(self.temp_job_id).title
    end

                ###################### c_job helper ######################
                def c_job_helper(job)
                    attributes = %w(happiness ambition language mathematic coding art)
                    attributes.each do |att|
                        if job.send(att) != nil
                            if self.send(att) < job.send(att) 
                                return false
                            end
                        end
                    end
                    return true
                end 
                ##########################################################

    def no_more?
        if self.age < 23.00 
            return true
        else 
            return false
        end
    end

    def not_yet?
        if self.job_id == 1 || self.job_id == 3
            if self.age >= 18 && self.age < 23
                return true
            else
                return false
            end
        else
            false
        end
    end
end
