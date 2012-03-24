class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.id == current_user.id
        format.html # show.html.erb
        format.json { render json: @user }
      else
        format.html { redirect_to root_url, notice: 'You can only view your own account.' }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.company = Company.new unless @user.company

    respond_to do |format|
      if @user.id == current_user.id
        format.html # show.html.erb
        format.json { render json: @user }
      else
        format.html { redirect_to @user, notice: 'You can only update your own user account.' }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @user = User.find(params[:id])
    if @user
      @user.stripe_cancel_subscription
    end
    redirect_to current_user, notice: 'Subscription cancelled.'
  end
end
