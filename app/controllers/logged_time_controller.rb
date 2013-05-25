class LoggedTimeController < ApplicationController
  def index
    @logged_times = [Time.now]
  end
end
