class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
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
