class Track
    attr_reader :title,:morning,:afternoon
    def initialize(title,morning,afternoon)
        @title = title
        @morning = morning
        @afternoon = afternoon
    end

    def add_talk_to_session(talk,session)
        talk.start = session.start_time.strftime("%I:%M %p")
        session.talks << talk 
        session.remaining_time -= talk.duration
        session.start_time += talk.duration * 60
    end

    def add_talk(talk,is_morning)
        if is_morning
           add_talk_to_session(talk,morning)
       else
           add_talk_to_session(talk,afternoon)
       end
    end
    
end