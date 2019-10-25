module Bluedart
  class AllProductAndSubProductCode < Base
    def initialize(details)
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'https://netconnect.bluedart.com/Ver1.8/ShippingAPI/Pickup/PickupRegistrationService.svc'
      else
        'https://netconnect.bluedart.com/Ver1.8/Demo/ShippingAPI/Pickup/PickupRegistrationService.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IServiceFinderQuery/GetAllProductsAndSubProducts'
      opts = {message: 'GetAllProductsAndSubProducts', params: {}, extra: {'profile' => @profile}, url: request_url}
      make_request(opts)
    end
  end
end
