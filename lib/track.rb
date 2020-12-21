class Track
    attr_reader :title,:morning,:afternoon
    def initialize(title,morning,afternoon)
        @title = title
        @morning = morning
        @afternoon = afternoon
    end

    def addTalk(talk,is_morning)
        if is_morning
            talk.start = morning.start_time.strftime("%I:%M %p")
            @morning.talks << talk 
            @morning.remaining_time -= talk.duration
            morning.start_time += talk.duration * 60
       else
            talk.start = afternoon.start_time.strftime("%I:%M %p")
            @afternoon.talks << talk 
            @afternoon.remaining_time -= talk.duration
            afternoon.start_time += talk.duration * 60
       end
    end
    
end