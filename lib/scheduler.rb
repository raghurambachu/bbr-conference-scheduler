require_relative("talk")
require_relative("qualified_talks")
require_relative("track")
require_relative("morning_session")
require_relative("afternoon_session")
require_relative("conference_scheduler")

track1 = Track.new("1st Track")
track2 = Track.new("2nd Track")

scheduler1 = ConferenceScheduler.new(track1,track2)

# track1, track2, not_scheduleable = scheduler1.schedule

scheduler1.print_scheduled_talks
scheduler1.print_non_scheduled_talks



