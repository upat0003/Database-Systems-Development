-- Generated by Oracle SQL Developer Data Modeler 19.1.0.081.0911
--   at:        2019-05-01 22:32:37 AEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g
--   id:        29143926
--   Name:      Utkarsh Patel
--   Authcate:  upat0003
--   Unit Code: FIT-2093

set echo on
spool ./mc_schema_output.txt


DROP SEQUENCE customer_customer_id_sequencess;

DROP SEQUENCE housekeeper_housekeeper_id_sequencess;

DROP SEQUENCE houseshare_facility_houseshare_sequencess;

DROP SEQUENCE tour_guide_detail_tour_guide_id_sqeuencess;



DROP TABLE activity_details CASCADE CONSTRAINTS;

DROP TABLE cost_centre CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE customer_check_in CASCADE CONSTRAINTS;

DROP TABLE housekeeper CASCADE CONSTRAINTS;

DROP TABLE housekeeper_assigning CASCADE CONSTRAINTS;

DROP TABLE houseshare_facility CASCADE CONSTRAINTS;

DROP TABLE item CASCADE CONSTRAINTS;

DROP TABLE room CASCADE CONSTRAINTS;

DROP TABLE tour_guide_detail CASCADE CONSTRAINTS;

DROP TABLE tour_guide_specialisation CASCADE CONSTRAINTS;

CREATE TABLE activity_details (
    activity_performed_date_time       DATE NOT NULL,
    activity_current_standard_cost     NUMBER(5, 2) NOT NULL,
    activity_name                      VARCHAR2(50) NOT NULL,
    activity_description               VARCHAR2(50) NOT NULL,
    activity_code                      NUMBER(5) NOT NULL,
    "Activity_time_required_(Hours)"   NUMBER(3, 2) NOT NULL,
    customer_id                        NUMBER(6) NOT NULL,
    tour_guide_id                      NUMBER(4) NOT NULL,
    check_in_date_time                 DATE NOT NULL
);

COMMENT ON COLUMN activity_details.activity_performed_date_time IS
    'The date and time activity took place is recorded in Activity_performed_date_time.';

COMMENT ON COLUMN activity_details.activity_current_standard_cost IS
    'Activity_current_standard_cost is the charge to the customer for activity which is counted based on the date/time of the activity and activity code.'
    ;

COMMENT ON COLUMN activity_details.activity_name IS
    'Activity_name is the name of the activity which is identified by the code of the activity';

COMMENT ON COLUMN activity_details.activity_description IS
    'Activity_description has all the description for the activity which contains the full activity details';

COMMENT ON COLUMN activity_details.activity_code IS
    'Activity_code is the 5 digit code uniquely allocated by AirTnT to all the activities. So, it will be used to uniquely identify all the activities and it''s primary key for Activity_details '
    ;

COMMENT ON COLUMN activity_details."Activity_time_required_(Hours)" IS
    'Activity_time_required_[Hours] is recorded in hours which gives information of how long it took to perfrom this activity';

COMMENT ON COLUMN activity_details.customer_id IS
    'Customer_id is the numerical ( 6 digits)  unique id for the customer which is used to identify them so it''s primary key as it will be unique.'
    ;

COMMENT ON COLUMN activity_details.tour_guide_id IS
    'Tour_guide_id uniquely identifies all the tour guides so it''s primary key. It''s 4 digit numerical number allocated to all the tour guides'
    ;

COMMENT ON COLUMN activity_details.check_in_date_time IS
    'Check_in_date_time is the derived attribute having date and time of the customer check in. It will be primary because it will uniquely identify the date and time of check-in for each customer.'
    ;

ALTER TABLE activity_details
    ADD CONSTRAINT activity_details_pk PRIMARY KEY ( customer_id,
                                                     check_in_date_time,
                                                     activity_performed_date_time,
                                                     activity_code );

CREATE TABLE cost_centre (
    cost_centre_code         VARCHAR2(20) NOT NULL,
    cost_centre_title        VARCHAR2(50) NOT NULL,
    admin_team_member_name   VARCHAR2(50) NOT NULL,
    item_current_stock       NUMBER(5) NOT NULL
);

