require 'orocos'
require 'vizkit'

include Orocos
Orocos.initialize

Orocos.run 'message_producer::Task' => 'message_producer' do 

    message_producer = TaskContext.get 'message_producer'
    
    message_producer.start

    reader = message_producer.messages.reader
    reader2 = message_producer.traj.reader

    Vizkit.display message_producer.traj
    Vizkit.display message_producer

    Vizkit.exec
end

