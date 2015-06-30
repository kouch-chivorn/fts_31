require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  before :each do
    signin_admin
    @category = FactoryGirl.build :category
  end

  describe "GET :index" do
    context "user not signed in" do
      it "should response to Admin sign in page" do
        sign_out :admin
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context "user signed in as admin" do
      it "should response to show all categories" do
        get :index
        expect(response).to render_template "index"
      end
    end
  end

  describe "GET :new" do
    context "user not sign in" do
      it "should response to Admin sign in page" do
        sign_out :admin
        get :new
        expect(response).to redirect_to new_admin_session_path
      end
    end
    context "user sign in" do
      it "should response to new category page if Admin signed in" do
        get :new
        expect(response).to render_template "new"
      end
    end
  end

  describe "POST :create" do
    context "user not signed in" do
      it "should response to Admin sign in page if user not sign in" do
        sign_out :admin
        post :create, admin_id: @admin.id
        expect(response).to redirect_to new_admin_session_path
      end
    end
    context "user has already signed in" do
      it "should response to render new template if create fail" do
        @category.duration = -1
        post :create, admin_id: @admin.id,
          category: @category.attributes.except("id")
        expect(response).to render_template "new"
        expect(flash[:danger]).to be_present
      end

      it "should response to category index after save is success" do
        post :create, admin_id: @admin.id,
          category: @category.attributes.except("id")
        expect(response).to redirect_to admin_categories_path
        expect(flash[:success]).to be_present
      end
    end
  end

  describe "GET :show" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      @category.save
      get :show, admin_id: @admin.id, id: @category.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to category info detail" do
      @category.save
      get :show, admin_id: @admin.id, id: @category.id
      expect(response).to render_template "show"
    end
  end

  describe "GET #edit" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      @category.save
      get :edit, admin_id: @admin.id, id: @category.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response shop fill for update category info" do
      @category.save
      get :edit, admin_id: @admin.id, id: @category.id
      expect(response).to render_template "edit"
    end
  end

  describe "PATCH :update" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      @category.save
      patch :update, admin_id: @admin.id, id: @category.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to show edit template if update fail" do
      @category.save
      @category.duration ="wer"
      patch :update, admin_id: @admin.id, id: @category.id,
        category: @category.attributes.except("id")
      expect(response).to render_template "edit"
      expect(flash[:danger]).to be_present
    end

    it "should response to show all category when update success" do
      @category.save
      @category.duration ="30"
      patch :update, admin_id: @admin.id, id: @category.id,
        category: @category.attributes.except("id")
      expect(response).to redirect_to admin_categories_path
      expect(flash[:success]).to be_present
    end
  end

  describe "DELETE :destroy" do
    it "should response to Admin sign in page if user not sign in" do
      sign_out :admin
      @category.save
      delete :destroy, admin_id: @admin.id, id: @category.id
      expect(response).to redirect_to new_admin_session_path
    end

    it "should response to show all category after delete success" do
      @category.save
      delete :destroy, admin_id: @admin.id, id: @category.id
      expect(flash[:notice]).to eq t "category.message.deleted"
      expect(response).to redirect_to admin_categories_path
    end
  end
end
