class Child < ApplicationRecord
    belongs_to :user
    has_many :personalities
    belongs_to :job

    validates :first_name, length: { maximum: 10 }, presence: true
    validates :last_name, length: { maximum: 20 }, presence: true

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

    ############################################   initialize helpers

    def learning_trait_helper
        case rand(100) 
            when 1..90 then 'Interest only'
            when 91..100 then 'All-rounder' 
        end
    end

    def c_personality_helper
        @social_trait = %w(Introvert, Extrovert) 
        learning = Learning.all
        hobby = Hobby.all
        mp = Personality.create(
            learning_interest_id: learning.sample, 
            hobby_interest_id: hobby.sample,
            learning_trait: learning_trait_helper,
            social_trait: @social_trait.sample,
            child_id: self.id
            )
        self.personality_id = mp.id
    end

    def c_personality
        if self.age == 7.00 || self.age == 12.00 || self.age == 16.00
            if Personality.find_by(child_id:self.id)
                Personality.find_by(child_id:self.id).destory
                c_personality_helper
            else
                c_personality_helper
            end
        else
            puts "Age-c_personality error"
        end

    end

    def c_gender
        gender = %w(female male).sample
    end

    ############################################   display helpers 

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

    ############################################   action helpers 

    def learning_match(action)
        if @child.personality.learning_interest == action
            return 1.0
        else 
            return 0.7
        end 
    end 

    def learning(action)
        action_name = action.name
        total = learning_match(action)
        if @child.learning_trait == "All-rounder"
            @child.action_name.to_sym += total * 0.7
            @child.ambition += 0.70
        elsif @child.learning_tait == "Interest only"
            if total == 1.0
                @child.action_name.to_sym += total
                @child.ambition += 7.0
            elsif total == 0.7
                @child.action_name.to_sym += total * 0.5
                @child.ambition += 0.50
            end
        end 
        
    end 

    def do_hobby(action)
        if @child.personality.hobby_interest == action
            @child.happiness += 1.0
        else 
            @child.happiness += 0.7
        end 
    end

    def socialize_helper(action)
        if @child.social_trait == "Introvert"
            if @child.social < 0.50
                return true
            else 
                return false
            end
        elsif @child.social_trait == "Extrovert"
            if @child.social + action.value >= 0.70
                return true
            else
                return false
            end
        end
    end

    def socialize(action) #action should be socialization instance with value
        activity = Socilization.find_by(action:action)
        happy_factor = socialize_helper(activity)
        if happy_factor == true
            @child.happiness += 1.0
        elsif happy_factor == false
            @child.happiness -= 1.0
        end
        
        @child.social += activity.value 
        if @child.social > 1.0
            @child.social = 1.0
        end
    end



    def action(params)
        params.each do |activity|
            action = activity[1][0]
            if activity[0] == 'Study'
                    @child.learning(action)
            elsif activity[0] == 'Play'
                    @child.do_hobby(action)
            elsif activity[0] == 'Socialize'
                    @child.socialize(action)
            end
        end
    end

    def aging(child)
        child.age += 0.25
        child.social -= 0.25
    end
end
