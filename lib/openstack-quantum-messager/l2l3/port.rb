# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class Port < L2l3
      def initialize(quantum_url, quantum_extension_url)
        @quantum_url = quantum_url
        @quantum_extension_url = quantum_extension_url
      end

      def create(network_id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports.json"
        post_to_quantum(full_url, nil)
      end

      def attach(network_id, id, interface_id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports/#{id}/attachment.json"
        response = put_to_quantum(full_url, {"attachment" => {"id" => interface_id}})
        response.code < 300
      end

      def list(network_id, filters={})
        HTTParty.get("#{@quantum_extension_url}/networks/#{network_id}/ports.json", :query => filters)
      end
    end
  end
end