ALTER TABLE cost_centre ADD CONSTRAINT cost_centre_stock CHECK ( item_current_stock > - 1 );

COMMENT ON COLUMN cost_centre.cost_centre_code IS
    'Cost centre is uniquely identified by Cost_centre_id which is primary key. Multiple items can be assigned to the cost centre.'
    ;

COMMENT ON COLUMN cost_centre.cost_centre_title IS
    'Cost_centre_title is the the name of the cost centre where items are assigned. Cosr centre works as having section of items and this section is named by Cost_centre_title. '
    ;

COMMENT ON COLUMN cost_centre.admin_team_member_name IS
    'Admin team member name is in charge of buying item stock whenever cost centre is running out of items. The person is identified by Admin_team_member_name.'
    ;

COMMENT ON COLUMN cost_centre.item_current_stock IS
    'Item_current_stock is the current available items in the cost centre.';

ALTER TABLE cost_centre ADD CONSTRAINT cost_centre_pk PRIMARY KEY ( cost_centre_code );

CREATE TABLE customer (
    customer_id                     NUMBER(6) NOT NULL,
    customer_fname                  VARCHAR2(50) NOT NULL,
    customer_lname                  VARCHAR2(50) NOT NULL,
    customer_address                VARCHAR2(50) NOT NULL,
    customer_dob                    DATE NOT NULL,
    customer_passport_no            VARCHAR2(10) NOT NULL,
    customer_b_acc_no               VARCHAR2(50) NOT NULL,
    customer_current_mobile_no      CHAR(10) NOT NULL,
    customer_emergency_contact_no   CHAR(10) NOT NULL,
    check_out_date_time             DATE NOT NULL
);

COMMENT ON COLUMN customer.customer_id IS
    'Customer_id is the numerical ( 6 digits)  unique id for the customer which is used to identify them so it''s primary key as it will be unique.'
    ;

COMMENT ON COLUMN customer.customer_fname IS
    'Customer_fname is the first name of the customer limited to 50 letters.';

COMMENT ON COLUMN customer.customer_lname IS
    'Customer_lname is the last name of the customerlimited to 50 letters.';

COMMENT ON COLUMN customer.customer_address IS
    'Customer_address is the home address  of the customer limited to 50 letters.';

COMMENT ON COLUMN customer.customer_dob IS
    'Customer_dob is the date of birth of the customer';

COMMENT ON COLUMN customer.customer_passport_no IS
    'Customer_passport_no is the passport no of the customer which is used to identify the customer details. It is used in the case of identity verification and it is the unique identifier'
    ;

COMMENT ON COLUMN customer.customer_b_acc_no IS
    '(Customer_B_Acc_No) Customer_bank_account_holder_name is the name of the bank account held by customer. It is used to identify the payment verification. Whenever customer pays for the bill, Customer_bank_account_holder_name is used to uniquely verify the payment details. '
    ;

COMMENT ON COLUMN customer.customer_current_mobile_no IS
    'Customer_current_mobile_no is the mobile number of the customer which must be 10 digits.';

COMMENT ON COLUMN customer.customer_emergency_contact_no IS
    'Customer_emergency_contact_no is the mobile number of the customer that may be used in case of the customer emergency which must be 10 digits.'
    ;

COMMENT ON COLUMN customer.check_out_date_time IS
    'Check_out_date_time records the time and date when customer checks out of the facility.';

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customer_id );

CREATE TABLE customer_check_in (
    check_in_date_time   DATE NOT NULL,
    customer_id          NUMBER(6) NOT NULL,
    tour_guide_id        NUMBER(4) NOT NULL
);

COMMENT ON COLUMN customer_check_in.check_in_date_time IS
    'Check_in_date_time is the derived attribute having date and time of the customer check in. It will be primary because it will uniquely identify the date and time of check-in for each customer.'
    ;

COMMENT ON COLUMN customer_check_in.customer_id IS
    'Customer_id is the numerical ( 6 digits)  unique id for the customer which is used to identify them so it''s primary key as it will be unique.'
    ;

