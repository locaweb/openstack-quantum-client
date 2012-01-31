# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class FilterRule < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(src, dst, dst_port, proto)
        full_url = "#{@quantum_url}/filter_rules.json"
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
        HTTParty.delete("#{@quantum_url}/filter_rules/#{id}.json" )
      end

      def show(id)
        HTTParty.get("#{@quantum_url}/filter_rules/#{id}.json" )
      end
    end
  end
end
