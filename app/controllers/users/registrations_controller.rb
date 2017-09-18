class Users::RegistrationsController  < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  def edit
    @page_title = "マイページ"
  end
end
