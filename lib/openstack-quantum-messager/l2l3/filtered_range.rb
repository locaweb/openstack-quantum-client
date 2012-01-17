# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class FilteredRange < L2l3
      def initialize(quantum_url)
        @quantum_url = "#{quantum_url}/firewalls/%s/filtered_ranges.json"
      end

      def create(firewall_uuid, address, mask)
        post_to_quantum(
          @quantum_url % firewall_uuid.to_s,
          {"filtered_range" => {"address" => address, "mask" => mask}}
        )
      end
    end
  end
end
