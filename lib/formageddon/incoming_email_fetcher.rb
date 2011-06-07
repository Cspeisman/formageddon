module Formageddon
  class IncomingEmailFetcher
    require 'net/pop'

    def self.fetch
      puts "Running Mail Importer..." 
      Net::POP3.start(Formageddon::configuration.incoming_email_config['server'], nil, 
                      Formageddon::configuration.incoming_email_config['username'], 
                      Formageddon::configuration.incoming_email_config['password']) do |pop|
        if pop.mails.empty?
          puts "NO MAIL" 
        else
          pop.mails.each do |email|
            begin
              puts "receiving mail..." 
              Formageddon::IncomingEmailHandler.receive(email.pop)
              email.delete
            rescue Exception => e
              puts e.message
            end
          end
        end
      end
      puts "Finished Mail Importer."
    end
  end
end