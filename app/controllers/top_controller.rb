require 'cgi/session'

class TopController < ApplicationController
  $i = 1
  WEIGHT_POINT = 5
  def list
    render :action => "list"
  end

  def new
    $i = 1
  end

  def add    
    if params[:members].blank? or params[:party][:party_name].blank?
      redirect_to :action => "new", :params => {:message => "正しく入力してください!"}
    else
      @members = params[:members].first
      party = Parties.create(:name => params[:party][:party_name], :place => "test")
      j = 0
      candidate_num = 'candidates' + j.to_s
      params.each_pair{|key,value|
        if /^candidates/ =~ key
          candidate = Candidates.create(:party => party, :year => value["time(1i)"].to_i, :month => value["time(2i)"].to_i, :day => value["time(3i)"].to_i, :hour => value["time(4i)"].to_i, :minutes => value["time(5i)"].to_i, :point => 0)   
          params[:members].each do |member|
            user = Users.all(:name => member).first
            Participates.create(:user => user, :candidate => candidate, :participation => 0)
            unless params[:weights].blank?
              params[:weights].each do |weight|
                if member == weight
                  Weights.create(:user => user, :party => party, :weight => WEIGHT_POINT, :admin => 0)
                else
                  Weights.create(:user => user, :party => party, :weight => 1, :admin => 0)
                end
              end
            else
              Weights.create(:user => user, :party => party, :weight => 1, :admin => 0)
            end
          end
        end
      }
      redirect_to :action => "show", :params => {:message => "完了!"}
    end
  end

  def show_detail
    @candidates = Candidates.all({:party_id => params[:party_id].to_i})
    @participates = Participates.all({:candidate_id => @candidates.first.key})
    #    p @candidates
 #   p @candidates.first.participates
  #  test = 104
    #@participates = Participates.all({:candidate_id => @candidates.first.})
    #@participates = @candidates.first.participates
   # @participates = Participates.all({:candidate_id => test})
   # p @participates
    #p Participates.all
  end
  def party_delete
    p params[:party_id]
#    p Parties.get(params[:party_id].to_i)
    Parties.all().each do |party|
      if party.key == params[:party_id].to_i
        p "hoge"
        p party
        #Parties.all().first.delete!
        party.delete!
      end
      p "aaaa"
      p party
    end
    #params[:party_id].delete!
   # flash[:message] = "削除完了!"
    redirect_to :action => "show", :params => {:message => "削除完了!"}
  end
#Ajax処理
  def add_candidate
    name = 'candidates' + $i.to_s
    $i = $i.to_i + 1
    render :inline => "<br>" + "<%= datetime_select('#{name}','time',{ :start_year => Time.now.year, :end_year => Time.now.year+2, :use_month_numbers => true, :minute_steps => 15} ) %>"
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
#Ajax処理
  def yes
    p params[:id]
    Participates.all().each do |participate|
      if participate.key == params[:id].to_i
        p "test"
        participate.participation = 1
        participate.save!
      end
    end
   # render :text => CGI.escapeHTML("<font color='red' size='+2'>OK</font>")
    render :text => ("<font color='red' size='+2'>OK</font>")
  end
#Ajax処理
  def no
    Participates.all().each do |participate|
      if participate.key == params[:id].to_i
        participate.participation = 2
        participate.save!
      end
    end

    #render :text => CGI.escapeHTML("<font color='blue' size='+2'>NG</font>")
    render :text => "<font color='blue' size='+2'>NG</font>"
  end

end
