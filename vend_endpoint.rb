class VendEndpoint < EndpointBase::Sinatra::Base
  post '/add_product' do
    ap @config

    product = @payload['product']
    out = {
      source_id: product[:parent_id],
      source_variant_id: product[:id],
      handle: product[:permalink],
      type: 'Spree Product',
      name: product[:name],
      description: product[:description],
      tags: product[:meta_keywords],
      sku: product[:sku],
      # variant_parent_id: product.master.vend_id,
      supply_price: product[:cost_price],
      retail_price: product[:price]
    }

    unless product[:options].blank?
      out[:variant_option_one_name]   = product[:options].keys.first
      out[:variant_option_one_value]  = product[:options].values.first
      out[:name] << " - " + out[:variant_option_one_value]
    end

    vend =       Vend::Client.new(
        'reformation',
        'spree',
        'spreevend8942')

    resp = vend.request('products', method: :post, body: out.to_json)

    ap resp
    # # Return an order object.
    # add_object :vend_product, resp

    # # # Create or update the parameter sample.new.
    # add_parameter 'sample.new', 'butts'

    # # # Set the notification summary.
    set_summary 'The product was imported correctly'

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