COMMENT ON COLUMN customer_check_in.tour_guide_id IS
    'Tour_guide_id uniquely identifies all the tour guides so it''s primary key. It''s 4 digit numerical number allocated to all the tour guides'
    ;

ALTER TABLE customer_check_in ADD CONSTRAINT customer_check_in_pk PRIMARY KEY ( customer_id,
                                                                                check_in_date_time );

CREATE TABLE housekeeper (
    housekeeper_id                  NUMBER(4) NOT NULL,
    housekeeper_fname               VARCHAR2(50) NOT NULL,
    housekeeper_lname               VARCHAR2(50) NOT NULL,
    housekeeper_contact_no          CHAR(10) NOT NULL,
    housekeeper_police_check_code   VARCHAR2(20) NOT NULL,
    housekeeper_bcc                 CHAR(1) NOT NULL
);

COMMENT ON COLUMN housekeeper.housekeeper_id IS
    'HouseKeeper_id is the 4 digit numeric assigned to each houseKeeper which is used to identify all the houseKeeper. It;s unique so HouseKeeper_id will be primary key'
    ;

COMMENT ON COLUMN housekeeper.housekeeper_fname IS
    'HouseKeeper_fname is the first name of the particular houseKeeper';

COMMENT ON COLUMN housekeeper.housekeeper_lname IS
    'HouseKeeper_lname is the last name of the particular houseKeeper';

COMMENT ON COLUMN housekeeper.housekeeper_contact_no IS
    'HouseKeeper_contact_no is the contact number  of the particular houseKeeper';

COMMENT ON COLUMN housekeeper.housekeeper_police_check_code IS
    'HouseKeeper_police_check_code is the alphanumberical police Check code number if it''s available for houseKeeper.';

COMMENT ON COLUMN housekeeper.housekeeper_bcc IS
    'HouseKeeper_Bankruptcy_check_passed[BCC] is the boolean used to check whether Bankruptcy check is passed for houseKeeper.It''s recorded as yes or no'
    ;

ALTER TABLE housekeeper ADD CONSTRAINT housekeeper_pk PRIMARY KEY ( housekeeper_id );

CREATE TABLE housekeeper_assigning (
    housekeeper_assigned_date    DATE NOT NULL,
    housekeeper_completed_date   DATE NOT NULL,
    housekeeper_id               NUMBER(4) NOT NULL,
    houseshare_code              NUMBER(5) NOT NULL
);

COMMENT ON COLUMN housekeeper_assigning.housekeeper_assigned_date IS
    'HouseKeeper_assigned_date is the date when houseKeeper are assigned to houseShare and it''s recorded';

COMMENT ON COLUMN housekeeper_assigning.housekeeper_completed_date IS
    'HouseKeeper_completed_date is the completed date when the houseKeeper is done with working in the particular houseShare';

COMMENT ON COLUMN housekeeper_assigning.housekeeper_id IS
    'HouseKeeper_id is the 4 digit numeric assigned to each houseKeeper which is used to identify all the houseKeeper. It;s unique so HouseKeeper_id will be primary key'
    ;

COMMENT ON COLUMN housekeeper_assigning.houseshare_code IS
    'HouseShare is identified by HouseShare_code. All the houseShare are assigned unique numerical code so it''s primary for houseShare_facility.'
    ;

CREATE UNIQUE INDEX housekeeper_assigning__idx ON
    housekeeper_assigning (
        housekeeper_id
    ASC );

ALTER TABLE housekeeper_assigning
    ADD CONSTRAINT housekeeper_assigning_pk PRIMARY KEY ( houseshare_code,
                                                          housekeeper_id,
                                                          housekeeper_assigned_date );

CREATE TABLE houseshare_facility (
    houseshare_code          NUMBER(5) NOT NULL,
    houseshare_name          VARCHAR2(50) NOT NULL,
    houseshare_total_rooms   NUMBER(2) NOT NULL,
    houseshare_avail_rooms   NUMBER(2) NOT NULL
);

