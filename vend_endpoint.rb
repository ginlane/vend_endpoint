class VendEndpoint < EndpointBase::Sinatra::Base
  post '/add_product' do

    product = @payload['product']
    ap product
    out = {
      source_id: product['parent_id'],
      source_variant_id: product['id'],
      handle: product['permalink'],
      type: 'Spree Product',
      name: product['name'],
      sku: product['sku'],
      # variant_parent_id: product.master.vend_id,
      variant_option_one_name: product['options'].keys.first,
      variant_option_one_value: product['options'].values.first,
      retail_price: product['price']
    }
    
    # if opt = option_values.find {|ov|ov.option_type.name == 'color'}
    #   out[:name] = "#{product.name} / #{opt.presentation}"
    # end


    # # Return an order object.
    add_object :product, out

    # # # Create or update the parameter sample.new.
    # add_parameter 'sample.new', 'butts'

    # # # Set the notification summary.
    # set_summary 'The order was imported correctly'

    # # # Return a customized key and value.
    # add_value 'my_customized_key', { butt:'trucks' }

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
