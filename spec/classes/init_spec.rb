require 'spec_helper'

describe 'clamav' do
  let :facts do
    {
      :operatingsystem => 'Ubuntu',
      :operatingsystemrelease => 12.04,
    }
  end

  describe 'by default' do
    it {
      should contain_file('/etc/clamav/clamd.conf').
        with_content(/User clamav/).
        without_content(/TCPAddr/).
        without_content(/TCPSocket/)
    }
  end

  describe 'with tcp parameters' do
    let :params do
      {
        :tcpaddr => '10.2.1.0',
        :tcpsocket => '3310',
      }
    end
    it {
      should contain_file('/etc/clamav/clamd.conf').
        with_content(/User clamav/).
        with_content(/TCPAddr 10.2.1.0/).
        with_content(/TCPSocket 3310/)
    }
  end

  describe 'the daemon start script' do
    it {
      should contain_service('clamav-daemon').
        with_status('/usr/sbin/service clamav-daemon status | grep "is running"')
    }
  end

end
