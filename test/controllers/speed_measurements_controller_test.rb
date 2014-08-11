require 'test_helper'

class SpeedMeasurementsControllerTest < ActionController::TestCase
  setup do
    @speed_measurement = speed_measurements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:speed_measurements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create speed_measurement" do
    assert_difference('SpeedMeasurement.count') do
      post :create, speed_measurement: { down: @speed_measurement.down, up: @speed_measurement.up }
    end

    assert_redirected_to speed_measurement_path(assigns(:speed_measurement))
  end

  test "should show speed_measurement" do
    get :show, id: @speed_measurement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @speed_measurement
    assert_response :success
  end

  test "should update speed_measurement" do
    patch :update, id: @speed_measurement, speed_measurement: { down: @speed_measurement.down, up: @speed_measurement.up }
    assert_redirected_to speed_measurement_path(assigns(:speed_measurement))
  end

  test "should destroy speed_measurement" do
    assert_difference('SpeedMeasurement.count', -1) do
      delete :destroy, id: @speed_measurement
    end

    assert_redirected_to speed_measurements_path
  end
end
