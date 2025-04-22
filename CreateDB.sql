DROP DATABASE IF EXISTS PatientsDB;
CREATE DATABASE PatientsDB;
USE PatientsDB;

CREATE TABLE Nurses (
    nurse_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Rooms (
    room_number INT PRIMARY KEY,
    room_type VARCHAR(50),
    occupancy INT
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    sex CHAR(1),
    visit_reason VARCHAR(255),
    age INT,
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    check_in_date DATE,
    check_out_date DATE,
    doctor_id INT,
    nurse_id INT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (nurse_id) REFERENCES Nurses(nurse_id)
);

CREATE TABLE RoomAssignments (
    patient_id INT,
    room_number INT,
    nurse_id INT,
    PRIMARY KEY (patient_id, room_number),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_number) REFERENCES Rooms(room_number),
    FOREIGN KEY (nurse_id) REFERENCES Nurses(nurse_id)
);

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    service VARCHAR(255),
    date_of_service DATE,
    doctor_id INT,
    patient_id INT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE BillInfo (
    bill_id INT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    service VARCHAR(255),
    date_of_service DATE,
    FOREIGN KEY (bill_id) REFERENCES Bills(bill_id)
);

CREATE TABLE BillDoctorPatient (
    bill_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    FOREIGN KEY (bill_id) REFERENCES Bills(bill_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Services (
    service_name VARCHAR(255),
    date_of_service DATE,
    PRIMARY KEY (service_name, date_of_service)
);

CREATE TABLE DoctorService (
    doctor_id INT,
    service_name VARCHAR(255),
    PRIMARY KEY (doctor_id, service_name),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (service_name) REFERENCES Services(service_name)
);

CREATE TABLE BillService (
    bill_id INT,
    service_name VARCHAR(255),
    total_amount DECIMAL(10, 2),
    PRIMARY KEY (bill_id, service_name),
    FOREIGN KEY (bill_id) REFERENCES Bills(bill_id),
    FOREIGN KEY (service_name) REFERENCES Services(service_name)
);



