require 'orocos'
require 'readline'

include Orocos
Nameservice::enable(:AVAHI, { :searchdomains => [ '_robot._tcp'] })
Orocos.initialize

Orocos.run 'message_producer_deployment' , 'cmdline_args' => { 'sd-domain' => '_robot._tcp'}, 'wait' => 3  do 

    message_producer = TaskContext.get 'message_producer'

    message_producer.config do |p|
        p.uppercase = true
    end

    message_producer.configure    
    message_producer.start

    Readline::readline("Press ENTER to exit\n") do
    end
end

