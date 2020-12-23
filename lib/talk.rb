class Talk
    def self.register(title,duration)
        if duration == 5
            LightningTalk
        else    
            NormalTalk
        end.new(title,duration)
    end
end

class NormalTalk < Talk
    attr_accessor :title,:duration,:start
    def initialize(title,duration,start = nil)
        @title = title
        @duration = duration
        @start = start
    end
end

class LightningTalk < Talk
    attr_accessor :title,:duration,:start
    def initialize(title,duration,start = nil)
        @title = title
        @duration = duration
        @start = start
    end
end