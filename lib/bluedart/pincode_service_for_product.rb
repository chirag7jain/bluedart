module Bluedart
  class PincodeServiceForProduct < Base
    def initialize(details)
      @pincode = details[:pincode]
      @product_code = details[:product_code]
      @sub_product_code = details[:sub_product_code]
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'http://netconnect.bluedart.com/Ver1.8/ShippingAPI/Finder/ServiceFinderQuery.svc'
      else
        'http://netconnect.bluedart.com/Ver1.8/Demo/ShippingAPI/Finder/ServiceFinderQuery.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IServiceFinderQuery/GetServicesforProduct'
      opts = {message: 'GetServicesforProduct', wsa: wsa, params: {pinCode: @pincode, pProductCode: @product_code, pSubProductCode: @sub_product_code}, extra: {'profile' => @profile}, url: request_url}
      make_request(opts)
    end
  end
end
