class DeliveryJob < ApplicationJob
  queue_as :default

  def perform(subject)
    subject.deliver
  end
end
