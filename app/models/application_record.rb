class ApplicationRecord < ActiveRecord::Base
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
end
