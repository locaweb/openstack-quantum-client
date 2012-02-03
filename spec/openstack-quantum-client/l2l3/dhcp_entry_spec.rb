# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumClient::DhcpEntry do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @client = Openstack::QuantumClient::L2l3.new(config)
    @dhcp_entry_info = {"dhcp_entry" => {"mac" => "a4:ba:db:05:6e:f8", "address" => "192.168.3.4", "name" => "machine0001"}}
  end

  it "should generate the correct json syntax for dhcp inclusion" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/dhcp_entries.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @dhcp_entry_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @client.dhcp_entry.create("192.168.3.4", "a4:ba:db:05:6e:f8", "machine0001")
  end

  it "should return the dhcp uuid" do
    dhcp_entry_info = @client.dhcp_entry.create("dhcp1", "192.168.3.4", "machine0001")
    dhcp_entry_info.should_not be_nil
    dhcp_entry_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end

  it "should list the dhcp entries" do
    vm = "machine0002"
    dhcp_entry_info = @client.dhcp_entry.create("dhcp1", "192.168.3.4", vm).to_hash
    @client.dhcp_entry.list["dhcp_entries"].should_not be_empty
    @client.dhcp_entry.list(:name => "unknown")["dhcp_entries"].should be_empty
    @client.dhcp_entry.list(:name => vm)["dhcp_entries"].first.should == dhcp_entry_info
  end

  it "should delete a dhcp entry" do
    dhcp_entry_info = @client.dhcp_entry.create("dhcp1", "192.168.3.4", "machine0001")
    response = @client.dhcp_entry.delete(dhcp_entry_info["id"])
    response.code.should < 400
  end
end
