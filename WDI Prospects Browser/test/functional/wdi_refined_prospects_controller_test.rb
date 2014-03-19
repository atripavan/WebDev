require 'test_helper'

class WdiRefinedProspectsControllerTest < ActionController::TestCase
  setup do
    @wdi_refined_prospect = wdi_refined_prospects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wdi_refined_prospects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wdi_refined_prospect" do
    assert_difference('WdiRefinedProspect.count') do
      post :create, wdi_refined_prospect: { address: @wdi_refined_prospect.address, city: @wdi_refined_prospect.city, e_i_n: @wdi_refined_prospect.e_i_n, email: @wdi_refined_prospect.email, first_name: @wdi_refined_prospect.first_name, has_donation_button: @wdi_refined_prospect.has_donation_button, income_amount: @wdi_refined_prospect.income_amount, last_name: @wdi_refined_prospect.last_name, name: @wdi_refined_prospect.name, state: @wdi_refined_prospect.state, title: @wdi_refined_prospect.title, website: @wdi_refined_prospect.website }
    end

    assert_redirected_to wdi_refined_prospect_path(assigns(:wdi_refined_prospect))
  end

  test "should show wdi_refined_prospect" do
    get :show, id: @wdi_refined_prospect
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wdi_refined_prospect
    assert_response :success
  end

  test "should update wdi_refined_prospect" do
    put :update, id: @wdi_refined_prospect, wdi_refined_prospect: { address: @wdi_refined_prospect.address, city: @wdi_refined_prospect.city, e_i_n: @wdi_refined_prospect.e_i_n, email: @wdi_refined_prospect.email, first_name: @wdi_refined_prospect.first_name, has_donation_button: @wdi_refined_prospect.has_donation_button, income_amount: @wdi_refined_prospect.income_amount, last_name: @wdi_refined_prospect.last_name, name: @wdi_refined_prospect.name, state: @wdi_refined_prospect.state, title: @wdi_refined_prospect.title, website: @wdi_refined_prospect.website }
    assert_redirected_to wdi_refined_prospect_path(assigns(:wdi_refined_prospect))
  end

  test "should destroy wdi_refined_prospect" do
    assert_difference('WdiRefinedProspect.count', -1) do
      delete :destroy, id: @wdi_refined_prospect
    end

    assert_redirected_to wdi_refined_prospects_path
  end
end
