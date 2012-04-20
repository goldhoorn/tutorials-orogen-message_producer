require 'orocos'

include Orocos
Orocos.initialize

Orocos.run 'message_producer::Task' => 'message_producer' do 

    message_producer = TaskContext.get 'message_producer'

    # load property from a configuration file
    message_producer.apply_conf_file("message_producer_config.yml")
    
    # Call to configure is required for the component
    # since it has been generated with 'needs_configuration'
    message_producer.configure
    message_producer.start

    reader = message_producer.messages.reader

    while true
        if msg = reader.read_new
            puts "#{msg.time} #{msg.content}"
        end 

        sleep 0.5
    end
end

