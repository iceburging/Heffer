require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

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
      should_assign_to :photos
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end


    context "GET to :show" do
      setup do
        get :show, :id => Photo.first
      end
      should_assign_to :photo
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end


    context "GET to :new" do
      setup do
        get :new
      end
      should_assign_to :photo
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
    end


    context "POST to :create" do
      context "when model is invalid" do
        setup do
          Photo.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_assign_to :photo
        should_respond_with :success
        should_render_template :new
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          Photo.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_assign_to :photo
        should_redirect_to("show photo page") {photos_path}
        should_set_the_flash_to "Successfully added photo."
      end
    end


    context "GET to :edit" do
      setup do
        get :edit, :id => Photo.first
      end
      should_assign_to :photo
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end


    context "PUT to :update" do
      context "when model is invalid" do
        setup do
          photo = Photo.first
          Photo.any_instance.stubs(:valid?).returns(false)
          put :update, :id => photo
        end
        should_assign_to :photo
        should_respond_with :success
        should_render_template :edit
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          photo = Photo.first
          Photo.any_instance.stubs(:valid?).returns(true)
          put :update, :id => photo
        end
        should_assign_to :photo
        should_redirect_to("show photos page") {photos_path}
        should_set_the_flash_to "Successfully updated photo."
      end
    end


    context "DELETE to :destroy" do
      setup do
        @photo = Photo.first
        delete :destroy, :id => @photo
      end
      should_redirect_to ("photos index") {photos_url}
      should "destroy model" do
        assert !Photo.exists?(@photo.id)
      end
    end

  end
end

