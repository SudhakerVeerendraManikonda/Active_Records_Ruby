$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'worker'
require 'work_order'
require 'status'

class Operation

  def self.add_worker (worker)
     Worker.create( :first_name => worker.first_name ,
                    :last_name => worker.last_name ).id

  end

  def  self.add_work_order (work_order)
    WorkOrder.create(   :work_details => work_order.work_details,
                        :date_of_creation => DateTime.now ,
                        :status_id => work_order.status_id ,
                        :last_update_date => DateTime.now  ).id
  end

  def self.assign_work_order (work_order , worker ,status)
     WorkOrder.update(work_order.id , :worker_id => worker.id ,
                                      :status_id => status.id ,
                                      :last_update_date  => DateTime.now )
  end

  def self.list_all_workers
    Worker.all
  end

  def self.list_all_work_orders
    WorkOrder.all
  end

  def self.list_work_orders_not_completed (worker)
    WorkOrder.where("status_id != '4' and worker_id = #{worker.id}")
  end

  def self.list_work_orders_by_status (status)
    WorkOrder.where(:status_id => status.id)
  end

end
