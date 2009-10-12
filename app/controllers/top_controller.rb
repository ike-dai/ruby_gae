class TopController < ApplicationController
  def list
    render :action => "list"
  end

  def new
  end

  def add    
    @members = params[:members].first
    p params[:candidates1]
    p params[:candidates2]
    p params[:candidates3]
    p params[:candidates4]

    @days = params[:candidates1]
  end

#Ajax処理
  def add_candidate
    p params[:count]
    name = 'candidates' + params[:count]   
    render :inline => "<br>" + "<%= datetime_select('#{name}','time[]',{ :start_year => Time.now.year, :end_year => Time.now.year+2, :use_month_numbers => true, :minute_steps => 15} ) %>"
  end

  def increment_count i
    @i = i.to_i + 1
  end
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
