# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class FilterRule < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(src, dst, dst_port, proto)
        post_hash = {
          "filter_rule" => {
            "src"       => src,
            "dst"       => dst,
            "dst_port"  => dst_port,
            "proto"     => proto
          }
        }
        post_to_quantum(full_url, post_hash)
      end

      def delete(id)
        post_to_quantum(full_url(:resource => id.to_s))
      end

      private
      def full_url(with={:resource => "filter_rules"})
        "#{@quantum_url}/#{with[:resource]}.json"
      end
    end
  end
end
