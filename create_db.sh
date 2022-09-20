# create new database
psql -d postgres -c 'CREATE DATABASE udiddit;'
# connect to new db, create tables and insert data
psql -d udiddit -f bad-db.sql
# explore tables schema
psql udiddit -c '\dt'