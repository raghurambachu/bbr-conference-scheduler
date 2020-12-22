class Track
    attr_reader :title,:morning,:afternoon
    def initialize(title,morning = MorningSession.new(Time.local(2020 , 12, 20, 9),Time.local(2020, 12, 20, 12),3),afternoon = AfternoonSession.new(Time.local(2020, 12, 20, 13),Time.local(2020, 12, 20, 17),4))
        @title = title
        @morning = morning
        @afternoon = afternoon
    end

    def is_morning_session_full?(talk_duration)
        morning.full?(talk_duration)
    end
    def is_afternoon_session_full?(talk_duration)
        afternoon.full?(talk_duration)
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