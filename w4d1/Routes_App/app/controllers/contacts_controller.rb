class ContactsController < ApplicationController
  def index
    current_user = User.find(params[:user_id])
    display = []
    display << current_user.contacts
    display << current_user.shared_contacts
    render json: display
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    new_name, new_email = params[contact_params]
    contact.name, contact.email = new_name, new_email
  end

  def create
    contact = Contact.new(contact_params)
    my_render(contact)
  end

  def destroy
    contact_email = Contact.find(params[:id]).email
    Contact.destroy(params[:id])
    render text: "deleted contact #{contact_email}!"
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email)
  end

  def my_render(contact)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: unprocessable_entity
      )
    end
  end
end
