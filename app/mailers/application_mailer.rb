# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'notification@mustsee.x25.pl'
  layout 'mailer'
end
