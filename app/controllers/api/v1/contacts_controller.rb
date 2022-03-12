class Api::V1::ContactsController < ApplicationController
  before_action :set_contact, :only [:show, :update, :destroy]
  before_action :require_authentication, :only[:show, :update, :update]

  def index
    @contacts = current_user.contacts
    render json: @contacts
  end

  def show
    render json: contact
  end

  def create
    @contact = Contact.new(contact_params.merge(user: current_user))

    # Set HTTP Status if Save or not
    if @contact.save
      render json: @contact, status :created
    else
      render json: @contact.errors, status :unprocessable_entity
    end
  end

  def destroy
  end
  private

  def set_contact
  end

  def require_authentication
  end

  def contact_params
    contac
  end
end
