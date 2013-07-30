require 'spec_helper'

describe UsersController do
  login_user

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  it "should get index" do
    # Note, erails 3.x scaffolding may add lines like get :index, {}, valid_session
    # the valid_session overrides the devise login. Remove the valid_session from your specs
    get 'index'
    response.should be_success
  end

  it "should not get index" do
    subject.current_user.destroy
    get 'index'
    response.should_not be_success
  end
end