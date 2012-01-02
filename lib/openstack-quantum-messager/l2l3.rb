# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def add_dhcp(name, address)
        dhcp_info = {"dhcp" => {"name" => name, "address" => address}}
        post_to_quantum(dhcp_info, "/dhcps.json")
      end

      def add_dhcp_entry(address, mac)
        dhcp_entry_info = {"dhcp_entry" => {"mac" => mac, "address" => address}}
        post_to_quantum(dhcp_entry_info, "/dhcp_entries.json")
      end

      private
      def post_to_quantum(info, url_suffix)
        response = HTTParty.post(
          @quantum_url + url_suffix,
          :body => info.to_json,
          :headers => {"Content-Type" => "application/json"}
        )
        response.body if response
      end
    end
  end
end
