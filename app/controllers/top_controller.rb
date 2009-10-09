class TopController < ApplicationController
  def input
    render :action => "input"
  end

  def result
    @test = "OK"
    @voter_name = params[:data][:name]
    @result = params[:data][:category]
    Voters.create(:name => @voter_name, :result => @result ).save!
    render :action => "result"
  end
end
