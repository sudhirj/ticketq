# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  before_save :clean_slug
  self.abstract_class = true

  def self.data_accessors(*args)
    args.each do |arg|
      define_method(arg) do
        data[arg.to_s]
      end
      define_method([arg, '='].join) do |value|
        data[arg.to_s] = value
      end
    end
  end

  def clean_slug
    return unless respond_to?(:slug)

    self.slug = slug.to_s.parameterize
  end
end
