class TeamsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:public]
  
  def index
  	#@teams = Team.all.order(when: :DESC)
    @team_pages = current_user.teams.page(params[:page]).order(when: :DESC)
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
    @team = current_user.teams.find(params[:id])
    #@contacts = current_user.contacts.all
  	@contacts = current_user.contacts.paginate(:page => params[:page], :per_page => 10)
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
      redirect_to :back#, notice: "#{Contact.find(join_params[:format]).name}點名成功"
    else
      redirect_to :back#, notice: "#{Contact.find(join_params[:format]).name}點名成功"
    end 
  end
  
  def quit
    @team = Team.find(params[:id])
    @contact = @team.contact_teams.find_by(contact_id: join_params[:format])
    @contact.destroy
    redirect_to :back#, alert: "#{Contact.find(join_params[:format]).name}缺席"
  end

  def add_adjustment
    @team = Team.find(params[:id])
    @team.adjustment = @team.adjustment + 1
    @team.save
    redirect_to teams_path
  end

  def sub_adjustment
    @team = Team.find(params[:id])
    @team.adjustment = @team.adjustment - 1
    @team.save
    redirect_to teams_path
  end

  def birthday
    params[:mons] ||= {}
    @monthes = params[:mons].keys.map(&:to_i)
    #monthes = params[:mons].map(&:to_i)
    @birthday = current_user.contacts.where(month: @monthes).page(params[:page])
  end
  

  def public
    @user = User.find(params[:id])
    @team_pages = @user.teams.paginate(:page => params[:page], :per_page => 11).order(when: :DESC)
  end

  def all
    @teams = current_user.teams.order(:when)
    @years = ( ( @teams.first.year )..( @teams.last.year ) ).to_a.reverse
    @year = params[:year] ||= @years.first
    @monthes = params[:monthes] ||= "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12"
    @teams = @teams.includes(:contact_teams).where(year: @year, month: @monthes.split(", ").map(&:to_i) )
    @when = @teams.map{ |team|team.when.to_s}
    @size = @teams.map{ |team|team.contact_teams.size + team.adjustment}
  end
  private

  def team_params
  	params.require(:team).permit(:when, :numbers, :remark)
  end

  def join_params
    params.permit(:format)
  end
end
