class Users::RegistrationsController < Devise::RegistrationsController
  
  # Device4.4.0のregistration_controllerのnewメソッドが
  # build_resource となっており、その影響で undefined method `[]=' for nil:NilClass
  # 修正のためにオーバーライド

  def new
    build_resource({})
    yield resource if block_given?
    respond_with resource    
  end

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def edit
    @page_title = "マイページ(修正)"
  end

  protected
  def after_update_path_for(resource)
    root_path
  end
end
