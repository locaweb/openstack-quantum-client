# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumMessager::Port do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @messager = Openstack::QuantumMessager::L2l3.new(config)
    @port_info = {}
    @network_id = @messager.network.create("net")["network"]["id"]
  end

  it "should generate the correct json syntax for port inclusion" do
    url = "http://localhost:9696/v1.0/tenants/XYZ/networks/#{@network_id}/ports.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => "null",
      :headers => {"Content-Type" => "application/json"}
    )
    @messager.port.create(@network_id)
  end

  it "should return the port uuid" do
    port_info = @messager.port.create(@network_id)["port"]
    port_info.should_not be_nil
    port_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end
  
  it "should attach an interface" do
    mac = "4a:94:c4:98:38:57"
    port_info = @messager.port.create(@network_id)["port"]
    @messager.port.attach(@network_id, port_info["id"], mac).should be_true
  end
end
