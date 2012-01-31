# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class AttachmentDetail < L2l3
      def initialize(quantum_extension_url)
        @quantum_extension_url = quantum_extension_url
      end

      def list(filters={})
        HTTParty.get("#{quantum_extension_url}/attachment_details.json", :query => filters)
      end

      def create(mac, ip)
        url = "#{quantum_extension_url}/attachment_details.json"
        post_to_quantum(url, {"attachment_detail" => {"interface_id" => mac, "ip" => ip}})
      end

      def delete(id)
        url = "#{quantum_extension_url}/attachment_details/#{id}.json"
        HTTParty.delete(url)
      end
    end
  end
end
