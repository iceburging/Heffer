require 'test_helper'

class ProductLinesControllerTest < ActionController::TestCase

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
      should_assign_to :product_lines
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end


    context "GET to :show" do
      setup do
        get :show, :id => Factory.create(:product_line)
      end
      should_assign_to :product_line
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end


    context "GET to :new" do
      setup do
        get :new
      end
      should_assign_to :product_line
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
    end


    context "POST to :create" do
      context "with add options button" do
        context "and a set of generator options" do
          setup do
            post :create, {:product_line => Factory.attributes_for(:product_line), :commit => 'Add Options', :generator => {'price' => '5.99', 'size_a' => '32 34', 'size_b' => 'A B', 'colour' => 'White Black'} }
          end
          should_assign_to :product_line
          should_respond_with :success
          should_render_template :new
          should_set_the_flash_to "New options added."
          should "return eight options" do
            assert_equal 8, assigns(:product_line).options.length
            assigns(:product_line).options.each {|o| assert_instance_of Option, o}
          end
        end
        context "and a partial set of generator options" do
          setup do
            post :create, {:product_line => Factory.attributes_for(:product_line), :commit => 'Add Options', :generator => {'price' => '5.99', 'size_a' => '32 34', 'colour' => 'White Black'} }
          end
          should_assign_to :product_line
          should_respond_with :success
          should_render_template :new
          should_set_the_flash_to "New options added."
          should "return four options" do
            assert_equal 4, assigns(:product_line).options.length
            assigns(:product_line).options.each {|o| assert_instance_of Option, o}
          end
        end
      end
      context "with replace options button" do
        context "and a set of generator options" do
          setup do
            post :create, {:product_line => Factory.attributes_for(:product_line), :commit => 'Replace Options', :generator => {'price' => '5.99', 'size_a' => '32 34', 'size_b' => 'A B', 'colour' => 'White Black'} }
          end
          should_assign_to :product_line
          should_respond_with :success
          should_render_template :new
          should_set_the_flash_to "Options ammended."
          should "return eight options" do
            assert_equal 8, assigns(:product_line).options.length
            assigns(:product_line).options.each {|o| assert_instance_of Option, o}
          end
        end
      end
      context "with commit button when model is invalid" do
        setup do
          ProductLine.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_assign_to :product_line
        should_respond_with :success
        should_render_template :new
        should_not_set_the_flash
      end
      context "with commit button when model is vaild" do
        setup do
          ProductLine.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_assign_to :product_line
        should_redirect_to("product_lines page") {product_lines_url}
        should_set_the_flash_to "Successfully created product line."
      end
    end


    context "GET to :edit" do
      setup do
        get :edit, :id => Factory.create(:product_line)
      end
      should_assign_to :product_line
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end


    context "PUT to :update" do
      context "when model is invalid" do
        setup do
          product_line = Factory.create(:product_line)
          ProductLine.any_instance.stubs(:valid?).returns(false)
          put :update, :id => product_line
        end
        should_assign_to :product_line
        should_respond_with :success
        should_render_template :edit
        should_not_set_the_flash
      end
      context "when model is vaild" do
        setup do
          product_line = Factory.create(:product_line)
          ProductLine.any_instance.stubs(:valid?).returns(true)
          put :update, :id => product_line
        end
        should_assign_to :product_line
        should_redirect_to("product_lines page") {product_lines_url}
        should_set_the_flash_to "Successfully updated product line."
      end
    end


    context "DELETE to :destroy" do
      setup do
        @product_line = Factory.create(:product_line)
        delete :destroy, :id => @product_line
      end
      should_redirect_to ("product_lines index") {product_lines_url}
      should "destroy model" do
        assert !ProductLine.exists?(@product_line.id)
      end
    end

  end
end

