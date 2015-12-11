
DB_FILE_NAME = "WorkerDB"
task :default => [:create , :test , :run , :delete ]

task :create do
  `sqlite3 #{DB_FILE_NAME} < CreateSchema.sql `
end

task :test do
  #ruby "test/worker_test.rb"
  #ruby "test/work_order_test.rb"
  #ruby "test/operation_test.rb"
  ruby "test/grading_tests.rb"
end

task :run do
  ruby "src/main_driver.rb"
end

task :delete do
 File.delete(DB_FILE_NAME)
end
