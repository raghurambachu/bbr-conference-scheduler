require_relative("talk")
require_relative("qualified_talks")
require_relative("track")
require_relative("morning_session")
require_relative("afternoon_session")

track1 = Track.new("1st Track",MorningSession.new(Time.local(2020 , 12, 20, 9),Time.local(2020, 12, 20, 12),3),AfternoonSession.new(Time.local(2020, 12, 20, 13),Time.local(2020, 12, 20, 17),3))
track2 = Track.new("2nd Track",MorningSession.new(Time.local(2020 , 12, 20, 9),Time.local(2020, 12, 20, 12),3),AfternoonSession.new(Time.local(2020, 12, 20, 13),Time.local(2020, 12, 20, 17),3))
# track2 = Track.new("2nd Track",MorningSession.new("09:00 AM","12:00 PM",3),AfternoonSession.new("13.00 PM","17.00 PM",3))



class ConferenceScheduler

    include QualifiedTalks
    attr_reader :all_talks
    def initialize
        @all_talks = QualifiedTalks::Talks
        @not_scheduleable = []
    end

    def schedule(track1,track2)
        counter = 0
        all_talks.sort! { |talk1,talk2| talk1.duration <=> talk2.duration  }  
     
        while !all_talks.empty?
            talk = all_talks.first
            if counter.even?
                if !track1.morning.full?(talk.duration)
                    track1.addTalk(talk,true)
                elsif !track1.afternoon.full?(talk.duration)
                    track1.addTalk(talk,false)
                else
                    @not_scheduleable << talk
                end
            else
                if !track2.morning.full?(talk.duration)
                    track2.addTalk(talk,true)
                elsif !track2.afternoon.full?(talk.duration)
                    track2.addTalk(talk,false)
                else
                    @not_scheduleable << talk
                end
            end
            counter += 1
            all_talks.shift
        end
        return [track1,track2,@non_scheduleable]
    end

end


scheduler1 = ConferenceScheduler.new

track1, track2, not_scheduleable = scheduler1.schedule(track1,track2)

p track2.morning.talks
puts 
p track1.morning.talks

p not_scheduleable