ALTER TABLE houseshare_facility ADD CONSTRAINT houseshare_rooms CHECK ( houseshare_total_rooms > 0 );

COMMENT ON COLUMN houseshare_facility.houseshare_code IS
    'HouseShare is identified by HouseShare_code. All the houseShare are assigned unique numerical code so it''s primary for houseShare_facility.'
    ;

COMMENT ON COLUMN houseshare_facility.houseshare_name IS
    'HouseShare_name has the name of the houseShare which is based on houseShare_code.';

COMMENT ON COLUMN houseshare_facility.houseshare_total_rooms IS
    'HouseShare is having multiple rooms so HouseShare_total_rooms will give the number of rooms in total for the given houseShare'
    ;

COMMENT ON COLUMN houseshare_facility.houseshare_avail_rooms IS
    ' HouseShare_availl_rooms will give the number of rooms availablle for the given houseShare and it''s recorded by this.';

ALTER TABLE houseshare_facility ADD CONSTRAINT houseshare_facility_pk PRIMARY KEY ( houseshare_code );

CREATE TABLE item (
    item_code                      VARCHAR2(15) NOT NULL,
    item_name                      VARCHAR2(50) NOT NULL,
    item_description               VARCHAR2(50) NOT NULL,
    item_used_quantity             NUMBER(4) NOT NULL,
    item_price                     NUMBER(5, 2) NOT NULL,
    customer_id                    NUMBER(6) NOT NULL,
    cost_centre_code               VARCHAR2(20) NOT NULL,
    item_price_total_extra         NUMBER(5, 2) NOT NULL,
    check_in_date_time             DATE NOT NULL,
    activity_performed_date_time   DATE NOT NULL,
    activity_code                  NUMBER(5) NOT NULL
);

ALTER TABLE item ADD CONSTRAINT item_iuq CHECK ( item_used_quantity > 0 );

COMMENT ON COLUMN item.item_code IS
    'Item is uniquely identified by the Item_code so it''s primary key. Item code can be the code of combination of numbers and letters.'
    ;

COMMENT ON COLUMN item.item_name IS
    'Item_name is identified by item code which is based on the primary key.';

COMMENT ON COLUMN item.item_description IS
    'Item_description has all the description of item in detail of the given item being used in the activity';

COMMENT ON COLUMN item.item_used_quantity IS
    'The number of item used in the activity is Item_used_quantity and that depends on the customer and activity details.';

COMMENT ON COLUMN item.item_price IS
    'Item_price is identified Item details and quantity too. The customers are charged based on the item they used.The price will vary based on the quantity being used'
    ;

COMMENT ON COLUMN item.customer_id IS
    'Customer_id is the numerical ( 6 digits)  unique id for the customer which is used to identify them so it''s primary key as it will be unique.'
    ;

COMMENT ON COLUMN item.cost_centre_code IS
    'Cost centre is uniquely identified by Cost_centre_id which is primary key. Multiple items can be assigned to the cost centre.'
    ;

COMMENT ON COLUMN item.item_price_total_extra IS
    'Item_price_total_extra is derived attributed which is counted based on item price and quantity. So it''s recorded as total extra charge for using the item in the activity. '
    ;

COMMENT ON COLUMN item.check_in_date_time IS
    'Check_in_date_time is the derived attribute having date and time of the customer check in. It will be primary because it will uniquely identify the date and time of check-in for each customer.'
    ;

COMMENT ON COLUMN item.activity_performed_date_time IS
    'The date and time activity took place is recorded in Activity_performed_date_time.';

COMMENT ON COLUMN item.activity_code IS
    'Activity_code is the 5 digit code uniquely allocated by AirTnT to all the activities. So, it will be used to uniquely identify all the activities and it''s primary key for Activity_details '
    ;

ALTER TABLE item
    ADD CONSTRAINT item_pk PRIMARY KEY ( customer_id,
                                         check_in_date_time,
                                         activity_performed_date_time,
                                         activity_code,
                                         item_code );

