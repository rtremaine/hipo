class RecordsController < ApplicationController
  respond_to :html, :json
  # GET /records
  # GET /records.json
  def index
    #TODO add security here
    @record_set = RecordSet.find_by_id(params[:record_set_id].to_i)
    records = Record.find_all_by_record_set_id(record_set.id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: records.collect {|r| r.to_jq_record }.to_json }
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @record = Record.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  def record
    decrypted_file = CarrierWave::SecureFile::Downloader.call(RecordUploader, Record.find(params[:id]), :record)
    send_file decrypted_file[:file], :content_type => decrypted_file[:content_type]
    File.unlink decrypted_file[:file]
  end

  # GET /records/new
  # GET /records/new.json
  def new
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/1/edit
  def edit
    @record = Record.find(params[:id])
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(params[:record])
    record_set = RecordSet.find_by_id(params[:record][:record_set_id])
    @record.patient_id = record_set.patient_id

    respond_to do |format|
      if @record.save
        format.json { render :json => [ @record.to_jq_record ].to_json }
      else
        format.json { render :json => [ @record.to_jq_record.merge({ :error => "custom_failure" }) ].to_json }
      end
    end
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Record.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:record])
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { render :json => true }
    end
  end
end
