module Bluedart
  class Shipment < Base
    def initialize(details)
      @shipper = shipper_hash(details[:shipper_details])
      @consignee = consignee_hash(details[:consignee_details])
      @services = services_hash(details[:services])
      @profile = profile_hash({api_type: 'S', version: '1.3'}, details[:creds])
      @mode = details[:mode]
    end

    def request_url
      if @mode == 'prod'
        'https://netconnect.bluedart.com/Ver1.7/ShippingAPI/WayBill/WayBillGeneration.svc'
      else
        'http://netconnect.bluedart.com/Ver1.7/Demo/ShippingAPI/WayBill/WayBillGeneration.svc'
      end
    end

    def response
      wsa = 'http://tempuri.org/IWayBillGeneration/GenerateWayBill'
      # TODO: ITS A HACK NEEDS TO BE REMOVED
      # TODO: NEED TO REWRITE TO USE NAMESPACES DEFINED IN NAMESPACES FUNCTION
      params = {'Request' => {'ns4:Consignee' => @consignee, 'ns4:Services' => @services, 'ns4:Shipper' => @shipper}}
      opts = {message: 'GenerateWayBill', wsa: wsa, params: params, extra: {'Profile' => @profile}, url: request_url}
      make_request(opts)
    end

    private
    def shipper_hash(details)
      params = {}
      address_array = multi_line_address(details[:address], 30)
      params['CustomerAddress1'] = self.client.address_line_1
      params['CustomerAddress2'] = self.client.address_line_2
      params['CustomerAddress3'] = address_array[2]
      params['CustomerCode'] = details[:customer_code]
      params['CustomerEmailID'] = self.client.email
      params['CustomerMobile'] = self.client.phone_primary
      params['CustomerName'] = self.client.name
      params['CustomerPincode'] = self.client.pincode
      params['CustomerTelephone'] = self.client.phone_secondary
      params['isToPayCustomer'] = details[:isToPayCustomer]
      params['OriginArea'] = 'MAA'
      params['Sender'] = 'Gehna'
      params['VendorCode'] = details[:vendor_code]
      params
    end

    def consignee_hash(details)
      params = {}
      address_array = multi_line_address(details[:address], 30)
      params['ConsigneeAddress1'] = address_array[0]
      params['ConsigneeAddress2'] = address_array[1]
      params['ConsigneeAddress3'] = address_array[2]
      params['ConsigneeAttention'] = details[:consignee_attention]
      params['ConsigneeMobile'] = details[:consignee_mobile]
      params['ConsigneeName'] = details[:consignee_name]
      params['ConsigneePincode'] = details[:consignee_pincode]
      params['ConsigneeTelephone'] = details[:consignee_telephone]
      params
    end

    def services_hash(details)
      params = {}
      params['AWBNo'] = details[:awb_no]
      params['ActualWeight'] = details[:actual_weight]
      params['CollectableAmount'] = details[:collectable_amount]
      params['Commodity'] = commodites_hash(details[:commodities])
      params['CreditReferenceNo'] = details[:credit_reference_no]
      params['CustomerEDD'] = details[:customer_edd]
      params['DeclaredValue'] = details[:declared_value]
      params['DeliveryTimeSlot'] = details[:delivery_time_slot]
      params['Dimensions'] = details[:diemensions]
      params['InvoiceNo'] = details[:invoice_no]
      params['IsDedicatedDeliveryNetwork'] = details[:is_dedicated_delivery_network]
      params['IsForcePickup'] = details[:is_force_pickup]
      params['IsReversePickup'] = details[:is_reverse_pickup]
      params['PDFOutputNotRequired'] = details[:p_d_f_output_not_required]
      params['PackType'] = details[:pack_type]
      params['ParcelShopCode'] = details[:parcel_shop_code]
      params['PickupDate'] = details[:pickup_date]
      params['PickupTime'] = details[:pickup_time]
      params['PieceCount'] = details[:piece_count]
      params['ProductCode'] = details[:product_code]
      params['ProductType'] = details[:product_type]
      params['RegisterPickup'] = details[:register_pickup]
      params['SpecialInstruction'] = details[:special_instruction]
      params['SubProductCode'] = details[:sub_product_code]

      params
    end

    def dimensions_hash(details)
      params = []
      details.each do |d|
        params << {'Dimension' => {'Breadth' => d[:breadth], 'Height' => d[:height], 'Length' => d[:length], 'Count' => d[:count]} }
      end
      params
    end

    def commodites_hash(details)
      params = {}
      details.each_with_index {|d, i| params["CommodityDetail#{i+1}"] = d}
      params
    end
  end
end