CREATE TABLE room (
    room_number          NUMBER(2) NOT NULL,
    room_voip_no         CHAR(10) NOT NULL,
    room_type            VARCHAR2(50) NOT NULL,
    houseshare_code      NUMBER(5) NOT NULL,
    customer_id          NUMBER(6) NOT NULL,
    check_in_date_time   DATE NOT NULL
);

ALTER TABLE room ADD CONSTRAINT room_no CHECK ( room_number > 0 );

COMMENT ON COLUMN room.room_number IS
    'Room_number is identified by Room number and the houseShare code so they are the primary keys for the Room entity. Room number starts from 1.'
    ;

COMMENT ON COLUMN room.room_voip_no IS
    'Room_VOIP_no is installed in some rooms but  not mandatory in every rooms so it can be null.';

COMMENT ON COLUMN room.room_type IS
    'Room_type is the type of room so it can be fixed plan or open plan or any other type. fixed_pan=0 and open_plan=1';

COMMENT ON COLUMN room.houseshare_code IS
    'HouseShare is identified by HouseShare_code. All the houseShare are assigned unique numerical code so it''s primary for houseShare_facility.'
    ;

COMMENT ON COLUMN room.customer_id IS
    'Customer_id is the numerical ( 6 digits)  unique id for the customer which is used to identify them so it''s primary key as it will be unique.'
    ;

COMMENT ON COLUMN room.check_in_date_time IS
    'Check_in_date_time is the derived attribute having date and time of the customer check in. It will be primary because it will uniquely identify the date and time of check-in for each customer.'
    ;

ALTER TABLE room
    ADD CONSTRAINT room_pk PRIMARY KEY ( customer_id,
                                         check_in_date_time,
                                         room_number,
                                         houseshare_code );

CREATE TABLE tour_guide_detail (
    tour_guide_id                  NUMBER(4) NOT NULL,
    tour_guide_fname               VARCHAR2(50) NOT NULL,
    tour_guide_lname               VARCHAR2(50) NOT NULL,
    tour_guide_insta_handler       VARCHAR2(20) NOT NULL,
    customer_id                    NUMBER(6) NOT NULL,
    check_in_date_time             DATE NOT NULL,
    activity_performed_date_time   DATE NOT NULL,
    activity_code                  NUMBER(5) NOT NULL
);

COMMENT ON COLUMN tour_guide_detail.tour_guide_id IS
    'Tour_guide_id uniquely identifies all the tour guides so it''s primary key. It''s 4 digit numerical number allocated to all the tour guides'
    ;

COMMENT ON COLUMN tour_guide_detail.tour_guide_fname IS
    'Tour_guide_fname is the first name of the tour guide ';

COMMENT ON COLUMN tour_guide_detail.tour_guide_lname IS
    'Tour_guide_lname is the last name of the tour guide ';

COMMENT ON COLUMN tour_guide_detail.tour_guide_insta_handler IS
    'Tour_guide_insta_handler  is the instagram id  of the tour guide which will have all the instagram posts and stories covered by tour guide '
    ;

COMMENT ON COLUMN tour_guide_detail.customer_id IS
    'Customer_id is the numerical ( 6 digits)  unique id for the customer which is used to identify them so it''s primary key as it will be unique.'
    ;

COMMENT ON COLUMN tour_guide_detail.check_in_date_time IS
    'Check_in_date_time is the derived attribute having date and time of the customer check in. It will be primary because it will uniquely identify the date and time of check-in for each customer.'
    ;

COMMENT ON COLUMN tour_guide_detail.activity_performed_date_time IS
    'The date and time activity took place is recorded in Activity_performed_date_time.';

COMMENT ON COLUMN tour_guide_detail.activity_code IS
    'Activity_code is the 5 digit code uniquely allocated by AirTnT to all the activities. So, it will be used to uniquely identify all the activities and it''s primary key for Activity_details '
    ;

CREATE UNIQUE INDEX tour_guide_detail__idx ON
    tour_guide_detail (
        customer_id
    ASC,
        check_in_date_time
    ASC,
        activity_performed_date_time
    ASC,
        activity_code
    ASC );

