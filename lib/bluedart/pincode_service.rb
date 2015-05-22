module Bluedart
  class PincodeService < Base
    def initialize(details)
      @pincode = details[:pincode]
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'http://netconnect.bluedart.com/ShippingAPI/Finder/ServiceFinderQuery.svc'
      else
        'http://netconnect.bluedart.com/Demo/ShippingAPI/Finder/ServiceFinderQuery.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IServiceFinderQuery/GetServicesforPincode'
      opts = {message: 'GetServicesforPincode', wsa: wsa, params: {pinCode: @pincode}, extra: {'profile' => @profile}, url: request_url}
      make_request(opts)
    end
  end
end
