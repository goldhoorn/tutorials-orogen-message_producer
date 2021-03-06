require 'orocos'

include Orocos
Orocos.initialize

Orocos.run 'message_producer::Task' => 'message_producer' do 

    message_producer = TaskContext.get 'message_producer'
    
    message_producer.start

    reader = message_producer.messages.reader

    while true
        if msg = reader.read_new
            puts "#{msg.time} #{msg.content}"
        end 

        sleep 0.5
    end
end

