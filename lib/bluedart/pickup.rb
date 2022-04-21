module Bluedart
  class Pickup < Base
    def initialize(details)
      @pickup_registration_request = pickup_registration_request_hash(details[:pickup_request])
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
      wsa = 'http://tempuri.org/IPickupRegistration/RegisterPickup'
      params = { 'request' => @pickup_registration_request }
      opts = { message: 'RegisterPickup', wsa: wsa, params: params, extra: { 'profile' => @profile }, url: request_url }
      make_request(opts)
    end

    private

    def pickup_registration_request_hash(details)
      params = {}
      params["ns5:AreaCode"] = details[:area_code]
      params["ns5:ContactPersonName"] = details[:contact_person_name]
      params["ns5:CustomerAddress1"] = details[:customer_address1]
      params["ns5:CustomerAddress2"] = details[:customer_address2]
      params["ns5:CustomerAddress3"] = details[:customer_address3]
      params["ns5:CustomerCode"] = details[:customer_code]
      params["ns5:CustomerName"] = details[:customer_name]
      params["ns5:CustomerPincode"] = details[:customer_pincode]
      params["ns5:CustomerTelephoneNumber"] = details[:customer_telephone_number]
      params["ns5:MobileTelNo"] = details[:mobile_tel_no]
      params["ns5:NumberofPieces"] = details[:number_of_pieces]
      params["ns5:OfficeCloseTime"] = details[:office_close_time]
      params["ns5:ProductCode"] = details[:product_code]
      params["ns5:ReferenceNo"] = details[:reference_no]
      params["ns5:ShipmentPickupDate"] = details[:shipment_pickup_date]
      params["ns5:ShipmentPickupTime"] = details[:shipment_pickup_time]
      params["ns5:SubProducts"] = details[:sub_products] || []
      params["ns5:VolumeWeight"] = details[:volume_weight]
      params["ns5:WeightofShipment"] = details[:weight_of_shipment]
      params["ns5:isToPayShipper"] = details[:is_to_pay_shipper] || false
      params["ns5:AWBNo"] = details[:awb_no]
      params["ns5:Remarks"] = details[:remarks]
      params["ns5:RouteCode"] = details[:route_code]
      params["ns5:EmailID"] = details[:email_id]
      params["ns5:DoxNDox"] = details[:dox_n_dox]
      params["ns5:IsReversePickup"] = details[:is_reverse_pickup]
      params["ns5:IsForcePickup"] = details[:is_force_pickup]
      params["ns5:PackType"] = details[:pack_type]
      params["ns5:IsDDN"] = details[:is_ddn] || false
      params
    end
  end
end
