# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumClient::FilteredRange do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @client = Openstack::QuantumClient::L2l3.new(config)
    @filtered_range_info = {"filtered_range" => {"address" => "192.168.1.1", "mask" => "26"}}

    @firewall = @client.firewall.create("firewall1", "192.168.1.1")
  end

  it "should generate the correct json syntax for firewall inclusion" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/firewalls/%s/filtered_ranges.json"
    HTTParty.should_receive(:post).with(
      url % @firewall["uuid"],
      :body => @filtered_range_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @client.filtered_range.create(@firewall["uuid"], "192.168.1.1", "26")
  end
end
