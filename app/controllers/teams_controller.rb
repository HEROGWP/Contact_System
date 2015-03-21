class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@teams = Team.all
  end

  def new
  	@team = Team.new
  end

  def create
  	@team = current_user.teams.create(team_params)
    
    @team.save ? (redirect_to teams_path) : (flash[:warning] = "有＊的欄位必填，請重新確認"; render :new)
  end

  def edit
  	@team = current_user.teams.find([:id])
  end
 
  def update
  	@team = current_user.teams.find([:id])

  	@team ? (redirect_to teams_path, notice: "修改成功") : (render :edit)
  end

  def show
    @team = Team.find(params[:id])
  	@contacts = Contact.all
  end

  def destroy
  	@team = current_user.teams.find([:id])
  	@team.destroy

  	redirect_to teams_path, alert: "刪除成功"
  end
  
  def join
    binding.pry
    @team = Team.find(params[:id])
    @contact = @team.contact_teams.create(contact_id: join_params[:format])
    redirect_to team_path(params[:id]), notice: "成功"
  end


  private

  def team_params
  	params.require(:team).permit(:when, :numbers)
  end

  def join_params
    params.permit(:format)
  end
end
