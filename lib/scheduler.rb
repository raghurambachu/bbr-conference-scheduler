require_relative("talk")
require_relative("qualified_talks")
require_relative("track")
require_relative("morning_session")
require_relative("afternoon_session")

class ConferenceScheduler

    include QualifiedTalks
    attr_reader :all_talks
    def initialize
        @all_talks = QualifiedTalks::Talks
        @not_scheduleable = []
    end

    def add_talk_to_track(track,talk)
        if !track.morning.full?(talk.duration)
            track.addTalk(talk,true)
        elsif !track.afternoon.full?(talk.duration)
            track.addTalk(talk,false)
        else
            @not_scheduleable << talk
        end
    end


    def schedule(track1,track2)
        counter = 0
        all_talks.sort! { |talk1,talk2| talk1.duration <=> talk2.duration  }  
     
        while !all_talks.empty?
            talk = all_talks.first
            if counter.even?
               add_talk_to_track(track1,talk)
            else
                add_talk_to_track(track2,talk)
            end
            counter += 1
            all_talks.shift
        end
        return [track1,track2,@not_scheduleable]
    end

end


track1 = Track.new("1st Track",MorningSession.new(Time.local(2020 , 12, 20, 9),Time.local(2020, 12, 20, 12),3),AfternoonSession.new(Time.local(2020, 12, 20, 13),Time.local(2020, 12, 20, 17),3))
track2 = Track.new("2nd Track",MorningSession.new(Time.local(2020 , 12, 20, 9),Time.local(2020, 12, 20, 12),3),AfternoonSession.new(Time.local(2020, 12, 20, 13),Time.local(2020, 12, 20, 17),3))

scheduler1 = ConferenceScheduler.new

track1, track2, not_scheduleable = scheduler1.schedule(track1,track2)

p track2.morning.talks
puts 
p track1.morning.talks

p not_scheduleable
