# force delete database if exist
psql -d postgres -c 'DROP DATABASE udiddit WITH (FORCE);'
# create new database
psql -d postgres -c 'CREATE DATABASE udiddit;'
# import data from bad db
psql -d udiddit -f bad-db.sql
# create new database schema
psql -d udiddit -f udiddit_DDL.sql
# migrate data
psql -d udiddit -f udiddit_DML.sql
# delete tables after data migration
psql -d udiddit -c 'DROP TABLE bad_comments;'
psql -d udiddit -c 'DROP TABLE bad_posts;'
# explore tables schema
psql udiddit -c '\dt'
# connect to database
psql udiddit
