require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  test 'returns all appointments' do
    get :index
    assert_equal response.body, [appointments(:one), appointments(:two)].to_json
  end

  test 'returns subset within given range' do
    get :index, start_time: '2014-03-19 00:00', end_time: '2014-03-20 00:00'
    assert_equal response.body, [appointments(:two)].to_json
  end

  test 'creates an appointment' do
    assert_difference 'Appointment.count' do
      post :create, {
        start_time: '2015-01-01 10:10',
        end_time: '2015-01-01 10:20',
        first_name: 'Joshua',
        last_name: 'Toyota',
      }
    end
  end

  test 'errors if times overlap' do
    Appointment.create(
      start_time: '2015-01-01 10:10',
      end_time: '2015-01-01 10:20',
      first_name: 'Joshua',
      last_name: 'Toyota',
    )
    post :create, {
      start_time: '2015-01-01 10:10',
      end_time: '2015-01-01 10:20',
      first_name: 'Someone',
      last_name: 'Else',
    }
    assert_response 400
  end

  test 'updates successfully' do
    appointment = Appointment.create(
      start_time: '2015-01-01 10:10',
      end_time: '2015-01-01 10:20',
      first_name: 'Joshua',
      last_name: 'Toyota',
    )
    post :update, {
      id: appointment.id,
      start_time: '2015-01-01 10:10',
      end_time: '2015-01-01 10:20',
      first_name: 'Someone',
      last_name: 'Else',
    }
    assert_response :success
  end

  test 'deletes successfully' do
    appointment = Appointment.create(
      start_time: '2015-01-01 10:10',
      end_time: '2015-01-01 10:20',
      first_name: 'Joshua',
      last_name: 'Toyota',
    )
    post :destroy, {
      id: appointment.id,
    }
    assert_response :success
  end

  test 'errors when appointment not found' do
    post :destroy, { id: -1, }
    assert_response 400
  end
end
