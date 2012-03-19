class SharesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @shares = Share.where(:sender_id => current_user.id).order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shares }
    end
  end
  
  def inbox
    @shares = Share.where(:recipient_id => current_user.id).order('created_at desc')
    @shares = Share.joins('join contacts c on shares.recipient_id = c.id join users u on c.user_id = u.id')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shares }
    end
  end
  
  def send_new_share_email
    @share = Share.find params[:id]
    msg = 'Share not found'

    if @share   
      ShareMailer.new_share(@share).deliver
      @share.emailed_date = Time.now
      @share.save
      msg = 'Record sharing email sent'
    end

    redirect_to shares_path, notice: msg
  end

  # GET /shares/1
  # GET /shares/1.json
  def show
    @share = Share.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @share }
    end
  end

  # GET /shares/new
  # GET /shares/new.json
  def new
    @share = Share.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @share }
    end
  end

  # GET /shares/1/edit
  def edit
    @share = Share.find(params[:id])
  end

  def create_contact_and_share
    user = User.find(params[:sender_id])
    rset = RecordSet.find(params[:record_set_id])
    contact = Contact.create_with_user(params[:email], user)

    if user and rset and contact.save
      @share = Share.new(:sender_id => user.id,
                         :recipient_id => contact.id,
                         :record_set_id => rset.id)
    end

    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'Share was successfully created.' }
        format.json { render json: @share, status: :created, location: @share }
      else
        format.html { render action: "new" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /shares
  # POST /shares.json
  def create
    @share = Share.new(params[:share])

    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'Share was successfully created.' }
        format.json { render json: @share, status: :created, location: @share }
      else
        format.html { render action: "new" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shares/1
  # PUT /shares/1.json
  def update
    @share = Share.find(params[:id])

    respond_to do |format|
      if @share.update_attributes(params[:share])
        format.html { redirect_to @share, notice: 'Share was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share = Share.find(params[:id])
    @share.destroy

    respond_to do |format|
      format.html { redirect_to shares_url }
      format.json { head :no_content }
    end
  end
end
