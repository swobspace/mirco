# frozen_string_literal: true

class HashToYamlComponent < ViewComponent::Base
  def initialize(hash:)
    @hash = hash
  end

  def yaml
    if hash.blank?
      "no data available"
    else
      hash.to_yaml.chomp
    end
  end

private
attr_reader :hash

end
