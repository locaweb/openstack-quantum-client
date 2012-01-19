# -*- encoding: utf-8 -*-
module Openstack
  module QuantumMessager
    class Network < L2l3
      def initialize(quantum_url, quantum_extension_url)
        @quantum_url = quantum_url
        @quantum_extension_url = quantum_extension_url
      end

      def create(name)
        full_url = "#{@quantum_url}/networks.json"
        post_to_quantum(full_url, {"network" => {"name" => name}})
      end

      def list(filters={})
        HTTParty.get("#{@quantum_extension_url}/networks.json", :query => filters)
      end

      def show(id)
        HTTParty.get("#{@quantum_url}/networks/#{id}.json")
      end
    end
  end
end
