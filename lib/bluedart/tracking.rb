require 'httparty'
require 'nori'

module Bluedart
  class Tracking
    attr_reader :response

    def initialize(details)
      @numbers = details[:numbers].join(',')
      @scans = details[:scans]
      @license_key = details[:creds][:license_key]
      @loginid = details[:creds][:login_id]
    end

    def self.request_url
      'https://api.bluedart.com/servlet/RoutingServlet'
    end

    def request
      @response = make_request
    end

    private
    def make_request
      params = {handler: 'tnt', action: 'custawbquery', loginid: @loginid,
        awb: 'awb', numbers: @numbers, lickey: @license_key,
        verno: 1.3, scan: @scans
      }
      # https://api.bluedart.com/servlet/RoutingServlet?handler=tnt&action=custawbquery&loginid=MAA03006&format=xml&lickey=a065857670c55945e8191e295fbdc980&verno=1.3&scan=1&awb=awb&numbers=59654933461
      request = HTTParty.get(Tracking.request_url, query: params, verify: false)
      response_return(request.body)
    end

    def response_return(xml)
      nori = Nori.new(strip_namespaces: true)
      xml_hash = nori.parse(xml)
      # TODO need to implement error block
      response_hash = {error: false, error_text: ''}
      response_hash[:results] = xml_hash['ShipmentData']['Shipment']
      if response_hash[:results].is_a?(Hash)
        response_hash[:results] = [response_hash[:results]]
      end
      response_hash
    end
  end
end
