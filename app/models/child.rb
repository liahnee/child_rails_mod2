class Child < ApplicationRecord
    belongs_to :user
    has_many :personalities
    belongs_to :job

    validates :first_name, length: { in: 2..10 }, presence: true
    validates :last_name, length: { in: 2..20 }, presence: true

    @learning_trait = [ "All-rounder", "Interest only" ]
    @social_trait = %w(Introvert, Extrovert) 

    def base
        self.age = 7.00
        self.gender = c_gender
    
        self.ambition = 0.00 ##accumulative
        self.happiness = 0.50 ##accumulative
        self.social = 0.50 ##range 0.00-1.00

        self.art = 0.00 ##accumulative
        self.coding = 0.00 ##accumulative
        self.language = 0.00 ##accumulative
        self.mathematic = 0.00 ##accumulative
        
        self.job_id = 1
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
                    binding.pry
                elsif @activity_action == "Hobby"
                    self.do_hobby(Hobby.find(@action_id))
                elsif @activity_action == "Socialization"
                    self.socialize(Socialization.find(@action_id))
                end
            end
        end
        binding.pry
    end
                
                ####################### action helpers ####################### 

                def learning_match(action)
                    if Personality.find(self.personality_id).learning_interest_id == action.id
                        return 1.0
                    else 
                        return 0.7
                    end 
                end 

                def all_rounder(action)
                    add = learning_match(action) * 0.7
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
                    factor = learning_match(action)
                    if factor == 1.0
                        self.ambition += 7.0
                        case action.action
                        when "language"
                            if action
                            self.language += factor
                        when "mathematic"
                            self.mathematic += factor
                        when "coding"
                            self.coding += factor
                        when "art"
                            self.art += factor
                        end
                    elsif factor == 0.7
                        self.ambition += 0.50
                        case action.action
                        when "language"
                            if action
                            self.language += factor * 0.50
                        when "mathematic"
                            self.mathematic += factor * 0.50
                        when "coding"
                            self.coding += factor * 0.50
                        when "art"
                            self.art += factor * 0.50
                        end
                    end
                end

                def study(action)
                    if self.learning_trait == "All-rounder" 
                        all_rounder(action)
                        self.ambition += 0.70
                    elsif self.learning_trait == "Interest only"
                        interest_only(action)
                    end 
                end 

                def do_hobby(action)
                    if self.personality.hobby_interest == action
                        self.happiness += 1.0
                    else 
                        self.happiness += 0.7
                    end 
                end

                def socialize_helper(action)
                    if self.social_trait == "Introvert"
                        if self.social < 0.50
                            return true
                        else 
                            return false
                        end
                    elsif self.social_trait == "Extrovert"
                        if self.social + action.value >= 0.70
                            return true
                        else
                            return false
                        end
                    end
                end

                def socialize(action) #action should be socialization instance with value
                    activity = Socialization.find_by(action:action)
                    happy_factor = socialize_helper(activity)
                    if happy_factor == true
                        self.happiness += 1.0
                    elsif happy_factor == false
                        self.happiness -= 1.0
                    end
                    
                    self.social += activity.value 
                    if self.social > 1.0
                        self.social = 1.0
                    end
                end
                ############################################################## 

    def aging(child)
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
                ###########################################################


end
