class Api::V1::ContactsController < Api::V1::ApiController
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :require_authentication!, only: [:show, :update, :update]

  def index
    @contacts = current_user.contacts

    render json: @contacts
  end

  def show
    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params.merge(user: current_user))

    # Set HTTP Status if Save or not
    if @contact.save
      render json: @contact, status: :created # 201
    else
      render json: @contact.errors, status: :unprocessable_entity # 422
    end
  end

  def update
     if @contact.update
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity # 422
    end
  end
  def destroy

  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :description)
  end

  # Verify if the Current User owns the Contact he wants to access
  def require_authentication!
    unless current_user == @contact.user
      render json: {}, status: :forbidden
    end
  end

end
