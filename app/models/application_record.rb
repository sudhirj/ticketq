# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  before_save :clean_slug
  self.abstract_class = true

  def clean_slug
    return unless respond_to?(:slug)

    self.slug = slug.to_s.parameterize
  end
end
