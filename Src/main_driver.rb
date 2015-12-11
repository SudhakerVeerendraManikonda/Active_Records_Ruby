$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'operation'

def add_workers
  new_worker = Worker.new
  print "Enter First Name:"
  new_worker.first_name = gets.chomp
  print "Enter Last Name:"
  new_worker.last_name = gets.chomp
  new_worker_id = Operation.add_worker new_worker
  print "Worker ID : #{new_worker_id} \n\n"
end

def add_work_orders
  new_work_order = WorkOrder.new
  print "Enter Work details:"
  new_work_order.work_details = gets.chomp
  print "Enter Status ( 1.Created, 2.In Progress, 3.Review, 4.Completed):"
  new_work_order.status_id = gets.chomp
  new_work_order_id = Operation.add_work_order new_work_order
  print "Work_Order No : #{new_work_order_id}  \n\n"
end

def list_all_the_work_orders
  display_details(Operation.list_all_work_orders)
end

def list_work_orders_which_not_completed
  print "\nSelect the worker id to be assigned:"
  Operation.list_all_workers.each do |worker|
    printf "\n%-4s %s %s" , worker.id,worker.first_name,worker.last_name
  end
  puts
  worker = Worker.new
  worker.id = gets.chomp
  display_details(Operation.list_work_orders_not_completed(worker))
end

def list_work_orders_by_status_id
  print "\nView work Order by Status"
  print "\nEnter Status ( 1.Created, 2.In Progress, 3.Review, 4.Completed):"
  status = Status.new
  status.id = gets.chomp
  display_details(Operation.list_work_orders_by_status(status))
end

def assign_work_orders
    print "\nSelect the work order id to be assigned:"
    Operation.list_all_work_orders.each do |workorder|
      printf "\n%-4s %s" , workorder.id,workorder.work_details
    end
    puts
    work_order = WorkOrder.new
    work_order.id = gets.chomp

    print "\nSelect the worker id to be assigned:"
    Operation.list_all_workers.each do |worker|
      printf "\n%-4s %s %s" , worker.id,worker.first_name,worker.last_name
    end
    puts
    worker = Worker.new
    worker.id = gets.chomp

    print "\nEnter Status ( 1.Created, 2.In Progress, 3.Review, 4.Completed):"
    status = Status.new
    status.id = gets.chomp

    Operation.assign_work_order  work_order , worker ,status
    print "\nAssigned Successfully!!! \n\n"
end

def display_details (work_order_list)
  print "\nNo Work Order Found\n\n"  if  work_order_list.empty?
  work_order_list.each do |workorder|
    printf "\n%-20s:%s","Work Order ID" , workorder.id
    printf "\n%-20s:%s","Work Order Details",workorder.work_details
    printf "\n%-20s:%s","Created Date", workorder.date_of_creation
    printf "\n%-20s:%s","Status", workorder.status.status_description
    if (workorder.worker.blank?)
      printf "\n%-20s:%s", "Assigned to" , "Not Assigned to Worker"
    else
      printf "\n%-20s:%s %s","Assigned to", workorder.worker.first_name , workorder.worker.last_name
    end
    printf "\n%-20s:%s\n\n","Status Updated", workorder.last_update_date
  end
end

def rescue_exception
  begin
    yield
  rescue => ex
    print "\n#{ex} \n\n"
  end
end


begin
  puts "Please select the Option to be Performed"
  puts '1.Create Worker'
  puts '2.Create Work Order'
  puts '3.Assign Work Order'
  puts '4.List All Work Orders'
  puts '5.View Work Orders Assigned to worker but not Completed'
  puts '6.View Work Orders by Status'
  puts '7.Exit'
  entered_option = gets.chomp
  case entered_option
    when "1"
      rescue_exception { add_workers }
    when "2"
      rescue_exception { add_work_orders }
    when "3"
      rescue_exception { assign_work_orders }
    when "4"
      rescue_exception { list_all_the_work_orders }
    when "5"
      rescue_exception { list_work_orders_which_not_completed }
    when "6"
      rescue_exception { list_work_orders_by_status_id }
    when "7"
      exit
    else
      puts "Enter Valid Option"
  end
end while(true)