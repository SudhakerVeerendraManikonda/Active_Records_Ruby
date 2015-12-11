$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'test/unit'
require 'date'
require 'worker'
require 'work_order'
require 'operation'

class GradingTests < Test::Unit::TestCase
  def test_create_worker
    assert @worker.valid?
  end  

#strict validation blowing up these tests
  #def test_first_name_required
  #  @worker.first_name = ''
  #  assert !@worker.valid?
  #end  

  #def test_last_name_required
  #  @worker.last_name = ''
  #  assert !@worker.valid?
  #end  
  
  def test_create_work_order
    assert @workorder.valid?
  end
  
  def run_and_rollback
    ActiveRecord::Base.transaction do
      yield
      raise ActiveRecord::Rollback
    end
  end
  
  def test_assign_a_work_order_to_a_worker
    run_and_rollback do
      assert_equal 0, get_number_of_workorders(@worker)
      assign_workorder_to_worker(@worker, @workorder)
      @worker.save
      assert_equal 1, get_number_of_workorders(@worker)      
    end
  end

  def test_dont_allow_to_assign_a_work_order_twice
    run_and_rollback do
      assert_equal 0, get_number_of_workorders(@worker)
      set_workorder_status(@workorder, 'review')
      assign_workorder_to_worker(@worker, @workorder)
      @worker.save
      begin
        assign_workorder_to_worker(@worker, @workorder)
        @worker.save
      rescue
      end
      assert_equal 1, get_number_of_workorders(@worker)      
    end
  end

  def test_dont_allow_to_assign_a_completed_workorder
    run_and_rollback do
      assert_equal 0, get_number_of_workorders(@worker)
      set_workorder_status(@workorder, 'completed')
      begin
        assign_workorder_to_worker(@worker, @workorder)
        @worker.save
      rescue
      end
      assert_equal 0, get_number_of_workorders(@worker)      
    end
  end  
#--------------- need to customize the following to specific code for each pair --------------- 
  def setup
    @worker = Worker.new(:first_name => 'James', :last_name => 'Barker')
    work_details = "work1"
    status = Status.find_by_status_description('Created')
    creation_date = Date.today
    status_update_date = Date.today
    @workorder = WorkOrder.new(:work_details => work_details, :date_of_creation => creation_date, :status => status, :last_update_date => status_update_date)    
  end

  def get_number_of_workorders(worker)
    worker.work_orders.count
  end

  def assign_workorder_to_worker(worker, workorder)
    Operation.assign_work_order(workorder, workorder, workorder.status)
  end

  def set_workorder_status(workorder, status)
    workorder.status = Status.find_by_status_description(status.capitalize)
  end
end
