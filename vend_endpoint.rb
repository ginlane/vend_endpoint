class VendEndpoint < EndpointBase::Sinatra::Base
  endpoint_key '5329f763b439577c52013fd0'
  
  def vend 
    username = @config[:vend1]
    @vend ||= Vend::Client.new('reformation','spree','spreevend8942')
  end


  post '/add_product' do
    product = @payload['product']

    # if product[:parent_id]
    #   vend_products = vend.Products.all

    #   match = vend_products.find{|p|p.variant_}
    # end

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
