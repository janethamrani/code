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
      flash.now[:error] = 'Error'
      render :new
    end
  end
end
