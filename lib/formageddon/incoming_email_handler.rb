require 'rufus/mnemo'

module Formageddon
  class IncomingEmailHandler < ActionMailer::Base
    def receive(email)
      to_email = email.to.select{|e| e =~ /_thread/ }.first

      return nil if to_email.nil?

      recipient, domain = to_email.split(/@/)
      thread_id, tag = recipient.split(/_/)

      thread_id = Rufus::Mnemo.to_i(thread_id)
      thread = FormageddonThread.find_by_id(thread_id)
      return nil if thread.nil?

      letter = FormageddonLetter.new
      letter.status = 'RECEIVED'
      letter.direction = 'TO_SENDER'

      letter.subject = email.subject
      letter.message = email.multipart? ? (email.text_part ? email.text_part.body.decoded : nil) : email.body.decoded

      letter.formageddon_thread = thread
      letter.save

      return letter
    end
  end
end