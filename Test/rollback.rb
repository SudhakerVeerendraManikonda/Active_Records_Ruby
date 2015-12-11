def transaction_and_rollback
  ActiveRecord::Base.transaction do
    yield
    raise ActiveRecord::Rollback
  end
end