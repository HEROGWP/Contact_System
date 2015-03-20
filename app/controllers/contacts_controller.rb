class ContactsController < ApplicationController
  
  def index
  	@contacts = Contact.all
  end
  
  def create
  	@contact = Contact.create(contact_params)

    @contact.save ? (redirect_to contacts_path) : ( flash[:warning] = "有＊的欄位必填，請重新確認"; render :new)
  end

  def new
  	@contact = Contact.new
  end

  def show
  	
  end

  def edit
  	@contact = Contact.find(params[:id])
  end

  def update
  	@contact = Contact.find(params[:id])

    @contact.update(contact_params) ? (redirect_to contacts_path, notice: "此名單修改成功") : (render :edit)
  end

  def destroy
  	@contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path, alert: "此名單已刪除"
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :birthday, :phone, :address, :remark)
  end
end
