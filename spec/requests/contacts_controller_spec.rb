require 'rails_helper'

RSpec.describe ContactsController, type: :request do
  let!(:user) { create(:user, email: "test@gmail.com") }
  before(:each) { login_user(user) }
  let!(:contact) { create(:contact, user_id: user.id) }

  
  describe "GET /contacts" do
  
    subject! { get "/contacts" }
    
    it{ expect(response).to be_success }
    it{ expect(response).to have_http_status(200) }
    it{ expect(response).to render_template("contacts/index") }
  
  end

  describe "POST /contacts" do
    

    context "create contact success" do
      
      before(:each) do
        
        data = {
          "contact" => {
            "name" => "aaa", 
            "birthday" => Date.today
          }
        }
        
        post "/contacts", data 
      
      end
      
      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(contacts_url) }

      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("aaa")
      
      end

    end

    context "create contact failed" do
      
      before(:each) { post "/contacts", { "contact" => { "name" => "aaa" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("contacts/new") }
      it{ expect(flash[:warning]).to eq("有＊的欄位必填，請重新確認") }
      it{ expect(response.body).to include("有＊的欄位必填，請重新確認") }
    
    end
  
  end

  describe "PATCH contact/:id" do
  

    context "update contact success" do
      
      before(:each) do
        
        data = {
          "contact" => {
            "name" => "bbb",
            "birthday" => Date.today
          }
        }
        
        patch "/contacts/#{contact.id}", data 
      
      end

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(contacts_url) }
      it{ expect(flash[:notice]).to eq("此名單修改成功") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("此名單修改成功")
      
      end
    
    end

    context "update contact failed" do
      
      before(:each) { patch "/contacts/#{contact.id}", { "contact" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("contacts/edit") }
    
    end
  
  end

  describe "DELETE contact/:id" do
    
    before(:each) { delete "/contacts/#{contact.id}" }

    context "destroy contact success" do

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to( contacts_url ) }
      it{ expect(flash[:alert]).to eq("此名單已刪除") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("此名單已刪除")
      
      end

    end

  end

  describe "GET contact/:id" do
    
    before(:each) { get "/contacts/#{contact.id}" }

    context "show contact success" do
    
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("contacts/show") }
      it{ expect(response.body).to include("聚會日期") }

    end 

  end

end
