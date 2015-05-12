class ContactSharesController < ApplicationController

  def create
    new_share = ContactShare.new(contact_share_params)
    my_render(new_share)
  end

  def destroy
    old_share = ContactShare.find(params[:id])
    the_name = old_share.name
    old_share.destroy
    render json: the_name
  end

  private

  def contact_share_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end

  def my_render(new_share)
    if new_share.save
      render json: new_share
    else
      render json: 'Cannot be created!'
    end
  end
end
