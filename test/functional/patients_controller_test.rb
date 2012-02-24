require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    #sign_in @user 
    #sign_out @user 
    @patient = patients(:one)
  end

  test "should get index" do
    sign_in @user 
    get :index
    assert_response :success
    assert_not_nil assigns(:patients)
    sign_out @user
  end

  test "should get new" do
    sign_in @user 
    get :new
    assert_response :success
    sign_out @user
  end

  test "should create patient" do
    assert_difference('Patient.count') do
      sign_in @user
      post :create, patient: @patient.attributes
    end

    assert_redirected_to patient_path(assigns(:patient))
    sign_out @user
  end

  test "should show patient" do
    sign_in @user 
    get :show, id: @patient
    assert_response :success
    sign_out @user
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @patient
    assert_response :success
    sign_out @user
  end

  test "should update patient" do
    sign_in @user
    put :update, id: @patient, patient: @patient.attributes
    assert_redirected_to patient_path(assigns(:patient))
    sign_out @user
  end

  test "should destroy patient" do
    sign_in @user
    assert_difference('Patient.count', -1) do
      delete :destroy, id: @patient
    end

    assert_redirected_to patients_path
    sign_out @user
  end
end
