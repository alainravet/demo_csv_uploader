require 'csv'

class CsvFilesController < ApplicationController
  # GET /csv_files
  # GET /csv_files.json
  def index
    @csv_files = CsvFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @csv_files }
    end
  end

  # GET /csv_files/1
  # GET /csv_files/1.json
  def show
    @csv_file = CsvFile.find(params[:id])

    @csv_contents_as_string = @csv_file.file.read
    csv_data = CSV.parse(@csv_contents_as_string)
    @headers = csv_data.first
    #csv_data.shift
    @csv_data = csv_data


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @csv_file }
    end
  end

  # source: https://github.com/carrierwaveuploader/carrierwave-mongoid#using-mongodbs-gridfs-store
  def file
    @csv_file = CsvFile.find(params[:id])
    content = @csv_file.file.read
    #if stale?(etag: content, last_modified: @csv_file.updated_at.utc, public: true)
      send_data content, type: @csv_file.file.file.content_type, filename: @csv_file.name
      #expires_in 0, public: true
    #end
  end
  # GET /csv_files/new
  # GET /csv_files/new.json
  def new
    @csv_file = CsvFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @csv_file }
    end
  end

  # GET /csv_files/1/edit
  def edit
    @csv_file = CsvFile.find(params[:id])
  end

  # POST /csv_files
  # POST /csv_files.json
  def create
    imported_file = params[:csv_file][:file]
    @csv_file = CsvFile.new(params[:csv_file])
    @csv_file.name = params[:csv_file][:file].original_filename rescue nil

    respond_to do |format|
      if @csv_file.save
        format.html { redirect_to @csv_file, notice: 'Csv file was successfully created.' }
        format.json { render json: @csv_file, status: :created, location: @csv_file }
      else
        format.html { render action: "new" }
        format.json { render json: @csv_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /csv_files/1
  # PUT /csv_files/1.json
  def update
    @csv_file = CsvFile.find(params[:id])

    respond_to do |format|
      if @csv_file.update_attributes(params[:csv_file])
        format.html { redirect_to @csv_file, notice: 'Csv file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @csv_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csv_files/1
  # DELETE /csv_files/1.json
  def destroy
    @csv_file = CsvFile.find(params[:id])
    @csv_file.destroy

    respond_to do |format|
      format.html { redirect_to csv_files_url }
      format.json { head :no_content }
    end
  end
end
