class Profile < ActiveRecord::Base

  has_one :user
  has_one :profile_introduction, dependent: :destroy
  has_many :profile_experiences, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :profile_educations, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :profile_contacts, -> { order(created_at: :asc) }, dependent: :destroy

  accepts_nested_attributes_for :user
  attr_accessor :has_idea
  attr_accessor :code
  attr_accessor :first_name
  attr_accessor :last_name

  mount_uploader :resume, DocUploader
  mount_uploader :profile_photo, ImageUploader
  mount_uploader :cover_photo, ImageUploader

  ##########Registration############

  def self.initialize( profile )
    profile.profile_photo = '/cats/cat-profile.jpg'
    profile.cover_photo = '/cats/abstract-background.jpg'
    if profile.user
      if profile.user.first_name
        profile.first_name = profile.user.first_name
      end
      if profile.user.last_name
        profile.last_name = profile.user.last_name
      end
    end
    profile
  end

  def update_user_info( user, profile_params )
    if profile_params[:first_name]
      user.update( first_name: profile_params[:first_name] )
    end
    if profile_params[:last_name]
      user.update( last_name: profile_params[:last_name] )
    end
  end

  def update_misc_info ( user, profile_params )
    if profile_params[:code]
      if InvitationCode.find_by_user_id( user.id )
        InvitationCode.find_by_user_id( user.id ).update(code: profile_params[:code] )
      else
        InvitationCode.create( user_id: user.id, used: false, code: profile_params[:code] )
      end
    end
    if profile_params[:has_idea] == '1'
      if ProfileIdea.find_by_user_id( user.id ) == nil
        ProfileIdea.create( user_id: user.id )
      end
    end
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[first second third fourth]
    # %w[first second fourth]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

end
