require "sequel"

DB = Sequel.connect(adapter: "mysql2", database: DB_NAME, host: DB_HOST,
                    user: DB_USER, password: DB_PASSWORD)

Sequel::Model.plugin :timestamps, update_on_create: true
