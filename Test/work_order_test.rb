$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'test'))
$:.unshift '..'

require 'rollback'
require 'work_order'
require 'test/unit'

class WorkOrderTest < Test::Unit::TestCase

  def test_canery
    assert true
  end

  def test_work_order_list
    assert_equal 1,WorkOrder.count
  end

  def test_assign_work_order
    transaction_and_rollback do
      WorkOrder.update(1 , :worker_id => 1)
      assert_equal(1, WorkOrder.find_by_id(1).worker_id)
    end
  end

  def test_work_order_create
    transaction_and_rollback do
      WorkOrder.create(  :work_details => "Testing",
                         :date_of_creation => DateTime.now ,
                         :status_id => 1 ,
                         :worker_id => nil ,
                         :last_update_date => DateTime.now  )
      assert_equal(2, WorkOrder.count)
    end
  end

  def test_assign_work_order_with_invalid_status
    transaction_and_rollback do
      assert_raise(RuntimeError, 'Status does not exist.')   {WorkOrder.create( :work_details => "Testing",
                                                                                :date_of_creation => DateTime.now ,
                                                                                :worker_id => 1 ,
                                                                                :status_id => 5 ,
                                                                                :last_update_date => DateTime.now  )}

    end
  end

  def test_assign_work_order_with_invalid_worker
    transaction_and_rollback do
      assert_raise(RuntimeError, 'worker does not exist.')   {WorkOrder.create( :work_details => "Testing",
                                                                                :date_of_creation => DateTime.now ,
                                                                                :worker_id => 10 ,
                                                                                :status_id => 5 ,
                                                                                :last_update_date => DateTime.now  )}

    end
  end
end