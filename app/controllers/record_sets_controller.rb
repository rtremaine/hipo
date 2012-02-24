class RecordSetsController < ApplicationController
  # GET /record_sets
  # GET /record_sets.json
  def index
    @record_sets = RecordSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @record_sets }
    end
  end

  # GET /record_sets/1
  # GET /record_sets/1.json
  def show
    @record_set = RecordSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record_set }
    end
  end

  # GET /record_sets/new
  # GET /record_sets/new.json
  def new
    @record_set = RecordSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record_set }
    end
  end

  # GET /record_sets/1/edit
  def edit
    @record_set = RecordSet.find(params[:id])
  end

  # POST /record_sets
  # POST /record_sets.json
  def create
    @record_set = RecordSet.new(params[:record_set])

    respond_to do |format|
      if @record_set.save
        format.html { redirect_to @record_set, notice: 'Record set was successfully created.' }
        format.json { render json: @record_set, status: :created, location: @record_set }
      else
        format.html { render action: "new" }
        format.json { render json: @record_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /record_sets/1
  # PUT /record_sets/1.json
  def update
    @record_set = RecordSet.find(params[:id])

    respond_to do |format|
      if @record_set.update_attributes(params[:record_set])
        format.html { redirect_to @record_set, notice: 'Record set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /record_sets/1
  # DELETE /record_sets/1.json
  def destroy
    @record_set = RecordSet.find(params[:id])
    @record_set.destroy

    respond_to do |format|
      format.html { redirect_to record_sets_url }
      format.json { head :no_content }
    end
  end
end
