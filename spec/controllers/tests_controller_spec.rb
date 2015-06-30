require "rails_helper"

describe TestsController do

  let(:test) {mock_model(Test)}
  before :each do
    @user = FactoryGirl.create :user, name: "Chivorn"
    sign_in :user, @user
    @category = FactoryGirl.create :category, name: "JAVA"
    @test = FactoryGirl.build :test, user: @user, category: @category
  end

  describe "GET index" do
    context "user not signed in" do
      it "should response to user sign in page" do
        sign_out :user
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      it "should create a new test object " do
        Test.stub(:new).and_return(test)
        Test.should_receive(:new)
        get :index
      end

      it "renders the index templeate" do
        get :index
        expect(response).to render_template("index")
      end

      it "loads all of the tests into @tests" do
        @test.save
        get :index
        expect(assigns(:tests)).to eq([@test])
      end
    end
  end

  describe "GET show/:id" do
    context "user not signed in" do
      it "should response to user sign in page" do
        sign_out :user
        @test.save
        get :show, id: @test.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      it "renders the index templeate" do
        @test.save
        get :show, id: @test.id
        expect(response).to render_template("show")
      end
    end
  end

  describe "POST create" do
    context "user not signed in" do
      it "should response to user sign in page" do
        sign_out :user
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      describe "creates a new test" do

        context "when the test saves successfully" do
          before {post :create, test: @test.attributes.except(:id)}
          it "should receive params[:test][:category_id]" do
            expect(controller.params[:test][:category_id]).not_to be_nil
          end

          it "sets a flash[:success] message" do
            expect(flash[:success]).to eq t("test.created")
          end

          it "redirects to the Tests index" do
            expect(response).to redirect_to tests_path category_id: controller.params[:test][:category_id]
            expect(@user.tests.count).to eq 1
          end
        end

        context "when the test fails to save" do
          it "redirects to the test page" do
            @test.category = nil
            post :create, test: @test.attributes.except(:id)
            expect(flash[:danger]).to eq t("test.failed")
            expect(response).to redirect_to tests_path category_id: controller.params[:test][:category_id]
            expect(@user.tests.count).to eq 0
          end
        end
      end
    end
  end

  describe "GET edit/:id" do
    context "user not signed in" do
      it "should response to user sign in page" do
        sign_out :user
        @test.save
        get :edit, id: @test.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      it "has no status 'View'" do
        @test.save
        get :edit,id: @test.id, status: Settings.status.start
        @test = @test.reload
        @time_left = @test.category.duration * 60 - (Time.zone.now - @test.started_time).to_i
        expect(@test.status).not_to eq Settings.status.start
        expect(@test.status).to eq Settings.status.testing
        expect(response).to render_template("edit")
      end

      it "when user is testing" do
        @test.status = Settings.status.testing
        @test.save
        get :edit, id: @test.id, status: Settings.status.testing
        @test = @test.reload
        @time_left = @test.category.duration * 60 - (Time.zone.now - @test.started_time).to_i
        expect(@time_left).to be > 0
      end

      context "has no time left" do
        it "has status equal to 'View'" do
          @test.status = Settings.status.view
          @test.save
          get :edit, id: @test.id, status: Settings.status.view
          @test = @test.reload
          expect(response).to redirect_to test_path @test
        end
      end
    end
  end

  describe "patch :update" do
    context "user not signed in" do
      it "should response to user sign in page" do
        sign_out :user
        @test.save
        patch :update,id: @test.id, test: @test.attributes.except(:id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      context "valid attributes" do
        before :each do
          @test.save
          patch :update, id: @test.id, test: @test.attributes.except(:id)
        end
        it "located the requested @test" do
          expect(assigns(:test)).to eq(@test)
        end

        it "changes @test's attributes" do
          @test.reload
          expect(@test.category.name).to eq "JAVA"
          expect(@test.user.name).to eq "Chivorn"
        end

        it "show flash[:success" do
          expect(flash[:success]).to eq t("flash.answer_update")
        end

        it "redirects to the updated test" do
          expect(response).to redirect_to test_path @test
        end
      end

      context "invalid attributes" do
        before :each do
          request.env["HTTP_REFERER"] = "/tests"
          @test.result = nil
          @test.save
          patch :update, id: @test.id, test: @test.attributes
        end

        it "located the requested @test" do
          expect(controller.params[:test][:test_questions_attributes]).to be_nil
          expect(assigns(:test)).to eq(@test)
        end

        it "does not change @test's attributes" do
          @test.reload
          expect(@test.test_questions[0]).to be_nil
          expect(@test.user.name).to eq "Chivorn"
        end

        it "show flash[:danger]" do
          @test.reload
          expect(flash[:danger]).to eq t("test.failed")
        end

        it "re-renders to the update method" do
          expect(response).to redirect_to("/tests")
        end
      end
    end
  end
end
