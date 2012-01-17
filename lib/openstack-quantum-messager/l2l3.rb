# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class L2l3
      attr_reader :quantum_url

      # The initialize l2l3 class should be initialized passing a hash
      # with url and tenant:
      # Example:
      #
      #   {:url => "http://localhost:9696", :tenant => "XYZ"}
      def initialize(config)
        @quantum_url = "#{config[:url]}/v1.0/extensions/l2l3/tenants/#{config[:tenant]}"
      end

      def firewall
        @firewall ||= Firewall.new(@quantum_url)
      end

      def filtered_range
        @filtered_range ||= FilteredRange.new(@quantum_url)
      end

      def filter_rule
        @filter_rule ||= FilterRule.new(@quantum_url)
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
  end
end
