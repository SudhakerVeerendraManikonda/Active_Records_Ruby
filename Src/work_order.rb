$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'establish_connection'
require 'status'
require 'worker'

class WorkOrder < ActiveRecord::Base
  belongs_to :worker
  belongs_to :status

  validate :validate_worker_id
  validate :validate_status_id

  def validate_worker_id
    raise RuntimeError.new("Worker does not exist.") unless  ( Worker.exists?(self.worker_id) or self.worker_id == nil )
  end

  def validate_status_id
    raise RuntimeError.new("Status does not exist.") unless Status.exists?(self.status_id)
  end
end