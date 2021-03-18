class RateSetting < ApplicationRecord

    def self.get_rate_at_day_week(date_time)
        rate_setting = RateSetting.find_by(day_of_week: date_time.wday)
        
        if (rate_setting.initial_time.strftime('%H:%M:%S')..rate_setting.end_time.strftime('%H:%M:%S')).include?(date_time.strftime('%H:%M:%S')) && ((1..5).include?(date_time.wday))
            return rate_setting.rate_cents
        else
            return rate_setting.alternative_rate_cents
        end 
    end

end
