# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class DhcpEntry < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def list(filters={})
         HTTParty.get("#{@quantum_url}/dhcp_entries.json", :query => filters)
      end

      def create(address, mac, name)
        full_url = "#{quantum_url}/dhcp_entries.json"
        post_to_quantum(
          full_url,
          {"dhcp_entry" => {"mac" => mac, "address" => address, "name" => name}}
        )
      end

      def delete(id)
        HTTParty.delete("#{@quantum_url}/dhcp_entries/#{id}.json" )
      end
    end
  end
end
