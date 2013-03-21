class SecuredController < ApplicationController
  def login_required?
    true
  end
end