ALTER TABLE tour_guide_detail ADD CONSTRAINT tour_guide_detail_pk PRIMARY KEY ( tour_guide_id );

CREATE TABLE tour_guide_specialisation (
    specialisation_name   VARCHAR2(50) NOT NULL,
    tour_guide_id         NUMBER(4) NOT NULL
);

COMMENT ON COLUMN tour_guide_specialisation.specialisation_name IS
    'Specialisation_name is all the names for specialisation and tour guide have got one or many specialisation';

COMMENT ON COLUMN tour_guide_specialisation.tour_guide_id IS
    'Tour_guide_id uniquely identifies all the tour guides so it''s primary key. It''s 4 digit numerical number allocated to all the tour guides'
    ;

ALTER TABLE tour_guide_specialisation ADD CONSTRAINT tour_guide_specialisation_pk PRIMARY KEY ( tour_guide_id,
                                                                                                specialisation_name );

ALTER TABLE activity_details
    ADD CONSTRAINT activities_check_in FOREIGN KEY ( customer_id,
                                                     check_in_date_time )
        REFERENCES customer_check_in ( customer_id,
                                       check_in_date_time );

ALTER TABLE activity_details
    ADD CONSTRAINT activity_managed_by FOREIGN KEY ( tour_guide_id )
        REFERENCES tour_guide_detail ( tour_guide_id );

ALTER TABLE item
    ADD CONSTRAINT activity_may_require_item FOREIGN KEY ( customer_id,
                                                           check_in_date_time,
                                                           activity_performed_date_time,
                                                           activity_code )
        REFERENCES activity_details ( customer_id,
                                      check_in_date_time,
                                      activity_performed_date_time,
                                      activity_code );

ALTER TABLE tour_guide_detail
    ADD CONSTRAINT activity_performed_by FOREIGN KEY ( customer_id,
                                                       check_in_date_time,
                                                       activity_performed_date_time,
                                                       activity_code )
        REFERENCES activity_details ( customer_id,
                                      check_in_date_time,
                                      activity_performed_date_time,
                                      activity_code );

ALTER TABLE customer_check_in
    ADD CONSTRAINT customer_checking_in FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id );

ALTER TABLE housekeeper_assigning
    ADD CONSTRAINT housekeeper_allocated FOREIGN KEY ( housekeeper_id )
        REFERENCES housekeeper ( housekeeper_id );

ALTER TABLE housekeeper_assigning
    ADD CONSTRAINT houseshare_assigned FOREIGN KEY ( houseshare_code )
        REFERENCES houseshare_facility ( houseshare_code );

ALTER TABLE room
    ADD CONSTRAINT houseshare_having_room FOREIGN KEY ( houseshare_code )
        REFERENCES houseshare_facility ( houseshare_code );

ALTER TABLE item
    ADD CONSTRAINT item_cost_centre FOREIGN KEY ( cost_centre_code )
        REFERENCES cost_centre ( cost_centre_code )
            ON DELETE CASCADE;

ALTER TABLE customer_check_in
    ADD CONSTRAINT main_tour_guide FOREIGN KEY ( tour_guide_id )
        REFERENCES tour_guide_detail ( tour_guide_id );

ALTER TABLE room
    ADD CONSTRAINT rooms_assigned_at_check_in FOREIGN KEY ( customer_id,
                                                            check_in_date_time )
        REFERENCES customer_check_in ( customer_id,
                                       check_in_date_time )
            ON DELETE CASCADE;

ALTER TABLE tour_guide_specialisation
    ADD CONSTRAINT tour_guide_specialising FOREIGN KEY ( tour_guide_id )
        REFERENCES tour_guide_detail ( tour_guide_id );

CREATE SEQUENCE customer_customer_id_sequencess  START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE housekeeper_housekeeper_id_sequencess START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE houseshare_facility_houseshare_sequencess   START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE tour_guide_detail_tour_guide_id_sqeuencess   START WITH 1 NOCACHE ORDER;

spool off
set echo off



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             2
-- ALTER TABLE                             27
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          4
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
