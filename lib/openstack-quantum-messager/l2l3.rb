# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class L2l3
      attr_reader :quantum_url
      attr_reader :quantum_extension_url

      # The initialize l2l3 class should be initialized passing a hash
      # with url and tenant:
      # Example:
      #
      #   {:url => "http://localhost:9696", :tenant => "XYZ"}
      def initialize(config)
        @quantum_extension_url = "#{config[:url]}/v1.0/extensions/l2l3/tenants/#{config[:tenant]}"
        @quantum_url = "#{config[:url]}/v1.0/tenants/#{config[:tenant]}"
      end

      def attachment_detail
        @attachment_detail ||= AttachmentDetail.new(@quantum_extension_url)
      end

      def firewall
        @firewall ||= Firewall.new(@quantum_extension_url)
      end

      def filtered_range
        @filtered_range ||= FilteredRange.new(@quantum_extension_url)
      end

      def filter_rule
        @filter_rule ||= FilterRule.new(@quantum_extension_url)
      end

      def dhcp
        @dhcp ||= Dhcp.new(@quantum_extension_url)
      end

      def dhcp_entry
        @dhcp_entry ||= DhcpEntry.new(@quantum_extension_url)
      end

      def port
        @port ||= Port.new(@quantum_url, @quantum_extension_url)
      end

      def network
        @network ||= Network.new(@quantum_url, @quantum_extension_url)
      end

      protected
      def post_to_quantum(post_url, info)
        send_to_quantum("post", post_url, info)
      end

      def put_to_quantum(post_url, info)
        send_to_quantum("put", post_url, info)
      end

      def send_to_quantum(http_method, post_url, info)
        response = HTTParty.send(
          http_method,
          post_url,
          :body => info.to_json,
          :headers => {"Content-Type" => "application/json"}
        )
        response
      end
    end
  end
end
