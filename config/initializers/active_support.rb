# monkey patch for formatting time with json format
class ActiveSupport::TimeWithZone
    def as_json(options = {})
        strftime('%Y-%m-%d %H:%M:%S')
    end
end
