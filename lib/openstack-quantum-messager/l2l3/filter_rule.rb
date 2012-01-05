# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class FilterRule < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/filter_rules.json"
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
        post_to_quantum(@quantum_url, post_hash)
      end
    end
  end
end
