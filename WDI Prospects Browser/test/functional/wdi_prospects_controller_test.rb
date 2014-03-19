require 'test_helper'

class WdiProspectsControllerTest < ActionController::TestCase
  setup do
    @wdi_prospect = wdi_prospects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wdi_prospects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wdi_prospect" do
    assert_difference('WdiProspect.count') do
      post :create, wdi_prospect: { address: @wdi_prospect.address, asset_amount: @wdi_prospect.asset_amount, city: @wdi_prospect.city, e_i_n: @wdi_prospect.e_i_n, form_990_revenue_amount: @wdi_prospect.form_990_revenue_amount, in_care_of_name: @wdi_prospect.in_care_of_name, income_amount: @wdi_prospect.income_amount, name: @wdi_prospect.name, ntee_code: @wdi_prospect.ntee_code, sort_or_secondary_name: @wdi_prospect.sort_or_secondary_name, state: @wdi_prospect.state, zip_code: @wdi_prospect.zip_code }
    end

    assert_redirected_to wdi_prospect_path(assigns(:wdi_prospect))
  end

  test "should show wdi_prospect" do
    get :show, id: @wdi_prospect
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wdi_prospect
    assert_response :success
  end

  test "should update wdi_prospect" do
    put :update, id: @wdi_prospect, wdi_prospect: { address: @wdi_prospect.address, asset_amount: @wdi_prospect.asset_amount, city: @wdi_prospect.city, e_i_n: @wdi_prospect.e_i_n, form_990_revenue_amount: @wdi_prospect.form_990_revenue_amount, in_care_of_name: @wdi_prospect.in_care_of_name, income_amount: @wdi_prospect.income_amount, name: @wdi_prospect.name, ntee_code: @wdi_prospect.ntee_code, sort_or_secondary_name: @wdi_prospect.sort_or_secondary_name, state: @wdi_prospect.state, zip_code: @wdi_prospect.zip_code }
    assert_redirected_to wdi_prospect_path(assigns(:wdi_prospect))
  end

  test "should destroy wdi_prospect" do
    assert_difference('WdiProspect.count', -1) do
      delete :destroy, id: @wdi_prospect
    end

    assert_redirected_to wdi_prospects_path
  end
end
