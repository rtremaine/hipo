require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user 
    #sign_out @user 

    @company = companies(:one)
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
    sign_out @user
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
    sign_out @user
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: Company.new(:name => 'name').attributes
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    sign_in @user
    get :show, id: @company
    assert_response :success
    sign_out @user
  end

  test "should get edit" do
    sign_in @user 
    get :edit, id: @company
    sign_out @user 
    assert_response :success
  end

  test "should update company" do
    sign_in @user 
    put :update, id: @company, company: @company.attributes
    sign_out @user 
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      sign_in @user 
      delete :destroy, id: @company
      sign_out @user 
    end

    assert_redirected_to companies_path
  end
end
