class AudioRecordController < ApplicationController
  def index
  end

  def example1
  end

  def example2
  end

  def create
    raw_input  = request.env['rack.input']
    #raise request.env['rack.input'].inspect
    #raise params.inspect
    filename = "recorded_audio_#{Time.now.strftime('%Y%m%d%H%M%S')}.wav"
    upload_dir = Rails.root.join('tmp')
    File.open(upload_dir.join(filename), 'wb') do |file|
      file.puts(env['rack.input'].read)
    end
    render :nothing => true
  end
end
