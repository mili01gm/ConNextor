class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update ]
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # TODO for security, use a 128 bit hash instead of id when marshalling
    # params.require is prefered
    identity_id = params[:identity_id]
    profile_id = params[:profile_id]

    registering_with_omni_auth = identity_id and profile_id

    if registering_with_omni_auth
      @identity = Identity.find(identity_id)
      @user.profile = Profile.find(profile_id)
    end

    @user.password_login = true unless registering_with_omni_auth

    respond_to do |format|
      if @user.save
        #if registering_with_omni_auth
          #@identity.user = @user
          #@identity.save
        #else
          @profile = Profile.new
          @profile.save # no reason for it not to save
          @user.profile = @profile
          @user.save # no room for errors
        #end

        # Confirm Email here, don't login.
        session_create @user

        format.html { redirect_to controller: :profiles, action: :new, id: @user.profile_id}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @allusers = User.search(params[:search]).paginate(page: params[:page])
  end

  def edit
  end

  def update
    unless current_user == @user
      redirect_to @user, notice: 'permissions not right'
    end
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        logger.error "Attempted access to invalid user #{params[:id]}"
        redirect_to users_url, notice: 'Invalid user, please try again.'
      end
    end

    def user_params
      params.permit(
          :username,
          :email,
          :first_name,
          :last_name,
          :password,
          :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to log_in_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
