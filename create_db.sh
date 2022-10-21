# force delete database if exist
psql -d postgres -c 'DROP DATABASE udiddit WITH (FORCE);'
# create new database
psql -d postgres -c 'CREATE DATABASE udiddit;'
# connect to new db, create tables and insert data
psql -d udiddit -f bad-db.sql
# create new database schema
psql -d udiddit -f udiddit_DDL.sql
# explore tables schema
psql udiddit -c '\dt'
# connect to database
psql udiddit