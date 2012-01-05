# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumMessager::Firewall do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @messager = Openstack::QuantumMessager::L2l3.new(config)
    @firewall_info = {"firewall" => {"name" => "firewall1", "address" => "192.168.1.1"} }
  end

  it "should generate the correct json syntax for firewall inclusion" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/firewalls.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @firewall_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @messager.firewall.create("firewall1", "192.168.1.1")
  end

  it "should return the firewall uuid" do
    firewall_info = @messager.firewall.create("firewall1", "192.168.1.1")
    firewall_info.should_not be_nil
    firewall_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end

  it "should return a firewalls array" do
    firewall_info = @messager.firewall.list
    firewall_info.should_not be_nil
    firewall_info.should be_instance_of(Array)
  end
end
