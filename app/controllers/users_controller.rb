class UsersController < ApplicationController
  def update
    info = { alert: t('.error') }
    # update user object
    info = { notice: t('.updated') } if current_user.update(user_params)
    # redirect with info or error message
    redirect_to(edit_user_registration_path, info)
  end

  def destroy
    current_user.destroy!
    redirect_to(landing_root_path, notice: t('.deleted'))
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
