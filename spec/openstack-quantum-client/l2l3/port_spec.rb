# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumClient::Port do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @client = Openstack::QuantumClient::L2l3.new(config)
    @port_info = {}
    @network_id = @client.network.create("net")["network"]["id"]
  end

  it "should generate the correct json syntax for port inclusion" do
    url = "http://localhost:9696/v1.0/tenants/XYZ/networks/#{@network_id}/ports.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => "null",
      :headers => {"Content-Type" => "application/json"}
    )
    @client.port.create(@network_id)
  end

  it "should return the port uuid" do
    port_info = @client.port.create(@network_id)["port"]
    port_info.should_not be_nil
    port_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end

  it "should plug an interface" do
    mac = "4a:94:c4:98:38:57"
    port_info = @client.port.create(@network_id)["port"]
    @client.port.plug(@network_id, port_info["id"], mac).should be_true
    new_port_info = @client.port.list(@network_id, :attachment => mac)["ports"].first
    new_port_info["id"].should == port_info["id"]
  end

  it "should unplug an interface" do
    mac = "4a:94:c4:98:38:57"
    port_info = @client.port.create(@network_id)["port"]
    @client.port.unplug(@network_id, port_info["id"]).should be_true
  end

  it "should delete the port" do
    port_info = @client.port.create(@network_id)["port"]
    @client.port.delete(@network_id, port_info["id"]).code.should == 204
  end
end
