module Session 
    def full?(talk_duration)
        remaining_time == 0 || talk_duration > remaining_time
    end
end