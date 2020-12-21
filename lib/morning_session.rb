class MorningSession
    attr_accessor :remaining_time,:talks,:start_time
    def initialize(start_time,end_time,alloted_time)
        @talks = []
        @start_time = start_time
        @remaining_time = alloted_time * 60
    end

    def full?(talk_duration)
        remaining_time == 0 || talk_duration > remaining_time
    end
end