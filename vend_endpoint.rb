class VendEndpoint < EndpointBase::Sinatra::Base
  set :logging, true

  post '/sample' do
    # Return an order object.
    add_object :order, { id: 1, email: 'test@example.com' }

    # Create or update the parameter sample.new.
    add_parameter 'sample.new', 'butts'

    # Set the notification summary.
    set_summary 'The order was imported correctly'

    # Return a customized key and value.
    add_value 'my_customized_key', { butt:'trucks' }

    #return the relevant HTTP status code
    process_result 200
  end

  post '/fail' do
    # Set the notification summary.
    set_summary 'The order failed to imported'

    #return the relevant HTTP status code
    process_result 500
  end
end
