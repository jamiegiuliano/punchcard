# frozen_string_literal: true

class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url, :merchant_id
  has_one :category
end
