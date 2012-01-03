# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class L2l3
      # The initialize l2l3 class should be initialized passing a hash
      # with url and tenant:
      # Example:
      #
      #   {:url => "http://localhost:9696", :tenant => "XYZ"}
      def initialize(config)
        @quantum_url = "#{config[:url]}/v1.0/extensions/l2l3/tenants/#{config[:tenant]}"
      end

      def add_dhcp(name, address)
        dhcp_info = {"dhcp" => {"name" => name, "address" => address}}
        post_to_quantum(dhcp_info, "/dhcps.json")
      end

      def add_dhcp_entry(address, mac)
        dhcp_entry_info = {"dhcp_entry" => {"mac" => mac, "address" => address}}
        post_to_quantum(dhcp_entry_info, "/dhcp_entries.json")
      end

      def list_dhcp
        response = HTTParty.get(@quantum_url + "/dhcps.json")
        response.body if response
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
