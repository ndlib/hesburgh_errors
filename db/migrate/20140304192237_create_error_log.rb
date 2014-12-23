class CreateErrorLog < ActiveRecord::Migration
  def change
    create_table "error_logs", force: true do |t|
      t.string   "netid"
      t.string   "path"
      t.text     "message"
      t.text     "params"
      t.text     "stack_trace"
      t.datetime "created_at"
      t.string   "state"
      t.text     "user_agent"
      t.string   "exception_class"
    end
  end
end
