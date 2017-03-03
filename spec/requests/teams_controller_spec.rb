require 'rails_helper'

RSpec.describe TeamsController, type: :request do
  let!(:user) { create(:user_has_contact_and_team_join_one) }
  before(:each) { login_user(user) }
  let(:contact) { user.contacts.first }
  let(:team) { user.teams.first }

  
  describe "GET /teams" do
  
    subject! { get "/teams" }
    
    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to render_template("teams/index") }
  
  end

  describe "POST /teams" do
    

    context "create team success" do
      
      before(:each) do
        
        data = {
          "team" => {
            "when" => Date.today
          }
        }
        
        post "/teams", data 
      
      end
      
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(teams_url) }

      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("#{Date.today}")
      
      end

    end

    context "create team failed" do
      
      before(:each) { post "/teams", { "team" => { "when" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/new") }
      it{ expect(flash[:warning]).to eq("有＊的欄位必填，請重新確認") }
      it{ expect(response.body).to include("有＊的欄位必填，請重新確認") }
    
    end
  
  end

  describe "PATCH team/:id" do
  

    context "update team success" do
      
      before(:each) do
        
        data = {
          "team" => {
            "when" => Date.today
          }
        }
        
        patch "/teams/#{team.id}", data 
      
      end

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(teams_url) }
      it { expect(flash[:notice]).to eq("修改成功") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("修改成功")
      
      end
    
    end

    context "update team failed" do
      
      before(:each) { patch "/teams/#{team.id}", { "team" => { "when" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/edit") }
    
    end
  
  end

  describe "DELETE team/:id" do
    
    before(:each) { delete "/teams/#{team.id}" }

    context "destroy team success" do

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to( teams_url ) }
      it { expect(flash[:alert]).to eq("刪除成功") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("刪除成功")
      
      end

    end

  end

  describe "GET team/:id" do
    
    before(:each) { get "/teams/#{team.id}" }

    context "show team success" do
    
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/show") }
      it{ expect(response.body).to include("#{contact.name}") }

    end 

  end

  describe "POST /teams/:id/join" do
    let!(:contact) { create(:contact, user_id: user.id) }
    context "join team success" do
      before do
        post "/teams/#{team.id}/join.js", contact: contact.id, xhr: true
      end

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/join") }
      it{ expect(response.body).to include("btn-success") }
    end
  end

  describe "POST /teams/:id/quit" do
    context "quit team success" do
      before do
        post "/teams/#{team.id}/quit.js", contact: contact.id, xhr: true
      end

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/quit") }
      it{ expect(response.body).to include("btn-danger") }
    end
  end

  describe "POST /teams/:id/adjustment" do
    context "add adjustment success" do
      before do
        post "/teams/#{team.id}/adjustment.js", adjustment: "add", xhr: true
      end

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/adjustment") }
      it{ expect(response.body).to include("var adjustment = 2;") }
    end

    context "sub adjustment success" do
      before do
        post "/teams/#{team.id}/adjustment.js", adjustment: "sub", xhr: true
      end

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("teams/adjustment") }
      it{ expect(response.body).to include("var adjustment = 0;") }
    end
  end

end
