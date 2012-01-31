# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class Dhcp < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/dhcps.json"
      end

      def create(name, address)
        post_to_quantum(
          @quantum_url,
          {"dhcp" => {"name" => name, "address" => address}}
        )
      end

      def list
        response = HTTParty.get(@quantum_url)
        JSON.parse(response.body)["dhcps"] if response
      end
    end
  end
end
