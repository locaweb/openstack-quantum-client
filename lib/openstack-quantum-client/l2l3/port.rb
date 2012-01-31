# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class Port < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(network_id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports.json"
        post_to_quantum(full_url, nil)
      end

      def plug(network_id, id, interface_id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports/#{id}/attachment.json"
        response = put_to_quantum(full_url, {"attachment" => {"id" => interface_id}})
        response.code < 300
      end

      def unplug(network_id, id)
        full_url = "#{@quantum_url}/networks/#{network_id}/ports/#{id}/attachment.json"
        response = HTTParty.delete(full_url)
        response.code < 300
      end

      def delete(network_id, id)
        HTTParty.delete("#{@quantum_url}/networks/#{network_id}/ports/#{id}.json")
      end

      def list(network_id, filters={})
        HTTParty.get("#{@quantum_url}/networks/#{network_id}/ports.json", :query => filters)
      end
    end
  end
end
