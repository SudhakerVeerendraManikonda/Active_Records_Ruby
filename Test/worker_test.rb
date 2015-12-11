$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'test'))
$:.unshift '..'

require 'rollback'
require 'worker'
require 'test/unit'

class WorkerTest  < Test::Unit::TestCase

  def test_canery
    assert true
  end

  def test_worker_list
    assert_equal 2,Worker.count
  end

  def test_worker_create
    transaction_and_rollback do
      Worker.create(:first_name => "Testfirstname" , :last_name => "Testlastname")
      assert_equal(3, Worker.count)
    end
  end

  def test_worker_needs_a_name
    transaction_and_rollback do
      assert_raise(ActiveModel::StrictValidationFailed){ Worker.create(:first_name => "" , :last_name => "")}
   end
  end

  def test_worker_needs_a_first_name
    transaction_and_rollback do
      assert_raise(ActiveModel::StrictValidationFailed){ Worker.create(:first_name => "" , :last_name => "abcd")}
    end
  end

  def test_worker_needs_a_last_name
    transaction_and_rollback do
      assert_raise(ActiveModel::StrictValidationFailed){ Worker.create(:first_name => "abcd" , :last_name => "")}
    end
  end

end