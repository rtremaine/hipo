class DentistsController < ApplicationController
  # GET /dentists
  # GET /dentists.json
  def index
    @dentists = Dentist.order('last asc').paginate(:page => params[:page],
                                                   :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dentists }
    end
  end

  def searchall
  end

  # GET /dentists/1
  # GET /dentists/1.json
  def show
    @dentist = Dentist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dentist }
    end
  end

  # GET /dentists/new
  # GET /dentists/new.json
  def new
    @dentist = Dentist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dentist }
    end
  end

  # GET /dentists/1/edit
  def edit
    @dentist = Dentist.find(params[:id])
  end

  # POST /dentists
  # POST /dentists.json
  def create
    @dentist = Dentist.new(params[:dentist])

    respond_to do |format|
      if @dentist.save
        format.html { redirect_to @dentist, notice: 'Dentist was successfully created.' }
        format.json { render json: @dentist, status: :created, location: @dentist }
      else
        format.html { render action: "new" }
        format.json { render json: @dentist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dentists/1
  # PUT /dentists/1.json
  def update
    @dentist = Dentist.find(params[:id])

    respond_to do |format|
      if @dentist.update_attributes(params[:dentist])
        format.html { redirect_to @dentist, notice: 'Dentist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dentist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dentists/1
  # DELETE /dentists/1.json
  def destroy
    @dentist = Dentist.find(params[:id])
    @dentist.destroy

    respond_to do |format|
      format.html { redirect_to dentists_url }
      format.json { head :no_content }
    end
  end
end
