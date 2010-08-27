require 'test_helper'

class ManufacturersControllerTest < ActionController::TestCase

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
      should_assign_to :manufacturers
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end


    context "GET to :show" do
      setup do
        get :show, :id => Factory.create(:manufacturer)
      end
      should_assign_to :manufacturer
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end


    context "GET to :new" do
      setup do
        get :new
      end
      should_assign_to :manufacturer
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
    end


    context "POST to :create" do
      context "when model is invalid" do
        setup do
          Manufacturer.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_assign_to :manufacturer
        should_respond_with :success
        should_render_template :new
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          Manufacturer.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_assign_to :manufacturer
        should_redirect_to("manufacturers page") {manufacturers_url}
        should_set_the_flash_to "Successfully created manufacturer."
      end
    end


    context "GET to :edit" do
      setup do
        get :edit, :id => Factory.create(:manufacturer)
      end
      should_assign_to :manufacturer
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end


    context "PUT to :update" do
      context "when model is invalid" do
        setup do
          manufacturer = Factory.create(:manufacturer)
          Manufacturer.any_instance.stubs(:valid?).returns(false)
          put :update, :id => manufacturer
        end
        should_assign_to :manufacturer
        should_respond_with :success
        should_render_template :edit
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          manufacturer = Factory.create(:manufacturer)
          Manufacturer.any_instance.stubs(:valid?).returns(true)
          put :update, :id => manufacturer
        end
        should_assign_to :manufacturer
        should_redirect_to("manufacturers page") {manufacturers_url}
        should_set_the_flash_to "Successfully updated manufacturer."
      end
    end


    context "DELETE to :destroy" do
      setup do
        @manufacturer = Factory.create(:manufacturer)
        delete :destroy, :id => @manufacturer
      end
      should_redirect_to ("manufacturers index") {manufacturers_url}
      should "destroy model" do
        assert !Manufacturer.exists?(@manufacturer.id)
      end
    end

  end
end

