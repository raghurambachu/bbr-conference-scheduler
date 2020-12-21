class ConferenceScheduler

    include QualifiedTalks
    attr_reader :all_talks,:tracks
    def initialize(track1,track2)
        @all_talks = QualifiedTalks::Talks
        @not_scheduleable = []
        @tracks = [track1,track2]
    end

    def add_talk_to_track(track,talk)
        if !track.morning.full?(talk.duration)
            track.add_talk(talk,true)
        elsif !track.afternoon.full?(talk.duration)
            track.add_talk(talk,false)
        else
            @not_scheduleable << talk
        end
    end


    def schedule
        counter = 0
        all_talks.sort! { |talk1,talk2| talk1.duration <=> talk2.duration  }  
        track1,track2 = tracks
        while !all_talks.empty?
            talk = all_talks.first

            add_talk_to_track(track1,talk) if counter.even?
            add_talk_to_track(track2,talk) if counter.odd?
 
            # Will ensure all lightningTalks are together
            counter += 1 if !talk.kind_of? (LightningTalk)
            all_talks.shift
        end
        return [track1,track2,@not_scheduleable]
    end

    def get_time_title(talk)
        puts "#{talk.start} #{talk.title}"
    end

    def print_scheduled_talks_for_track(track,title)
        puts title
        track.morning.talks.each { |talk| get_time_title(talk) }
        track.afternoon.talks.each { |talk| get_time_title(talk)  }
        puts
    end

    def print_scheduled_talks
        *tracks_list, not_scheduleable = schedule
        tracks_list.each.with_index { |track,index| print_scheduled_talks_for_track(track,"Track #{index + 1}")   }
    end

    def print_non_scheduled_talks
        *tracks_list, not_scheduleable = schedule
        puts "All the talks have been scheduled." if not_scheduleable.empty?
        not_scheduleable.each { |talk| puts talk.title } unless not_scheduleable.empty?
    end
end