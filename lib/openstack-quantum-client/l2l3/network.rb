# -*- encoding: utf-8 -*-
module Openstack
  module QuantumClient
    class Network < L2l3
      def initialize(quantum_url)
        @quantum_url = quantum_url
      end

      def create(name)
        full_url = "#{@quantum_url}/networks.json"
        post_to_quantum(full_url, {"network" => {"name" => name}})
      end

      def list(filters={})
        HTTParty.get("#{@quantum_url}/networks.json", :query => filters)
      end

      def show(id)
        HTTParty.get("#{@quantum_url}/networks/#{id}.json")
      end

      def find_or_create_by_name(network_name)
        networks = list(:name => network_name)["networks"]
        if networks.empty?
          create(network_name)
        end
        list(:name => network_name)["networks"].last
      end
    end
  end
end
