class ApplicationController < ActionController::Base
    def action(params)
        params.each do |activity|
            action = activity[1][0]
            if activity[0] == 'Study'
                    @child.learning(action)
                end
            elsif activity[0] == 'Play'
                    @child.do_hobby(action)
                end
            elsif activity[0] == 'Socialize'
                    @child.socialize(action)
                end
            end
        end
    end
end
