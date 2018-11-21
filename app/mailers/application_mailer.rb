class ApplicationMailer < ActionMailer::Base
  default from: 'nonreply@moasis.com'
  layout 'mailer'
end
