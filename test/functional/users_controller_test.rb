require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context "when not logged in" do

    context "a GET request" do
      ['index','new'].each do |action|
        context "to #{action}" do
          setup do
            get action.to_sym
          end
          should_redirect_to("login page"){login_url}
        end
      end
    end

  end

  context "when logged in as admin" do

    setup do
      login_as_admin
    end

    context "GET to :index" do
      setup do
        get :index
      end
      should_assign_to :users
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end

    context "GET to :show" do
      setup do
        get :show, :id => Factory.create(:user)
      end
      should_assign_to :user
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end


    context "GET to :new" do
      setup do
        get :new
      end
      should_assign_to :user
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
    end


    context "POST to :create" do
      context "when model is invalid" do
        setup do
          User.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_assign_to :user
        should_respond_with :success
        should_render_template :new
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          User.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_assign_to :user
        should_redirect_to("users page") {users_url}
        should_set_the_flash_to "Successfully created user."
      end
    end


    context "GET to :edit" do
      setup do
        get :edit, :id => Factory.create(:user)
      end
      should_assign_to :user
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end


    context "PUT to :update" do
      context "when model is invalid" do
        setup do
          user = Factory.create(:user)
          User.any_instance.stubs(:valid?).returns(false)
          put :update, :id => user
        end
        should_assign_to :user
        should_respond_with :success
        should_render_template :edit
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          user = Factory.create(:user)
          User.any_instance.stubs(:valid?).returns(true)
          put :update, :id => user
        end
        should_assign_to :user
        should_redirect_to("users page") {users_url}
        should_set_the_flash_to "Successfully updated user."
      end
    end


    context "DELETE to :destroy" do
      setup do
        @user = Factory.create(:user)
        delete :destroy, :id => @user
      end
      should_redirect_to ("users index") {users_url}
      should "destroy model" do
        assert !User.exists?(@user.id)
      end
    end

  end
end

