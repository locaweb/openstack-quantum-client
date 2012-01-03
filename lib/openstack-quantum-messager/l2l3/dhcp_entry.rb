# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class DhcpEntry < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/dhcp_entries.json"
      end

      def create(address, mac)
        post_to_quantum(
          @quantum_url,
          {"dhcp_entry" => {"mac" => mac, "address" => address}}
        )
      end
    end
  end
end
