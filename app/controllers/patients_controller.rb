class PatientsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json
  before_filter :authenticate_user!

  # GET /patients
  # GET /patients.json
  def index
    if current_user.is_admin?
      @patients = Patient.order('last asc').paginate(:page => params[:page],
                                                   :per_page => 15)
    else
      @patients = Patient.where :company_id => current_user.company_id
      @patients = @patients.order('last asc').paginate(:page => params[:page],
                                                   :per_page => 15)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    #@patient = Patient.find(params[:id])
    @record_set = RecordSet.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.json
  def new
    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    #@patient = Patient.find(params[:id])
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(params[:patient])

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render json: @patient, status: :created, location: @patient }
      else
        format.html { render action: "new" }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.json
  def update
    #@patient = Patient.find(params[:id])
    @patient.update_attributes(params[:patient])
    respond_with @patient
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    #@patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end
end
