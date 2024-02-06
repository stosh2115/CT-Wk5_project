CREATE TABLE Customers (
  customer_id SERIAL primary key,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone_number VARCHAR(20),
  email_address VARCHAR(20),
  address VARCHAR(50),
  payment VARCHAR(50)
  
);
CREATE TABLE Car (
  car_id SERIAL PRIMARY KEY,
  price NUMERIC(7,2),
  model VARCHAR(30),
  new_car BOOLEAN,
  customer_id INTEGER,
  CONSTRAINT "FK_Car_customer_id"
    FOREIGN KEY (customer_id)
      REFERENCES Customers(customer_id)
);
CREATE TABLE Mechanics (
  mec_id SERIAL primary key,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone_number VARCHAR(20)

);
CREATE TABLE Service_Ticket (
  service_ticket_id SERIAL primary key,
  service_done VARCHAR(30),
  service_total NUMERIC(6,2),
  service_date DATE,
  mec_id INTEGER,
  car_id INTEGER,
  CONSTRAINT FK_Service_Ticket_car_id
    FOREIGN KEY (car_id)
      REFERENCES Car("car_id"),
  CONSTRAINT FK_Service_Ticket_mec_id
    FOREIGN KEY (mec_id)
      REFERENCES Mechanics(mec_id)
);
CREATE TABLE SalesStaff (
  salesstaff_id SERIAL primary key,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone_number VARCHAR(20),
  email_address VARCHAR(20)
  
);
CREATE TABLE Invoice (
  invoice_id SERIAL PRIMARY KEY,
  invoice_date DATE,
  salesstaff_id INTEGER,
  car_id INTEGER,
  CONSTRAINT FK_Invoice_salesstaff_id
    FOREIGN KEY (salesstaff_id)
      REFERENCES SalesStaff(salesstaff_id),
  CONSTRAINT FK_Invoice_car_id
    FOREIGN KEY (car_id)
      REFERENCES Car(car_id)
);