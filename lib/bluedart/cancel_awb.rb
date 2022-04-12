module Bluedart
  class CancelAwb < Base
    def initialize(details)
      @awbno = details[:awbno]
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

     def request_url
      if @mode == 'prod'
        'https://netconnect.bluedart.com/Ver1.10/ShippingAPI/WayBill/WayBillGeneration.svc'
      else
        'https://netconnect.bluedart.com/Ver1.10/Demo/ShippingAPI/WayBill/WayBillGeneration.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IWayBillGeneration/CancelWaybill'
      params = {'Request' => {'ns4:AWBNo' => @awbno}}
      opts = {message: 'CancelWaybill', wsa: wsa, params: params, extra: {'Profile' => @profile}, url: request_url}
      make_request(opts)
    end
  end
end