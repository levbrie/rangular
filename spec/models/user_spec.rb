require 'spec_helper'

describe User do
  before(:each) do
    @user_attrs = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "password55",
      :password_confirmation => "password55",
      :confirmed_at => Time.now
    }
  end

  it "should create a new user given a valid attribute" do
    User.create!(@user_attrs)
  end

  it "should require an email address" do
    blank_email_user = User.new(@user_attrs.merge(:email => ""))
    blank_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@user_attrs.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@user_attrs.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@user_attrs)
    user_with_duplicate_email = User.new(@user_attrs)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @user_attrs[:email].upcase
    User.create!(@user_attrs.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@user_attrs)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do
    it "should have a password and password_confirmation attributes" do
    	@user = User.new(@user_attrs)
      @user.should respond_to(:password)
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@user_attrs.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@user_attrs.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @user_attrs.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@user_attrs)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
  end
end
