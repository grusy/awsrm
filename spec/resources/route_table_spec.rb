require 'spec_helper'
Awspec::Stub.load 'route_table'

RSpec.describe Awsrm::RouteTable do
  it '#one().id' do
    expect(Awsrm::RouteTable.one(name: 'my-route-table').id).to eq 'rtb-a12bcd34'
  end

  it '#filters' do
    expect(Awsrm::RouteTable.filters(name: 'my-route-table')).to eq [{ name: 'tag:Name', values: ['my-route-table'] }]
    expect(Awsrm::RouteTable.filters(vpc_id: 'vpc-ab123cde')).to eq [{ name: 'vpc-id', values: ['vpc-ab123cde'] }]
    expect(Awsrm::RouteTable.filters(vpc: 'my-vpc')).to eq [{ name: 'vpc-id', values: ['vpc-ab123cde'] }]
  end
end