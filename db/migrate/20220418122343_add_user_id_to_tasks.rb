class AddUserIdToTasks < ActiveRecord::Migration[7.0]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    add_reference :tasks, :user, index: true
  end
end
