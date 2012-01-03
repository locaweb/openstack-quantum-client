# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Openstack::QuantumMessager::L2l3 do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @messager = Openstack::QuantumMessager::L2l3.new(config)
  end

  context "when dealing with dhcps" do
    before do
      @dhcp_info = {"dhcp" => {"name" => "dhcp1", "address" => "192.168.1.1"} }
    end

    it "should generate the correct json syntax for dhcp inclusion" do
      url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/dhcps.json"
      HTTParty.should_receive(:post).with(
        url,
        :body => @dhcp_info.to_json,
        :headers => {"Content-Type" => "application/json"}
      )
      @messager.add_dhcp("dhcp1", "192.168.1.1")
    end

    it "should return the dhcp uuid" do
      dhcp_info = @messager.add_dhcp("dhcp1", "192.168.1.1")
      dhcp_info.should_not be_nil
      dhcp_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
    end

    it "should return a dhcps array" do
      dhcp_info = @messager.list_dhcp
      dhcp_info.should_not be_nil
      dhcp_info["dhcps"].should be_instance_of(Array)
    end

  end

  context "when dealing with dhcps entrys" do
    before do
      @dhcp_entry_info = {"dhcp_entry" => {"mac" => "a4:ba:db:05:6e:f8", "address" => "192.168.3.4"}}
    end

    it "should generate the correct json syntax for dhcp inclusion" do
      url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/dhcp_entries.json"
      HTTParty.should_receive(:post).with(
        url,
        :body => @dhcp_entry_info.to_json,
        :headers => {"Content-Type" => "application/json"}
      )
      @messager.add_dhcp_entry("192.168.3.4", "a4:ba:db:05:6e:f8")
    end

    it "should return the dhcp uuid" do
      dhcp_entry_info = @messager.add_dhcp_entry("dhcp1", "192.168.3.4")
      dhcp_entry_info.should_not be_nil
      dhcp_entry_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
    end

  end
end
