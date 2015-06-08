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
      'http://www.bluedart.com/servlet/RoutingServlet'
    end

    def request
      @response = make_request
    end

    private
    def make_request
      params = {handler: 'tnt', action: 'custawbquery', loginid: @loginid,
        awb: 'awb', numbers: @numbers, lickey: @license_key,
        verno: 1, scan: @scans
      }
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