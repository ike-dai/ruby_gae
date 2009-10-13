class AdminController < ApplicationController
  def show
    render :action => "show"
  end

  def new
    render :action => "new"
  end
 
  def add
    Users.create(:name => params[:data][:name]).save!
    render :action => "show"
  end
end
