class LoggedTimeController < ApplicationController
  def index
    LoggedTime.create value: Time.now
    @logged_times = LoggedTime.descending(:value).all
  end
end
