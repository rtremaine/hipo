class RecordSetsController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :json
  # GET /record_sets
  # GET /record_sets.json
  def index
    @record_sets = Company.find(current_user.company_id).record_sets.where(:status => RecordSet::STATUS_VISIBLE)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @record_sets }
    end
  end

  def view
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record_set }
    end
  end

  def show
    @record = Record.new
    @share = Share.new
    @shares = Share.where(:record_set_id => @record_set.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record_set }
    end
  end

  def new
    @record_set = RecordSet.new
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record_set }
    end
  end

  # GET /record_sets/1/edit
  def edit
    @record = Record.new
  end

  def create
    @record_set.user_id = current_user.id

    respond_to do |format|
      if @record_set.save
        format.html { redirect_to @record_set, notice: 'Record set was successfully created.' }
        format.json { render json: [ @record_set.to_jq_record_set ].to_json }
      else
        format.html { render action: "new" }
        format.json { render json: @record_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /record_sets/1
  # PUT /record_sets/1.json
  def update
    @record_set.update_attributes(params[:record_set])
    respond_with @record_set
  end

  # DELETE /record_sets/1
  # DELETE /record_sets/1.json
  def destroy
    @record_set.destroy

    respond_to do |format|
      format.html { redirect_to record_sets_url }
      format.json { head :no_content }
    end
  end
end
