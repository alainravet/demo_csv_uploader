class AudioRecordController < ApplicationController
  def index
    @audios = Audio.all
    audio = @audios.first
    audio2= @audios.last
  end

  def example1
  end

  def example2
  end

  def create
    raw_input  = request.env['rack.input']
    #raise request.env['rack.input'].inspect
    #raise params.inspect
    @audio = Audio.new
    filename = "recorded_audio_#{Time.now.strftime('%Y%m%d%H%M%S')}.wav"
    upload_dir = Rails.root.join('tmp')
    File.open(upload_dir.join(filename), 'wb') do |file|
      file.puts(env['rack.input'].read)
      @audio.file = file
      @audio.save!
    end


    render :nothing => true
  end

  def file
    @audio = Audio.find(params[:id])
    content = @audio.file.read
    #if stale?(etag: content, last_modified: @csv_file.updated_at.utc, public: true)
      send_data content, type: @audio.file.file.content_type
      #expires_in 0, public: true
    #end
  end

  # DELETE /csv_files/1
  # DELETE /csv_files/1.json
  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    respond_to do |format|
      format.html { redirect_to audio_path}
      format.json { head :no_content }
    end
  end
end
