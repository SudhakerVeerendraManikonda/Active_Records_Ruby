$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'establish_connection'

class Status < ActiveRecord::Base
  has_many :work_orders
end