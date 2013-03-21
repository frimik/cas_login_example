class UnsecuredController < ApplicationController

  def login_required?
    false
  end
end
