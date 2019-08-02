class AppliesController < ApplicationController

  def new
    @apply = Apply.new
  end

  def create
    @apply = Apply.new(params[:apply])
    @apply.request = request
    if @apply.deliver
      flash.now[:error] = nil
    else
      flash.now[:error] = 'Cannot send message'
      render :new
    end
  end

  private

  def apply_params
  params.require(:apply).permit(:email, :first_name, :last_name, :nickname, :description, :category)
  end
end
