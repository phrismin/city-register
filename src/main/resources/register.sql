DROP TABLE IF EXISTS address_person;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS street;
DROP TABLE IF EXISTS district;


CREATE TABLE district
(
    district_code integer not null,
    district_name varchar(300),
    PRIMARY KEY (district_code)
);

INSERT INTO district (district_code, district_name)
VALUES (1, 'Выборгский');


CREATE TABLE street
(
    street_code integer not null,
    street_name varchar(300),
    PRIMARY KEY (street_code)
);

INSERT INTO street (street_code, street_name)
VALUES (1, 'Сампсоньевский проспект');


CREATE TABLE address
(
    address_id    SERIAL,
    district_code integer     not null,
    street_code   integer     not null,
    building      varchar(10) not null,
    extension     varchar(10),
    apartment     varchar(10),
    PRIMARY KEY (address_id),
    FOREIGN KEY (district_code) REFERENCES district (district_code) ON DELETE RESTRICT,
    FOREIGN KEY (street_code) REFERENCES street (street_code) ON DELETE RESTRICT
);

INSERT INTO address (district_code, street_code, building, extension, apartment)
VALUES (1, 1, '10', '2', '121');
INSERT INTO address (district_code, street_code, building, extension, apartment)
VALUES (1, 1, '271', null, '4');


CREATE TABLE person
(
    person_id          SERIAL,
    sur_name           varchar(100) not null,
    given_name         varchar(100) not null,
    patronymic         varchar(100) not null,
    date_of_birth      date         not null,
    passport_series    varchar(10),
    passport_number    varchar(10),
    passport_date      date,
    certificate_number varchar(10) null,
    certificate_date   date null,
    PRIMARY KEY (person_id)
);

INSERT INTO person (sur_name, given_name, patronymic, date_of_birth,
                    passport_series, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильев', 'Павел', 'Николаевич', '1995-03-18', '1234', '123456', '2015-04-11',
        null, null);

INSERT INTO person (sur_name, given_name, patronymic, date_of_birth,
                    passport_series, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильева', 'Ирина', 'Петровна', '1997-08-21', '4321', '654321', '2017-09-19',
        null, null);

INSERT INTO person (sur_name, given_name, patronymic, date_of_birth,
                    passport_series, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильева', 'Евгения', 'Павловна', '2016-01-11', null, null, null, '456123', '2016-01-21');

INSERT INTO person (sur_name, given_name, patronymic, date_of_birth,
                    passport_series, passport_number, passport_date, certificate_number, certificate_date)
VALUES ('Васильев', 'Александр', 'Павлович', '2018-10-24', null, null, null, '321654', '2018-11-09');


CREATE TABLE address_person
(
    person_address_id SERIAL,
    address_id        integer not null,
    person_id         integer not null,
    start_date        date    not null,
    end_date          date,
    temporal          boolean DEFAULT false,
    PRIMARY KEY (person_address_id),
    FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE RESTRICT
);

INSERT INTO address_person (address_id, person_id, start_date, end_date, temporal)
VALUES (1, 1, '2014-10-12', null, false);

INSERT INTO address_person (address_id, person_id, start_date, end_date)
VALUES (2, 2, '2014-10-12', null);

INSERT INTO address_person (address_id, person_id, start_date, end_date)
VALUES (1, 3, '2016-02-05', null);

INSERT INTO address_person (address_id, person_id, start_date, end_date)
VALUES (1, 4, '2018-12-11', null);
