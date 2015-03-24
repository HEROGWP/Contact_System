class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
  	#@teams = Team.all.order(when: :DESC)
    @team_pages = Team.page(params[:page]).order(when: :DESC)
  end

  def new
  	@team = Team.new
  end

  def create
  	@team = current_user.teams.create(team_params)
    @team.save ? (redirect_to teams_path) : (flash[:warning] = "有＊的欄位必填，請重新確認"; render :new)
  end

  def edit
    #binding.pry
  	@team = current_user.teams.find(params[:id])
  end
 
  def update
  	@team = current_user.teams.find(params[:id])

  	@team.update(team_params) ? (redirect_to teams_path, notice: "修改成功") : (render :edit)
  end

  def show
    @team = Team.find(params[:id])
  	@contacts = Contact.all
  end

  def destroy
  	@team = current_user.teams.find(params[:id])
  	@team.destroy

  	redirect_to teams_path, alert: "刪除成功"
  end
  
  def join
    @team = Team.find(params[:id])
    if !@team.contact_teams.where(contact_id: join_params[:format]).present?
      @contact = @team.contact_teams.create(contact_id: join_params[:format])
      redirect_to team_path(params[:id]), notice: "#{Contact.find(join_params[:format]).name}點名成功"
    else
      redirect_to team_path(params[:id]), notice: "#{Contact.find(join_params[:format]).name}點名成功"
    end 
  end
  
  def quit
    @team = Team.find(params[:id])
    @contact = @team.contact_teams.find_by(contact_id: join_params[:format])
    @contact.destroy
    redirect_to team_path(params[:id]), alert: "#{Contact.find(join_params[:format]).name}缺席"
  end

  def birthday
    params[:mons] ||= {}
    @monthes = params[:mons].keys.map(&:to_i)
    #monthes = params[:mons].map(&:to_i)
    @birthday = Contact.where(month: @monthes).page(params[:page])
  end
  private

  def team_params
  	params.require(:team).permit(:when, :numbers)
  end

  def join_params
    params.permit(:format)
  end
end
