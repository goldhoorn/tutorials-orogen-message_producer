require 'orocos'

include Orocos
Orocos.initialize

Orocos.run 'message_producer_deployment' do 

    message_producer = TaskContext.get 'message_producer'

    message_producer.config do |p|
        p.uppercase = true
    end

    message_producer.configure
    message_producer.start

    reader = message_producer.messages.reader

    while true
        if msg = reader.read
            puts "#{msg.time} #{msg.content}"
        end 

        sleep 0.5
    end
end

