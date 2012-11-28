# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do

  before do
  	@user = User.new(name: "Example User",
  							     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  subject { @user }
  
  it {should respond_to :name }
  it {should respond_to :email }
  it {should respond_to :password_digest }
  it {should respond_to :password }
  it {should respond_to :password_confirmation }
  it {should respond_to :authenticate }
  it {should respond_to :remember_token }


  describe "when attributes are valid" do
  	it {should be_valid}
  	it "should be have valid email format" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      	addresses.each do |valid_address|
      		@user.email = valid_address
      		@user.should be_valid
      	end
  	end
  end

  describe "when attributes not valid" do
  	it "should fail when no name given" do
		  @user.name = " "
		  should_not be_valid
	  end
  	it "should fails when no email given" do
  		@user.email = ' '
  		should_not be_valid
  	end
  	it "should fail when name too long" do
  		@user.name = "a" * 51
  		should_not be_valid
  	end
  	it "should fail for invalid email format" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
      	addresses.each do |invalid_address|
      		@user.email = invalid_address
      		should_not be_valid
      	end
    end
    it "should fail when email already taken" do
    	#before do
    	user_with_same_email = @user.dup
    	user_with_same_email.email = @user.email.upcase
    	user_with_same_email.save
    	#end

    	should_not be_valid
    end
  end


  describe "password tests" do
    it "should fail when password is blank" do
      @user.password = @user.password_confirmation = ''
      should_not be_valid
    end
    it "should fail when passwords do not match" do
      @user.password_confirmation = "mismatch pwd"
      should_not be_valid
    end
    it "should fail when password confirmation is nil" do
      @user.password_confirmation = nil
      should_not be_valid
    end

    describe "with a password that's too short" do
      before do
        @user.password = @user.password_confirmation = "a" * 5
      end

      it { should be_invalid }
    end
  end


  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) {User.find_by_email @user.email}

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password){ found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }    
    end
  end

  describe "remember token" do
    before { @user.save }
    its (:remember_token) { should_not be_blank }
  end



  #pending "add some examples to (or delete) #{__FILE__}"
end
