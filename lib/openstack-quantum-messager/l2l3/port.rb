# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class Port < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(network_id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports.json"
        post_to_quantum(full_url, nil)
      end

      def attach(network_id, id, interface_id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports/#{id}/attachment.json"
        response = put_to_quantum(full_url, {"attachment" => {"id" => "4a:94:c4:98:38:57"}})
        response.code < 300
      end
    end
  end
end
