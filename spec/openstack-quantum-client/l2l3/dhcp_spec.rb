# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumClient::Dhcp do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @client = Openstack::QuantumClient::L2l3.new(config)
    @dhcp_info = {"dhcp" => {"name" => "dhcp1", "address" => "192.168.1.1"} }
  end

  it "should generate the correct json syntax for dhcp inclusion" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/dhcps.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @dhcp_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @client.dhcp.create("dhcp1", "192.168.1.1")
  end

  it "should return the dhcp uuid" do
    dhcp_info = @client.dhcp.create("dhcp1", "192.168.1.1")
    dhcp_info.should_not be_nil
    dhcp_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end

  it "should return a dhcps array" do
    dhcp_info = @client.dhcp.list
    dhcp_info.should_not be_nil
    dhcp_info.should be_instance_of(Array)
  end

  it "should reload the dhcp" do
    dhcp_info = @client.dhcp.create("dhcp1", "192.168.1.1")
    response = @client.dhcp.reload(dhcp_info["id"])
    response.code.should < 400
  end
end
