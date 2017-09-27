class Users::RegistrationsController  < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def edit
    @page_title = "マイページ(修正)"
  end

  protected

  def after_update_path_for(resource)
    top_path
  end
end
