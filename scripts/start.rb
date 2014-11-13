require 'orocos'

include Orocos
Orocos.initialize

Orocos.run 'sched' do 

    message_producer = TaskContext.get 'task1'
    sched = TaskContext.get 'sched_scheduler'

    message_producer.dynamic = 3.0
    message_producer.start
    message_producer.dynamic = 1.0

    sched.configure
    message_producer.dynamic = 2.0
    sched.execution_order = ['task1','task2']
    sched.start
    message_producer.dynamic = 6.0

    reader = message_producer.messages.reader

    STDOUT.puts "Finished"
    while true
        if msg = reader.read_new
            puts "#{msg.time} #{msg.content}"
        end 
        sched.trigger.write(1)
        sleep 0.5
    end
end

