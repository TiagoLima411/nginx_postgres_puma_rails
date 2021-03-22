# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_16_172616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_balances", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "available_value_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_account_balances_on_user_id"
  end

  create_table "account_extracts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "account_balance_id"
    t.integer "reference_id"
    t.integer "value_cents"
    t.integer "balance_cents"
    t.string "description"
    t.integer "type_register"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_balance_id"], name: "index_account_extracts_on_account_balance_id"
    t.index ["user_id"], name: "index_account_extracts_on_user_id"
  end

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "bank_id"
    t.boolean "active", default: true
    t.string "agency_number"
    t.string "account_number"
    t.integer "account_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "bank_transactions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "benefited_user_id"
    t.integer "spread_fee_cents"
    t.integer "net_value_cents"
    t.integer "gross_value_cents"
    t.string "description"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_transactions_on_user_id"
  end

  create_table "banks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "state_id"
    t.boolean "capitol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "crypto_currencies", id: :serial, force: :cascade do |t|
    t.string "coin_id"
    t.string "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", id: :serial, force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incomes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "intype"
    t.integer "value_cents"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reference_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "logged_exceptions", id: :serial, force: :cascade do |t|
    t.string "exception_class"
    t.string "controller_name"
    t.string "action_name"
    t.text "message"
    t.text "backtrace"
    t.text "environment"
    t.text "request"
    t.datetime "created_at"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.date "birthday"
    t.integer "gender"
    t.string "mother_name"
    t.string "cpf"
    t.string "rg"
    t.string "phone"
    t.string "address"
    t.string "zipcode"
    t.integer "city_id"
    t.integer "state_id"
    t.string "complement"
    t.string "number"
    t.string "district"
    t.string "address_number"
    t.string "address_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_members_on_city_id"
    t.index ["state_id"], name: "index_members_on_state_id"
  end

  create_table "nobe_revenues", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "description"
    t.integer "value_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bank_transaction_id"
    t.index ["bank_transaction_id"], name: "index_nobe_revenues_on_bank_transaction_id"
    t.index ["user_id"], name: "index_nobe_revenues_on_user_id"
  end

  create_table "outgoings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "outtype"
    t.integer "value_cents"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reference_id"
    t.index ["user_id"], name: "index_outgoings_on_user_id"
  end

  create_table "pagseguro_histories", id: :serial, force: :cascade do |t|
    t.integer "recharge_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recharge_id"], name: "index_pagseguro_histories_on_recharge_id"
  end

  create_table "rate_settings", id: :serial, force: :cascade do |t|
    t.integer "day_of_week"
    t.integer "rate_cents"
    t.integer "alternative_rate_cents"
    t.time "initial_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recharges", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "pagseguro_status", default: 0, null: false
    t.integer "pagseguro_payment_method", default: 0, null: false
    t.integer "gross_value_cents"
    t.integer "discount_value_cents"
    t.decimal "installment_fee_amount", precision: 5, scale: 2
    t.decimal "intermediation_rate_amount", precision: 5, scale: 2
    t.decimal "intermediation_fee_amount", precision: 5, scale: 2
    t.integer "net_value_cents"
    t.integer "extra_value_cents"
    t.integer "installment_count"
    t.integer "item_count"
    t.string "code"
    t.string "payment_method_code"
    t.string "authorizationCode"
    t.string "nsu"
    t.string "tid"
    t.string "establishment_code"
    t.string "acquirer_Name"
    t.string "primary_receiver_key"
    t.datetime "date"
    t.datetime "transaction_date"
    t.datetime "last_event_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recharges_on_user_id"
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "uf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role", default: 1, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.string "payment_password"
    t.index ["member_id"], name: "index_users_on_member_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "account_balances", "users"
  add_foreign_key "account_extracts", "account_balances"
  add_foreign_key "account_extracts", "users"
  add_foreign_key "accounts", "banks"
  add_foreign_key "accounts", "users"
  add_foreign_key "bank_transactions", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "incomes", "users"
  add_foreign_key "members", "cities"
  add_foreign_key "members", "states"
  add_foreign_key "nobe_revenues", "bank_transactions"
  add_foreign_key "nobe_revenues", "users"
  add_foreign_key "outgoings", "users"
  add_foreign_key "pagseguro_histories", "recharges"
  add_foreign_key "recharges", "users"
  add_foreign_key "users", "members"
end
