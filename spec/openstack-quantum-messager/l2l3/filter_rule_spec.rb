# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumMessager::FilterRule do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @messager = Openstack::QuantumMessager::L2l3.new(config)
    @filter_rule_info = {
      "filter_rule" => {
        "src" => "192.168.1.1/32",
        "dst" => "10.0.0.1",
        "dst_port" => 22,
        "proto" => "tcp"
      }
    }
  end

  it "should generate the correct json syntax for filter_rule inclusion" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/filter_rules.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @filter_rule_info.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @messager.filter_rule.create("192.168.1.1/32","10.0.0.1",22,"tcp")
  end

  it "should return the filter_rule uuid" do
    filter_rule_info = @messager.filter_rule.create("192.168.1.1/32","10.0.0.1",22,"tcp")
    filter_rule_info.should_not be_nil
    filter_rule_info["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end
end
