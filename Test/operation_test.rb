$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'test'))
$:.unshift '..'

require 'rollback'
require 'operation'
require 'test/unit'

class OperationTest  < Test::Unit::TestCase

  def test_canery
    assert true
  end

  def test_add_worker
    transaction_and_rollback do
      new_worker = Worker.new
      new_worker.first_name = "Test"
      new_worker.last_name = "Testing"
      worker_id = Operation.add_worker (new_worker)
      assert_equal(3, worker_id)
    end
  end

  def test_add_work_order
    transaction_and_rollback do
      new_work_order = WorkOrder.new
      new_work_order.work_details = "Testing"
      new_work_order.status_id = 1
      new_work_order_id = Operation.add_work_order new_work_order
      assert_equal(2,new_work_order_id)
    end
  end

  def test_assign_work_order
    transaction_and_rollback do
      work_order = WorkOrder.new
      work_order.id = 1
      worker = Worker.new
      worker.id = 1
      status = Status.new
      status.id = 2
      assert Operation.assign_work_order  work_order , worker ,status
    end
  end

end