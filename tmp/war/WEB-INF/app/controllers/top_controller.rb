require 'cgi/session'

class TopController < ApplicationController
  $i = 1
  def list
    render :action => "list"
  end

  def new
    $i = 1
  end

  def add    
    @members = params[:members].first
    p params[:candidates0]["time(2i)"].to_i
    p params[:candidates1]["time(1i)"].to_i
    p params[:candidates3]
    p params[:candidates4]
    party = Parties.create(:name => params[:party][:party_name], :place => "test")
    j = 0
    candidate_num = 'candidates' + j.to_s
    while true
      p "+++++++++++++++++++++"
      p params['candidate_name']
      params.each_pair{|key,value|
        if /^candidates/ =~ key
        p key
        p params["key"]
        p value["time(2i)"].to_i
          candidate = Candidates.create(:party => party, :year => value["time(1i)"].to_i, :month => value["time(2i)"].to_i, :day => value["time(3i)"].to_i, :hour => value["time(4i)"].to_i, :minutes => value["time(5i)"].to_i, :point => 0)   
        end
        p "----------------"
        p candidate      
        #       value.each_pair{|key2,value2|
 #        p key2
 #         p value2
 #       }

      }
      if params["candidate_num"]
        candidate = Candidates.create(:party => party, :year => params["candidate_num"]["time(1i)"].to_i, :month => params["candidate_num"]["time(2i)"].to_i, :day => params["candidate_num"]["time(3i)"].to_i, :hour => params["candidate_num"]["time(4i)"].to_i, :minutes => params["candidate_num"]["time(5i)"].to_i, :point => 0)   
        p "-----------------------------"
        p candidate
        p "-----------------------------"
        members.each do |member|
          user = Users.all(:name => member).first
          Participates.create(:user => user, :candidate => candidate, :participation => 0)
          Weights.create(:user => user, :party => party, :weight => 0, :admin => 0)
        end
        j = j + 1 
      else
        break
      end
    end 
      @days = params[:candidates2]
    render :action => "show"
  end

  def show_detail
    @party = params[:party_id]
    p @party
    #@candidates = Candidates.all({:party_id => @party.id}, :order => 'party_id')
    @candidates = Candidates.all()
    p "@@@@@@@@@@@@@@@@@@@@@@@@"
    p @candidates
    p "@@@@@@@@@@@@@@@@@@@@@@@@"
  end
#Ajax処理
  def add_candidate
    name = 'candidates' + $i.to_s
    $i = $i.to_i + 1
    render :inline => "<br>" + "<%= datetime_select('#{name}','time[]',{ :start_year => Time.now.year, :end_year => Time.now.year+2, :use_month_numbers => true, :minute_steps => 15} ) %>"
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
