module Bluedart
  class CancelPickup < Base
    def initialize(details)
      @cancel_pickup_request_details = cancel_pickup_request_hash(details[:cancel_pickup_request])
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'https://netconnect.bluedart.com/Ver1.10/ShippingAPI/Pickup/PickupRegistrationService.svc'
      else
        'https://netconnect.bluedart.com/Ver1.10/Demo/ShippingAPI/Pickup/PickupRegistrationService.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IPickupRegistration/CancelPickup'
      params = { 'request' => @cancel_pickup_request_details }
      opts = { message: 'CancelPickup', wsa: wsa, params: params, extra: { 'profile' => @profile }, url: request_url }
      make_request(opts)
    end

    private

    def cancel_pickup_request_hash(details)
      params = {}
      params["ns5:PickupRegistrationDate"] = details[:pickup_registration_date]
      params["ns5:Remarks"] = details[:remarks]
      params["ns5:TokenNumber"] = details[:token_number]
      params
    end
  end
end
