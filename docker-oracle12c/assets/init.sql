SET TERMOUT OFF;
SET VERIFY OFF;
SET SQLBLANKLINES ON;
SET HEAD OFF /* This turns of the headers in result */
SET FEEDBACK OFF /* Turns off the result feedback */
grant create session, create table to test_dpump identified by test;
create or replace directory DATA_PUMP_DIR as '/usr/local/oracle/dumps/';
grant read, write on directory DATA_PUMP_DIR to test_dpump;