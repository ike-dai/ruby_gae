class TopController < ApplicationController
  def input
    render :action => "input"
  end

  def result
    @test = "OK"
    @voter_name = params[:data][:name]
    @result = params[:data][:category]
    Voters.create(:name => @voter_name, :result => @result ).save!
    voter_list = Voters.all
    p voter_list.first.name
    p voter_list.first.result
    render :action => "result"
  end
end
