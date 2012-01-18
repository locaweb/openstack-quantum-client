# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class Network < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(name)
        full_url = "#{@quantum_url}/networks.json"
        post_to_quantum(full_url, {"network" => {"name" => name}})
      end
    end
  end
end
