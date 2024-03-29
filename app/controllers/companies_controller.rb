class CompaniesController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  # GET /companies
  # GET /companies.json
  def index
    if current_user.is_admin?
      @companies = Company.all
    else
      @companies = Company.where(:id => current_user.company_id)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def invite_new_user
    @user = User.new(:email => params[:email], :password => User.fake_password)
    @user.company_id = current_user.company.id
    @user.invited_by_id = current_user.id
    @company = current_user.company

    if @user.save!
      UserMailer.new_invite(@user).deliver
      redirect_to @company, notice: 'User was successfully invited.'
    else
      redirect_to @company, notice: 'User could not be invited.'
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        current_user.company_id = @company.id
        current_user.save!
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
