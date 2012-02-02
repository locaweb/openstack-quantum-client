# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class DhcpEntry < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/dhcp_entries.json"
      end

      def create(address, mac, name)
        post_to_quantum(
          @quantum_url,
          {"dhcp_entry" => {"mac" => mac, "address" => address, "name" => name}}
        )
      end
    end
  end
end
