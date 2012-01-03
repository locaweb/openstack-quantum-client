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

      def dhcp
        @dhcp ||= Dhcp.new(@quantum_url)
      end

      def dhcp_entry
        @dhcp_entry ||= DhcpEntry.new(@quantum_url)
      end

      protected
      def post_to_quantum(post_url, info)
        response = HTTParty.post(
          post_url,
          :body => info.to_json,
          :headers => {"Content-Type" => "application/json"}
        )
        JSON.parse(response.body) if response
      end
    end

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
