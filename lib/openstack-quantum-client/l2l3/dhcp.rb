# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class Dhcp < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(name, address)
        full_url = "#{quantum_url}/dhcps.json"
        post_to_quantum(
          full_url,
          {"dhcp" => {"name" => name, "address" => address}}
        )
      end

      def reload(id)
        HTTParty.put("#{@quantum_url}/dhcps/#{id}/reload.json")
      end

      def list
        full_url = "#{quantum_url}/dhcps.json"
        response = HTTParty.get(full_url)
        JSON.parse(response.body)["dhcps"] if response
      end
    end
  end
end
