# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Openstack::QuantumClient::L2l3 do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @client = Openstack::QuantumClient::L2l3.new(config)
  end

  it "should generate the correct url" do
    @client.quantum_extension_url.should eql("http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ")
  end

  it "should create a new instance of dhcp" do
    @client.dhcp.should be_instance_of(Openstack::QuantumClient::Dhcp)
  end

  it "should create a new instance of dhcp entry" do
    @client.dhcp_entry.should be_instance_of(Openstack::QuantumClient::DhcpEntry)
  end
end
