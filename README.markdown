Openstack Quantum Client
========================

A ruby client for [Locaweb plugin](https://github.com/locaweb/quantum) for
[Openstack Quantum](https://github.com/openstack/quantum).

This client have support for quantum v1 API (networks and ports) and some
extras provided by Locaweb plugin (dhcps, firewalls, ...)

Usage
-----

Install it from Rubygems;

        gem install openstack-quantum-client


With the gem installed the L2l3 class will be available:

        openstack = Openstack::QuantumClient::L2l3.new(
          {:url => "http://localhost:9696", :tenant => "XYZ"
        )

Some methods will be available on this instance:

        openstack.firewall.list
        openstack.firewall.create("firewall_name", "192.168.1.1")


The same is valid for dhcp, attachment_detail and so on.
