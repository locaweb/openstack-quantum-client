# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumClient::Network do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @client = Openstack::QuantumClient::L2l3.new(config)
    @network_info = {"network" => {"name" => "network1"}}
  end

  it "should generate the correct json syntax for network inclusion" do
    url = "http://localhost:9696/v1.0/tenants/XYZ/networks.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @network_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @client.network.create("network1")
  end

  it "should return the network uuid" do
    network_info = @client.network.create("network1")["network"]
    network_info.should_not be_nil
    network_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end

  it "should list networks filtered" do
    @client.network.create("network1")
    @client.network.create("network2")
    network_list = @client.network.list(:name => "network2")["networks"]
    network_list.size.should == 1
    network_info = @client.network.show(network_list.first["id"])["network"]
    network_info["name"].should == "network2"
  end

  it "should return the last network created by name" do
    network_id = @client.network.create("network1")
    network = @client.network.find_or_create_by_name("network1")
    network["id"].should eql(network_id["network"]["id"])
  end

  it "should create a network if can't find it" do
    network = "new_network"
    @client.network.list(:name => network)["networks"].should be_empty
    @client.network.find_or_create_by_name(network).should_not be_nil
  end
end
