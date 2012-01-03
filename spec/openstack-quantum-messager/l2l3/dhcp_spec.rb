# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumMessager::Dhcp do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @messager = Openstack::QuantumMessager::L2l3.new(config)
    @dhcp_info = {"dhcp" => {"name" => "dhcp1", "address" => "192.168.1.1"} }
  end

  it "should generate the correct json syntax for dhcp inclusion" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/dhcps.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @dhcp_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @messager.dhcp.create("dhcp1", "192.168.1.1")
  end

  it "should return the dhcp uuid" do
    dhcp_info = @messager.dhcp.create("dhcp1", "192.168.1.1")
    dhcp_info.should_not be_nil
    dhcp_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end

  it "should return a dhcps array" do
    dhcp_info = @messager.dhcp.list
    dhcp_info.should_not be_nil
    dhcp_info.should be_instance_of(Array)
  end
end
