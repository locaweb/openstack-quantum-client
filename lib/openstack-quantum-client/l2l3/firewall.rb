# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class Firewall < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/firewalls.json"
      end

      def create(name, address)
        post_to_quantum(
          @quantum_url,
          {"firewall" => {"name" => name, "address" => address}}
        )
      end

      def list
        response = HTTParty.get(@quantum_url)
        JSON.parse(response.body)["firewalls"] if response
      end
    end
  end
end
