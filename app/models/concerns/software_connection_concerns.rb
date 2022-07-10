# frozen_string_literal: true

module SoftwareConnectionConcerns
  extend ActiveSupport::Concern

  included do
  end

  def src_url_host
    fetch_host(source_url)
  end

  def dst_url_host
    fetch_host(destination_url)
  end

  private

  def fetch_host(url)
    uri = Mirco::Uri.new(url)
    if uri.host =~ /\A[0-9]{0,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\z/
      Host.where(ipaddress: uri.host).first
    else
      nil
    end
  end
end
