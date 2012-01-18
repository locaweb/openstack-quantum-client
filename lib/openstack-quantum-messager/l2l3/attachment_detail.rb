# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class AttachmentDetail < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/attachment_details.json"
      end

      def create(mac, ip)
        post_to_quantum(
          @quantum_url,
          {"attachment_detail" => {"interface_id" => mac, "ip" => ip}}
        )
      end
    end
  end
end
