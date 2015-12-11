$:.unshift(File.join(File.dirname(__FILE__), '..', 'src'))
require 'establish_connection'

class Worker < ActiveRecord::Base
  has_many :work_orders

  validates :first_name , :last_name ,presence:{ strict: true , :message => "Name can't be blank" }
  validates :first_name, :last_name, format:{strict:true , with: /\A[A-Za-z]+[.\s]*[A-Za-z]+\z/ , :message => "can contain only Alphabets"}

end