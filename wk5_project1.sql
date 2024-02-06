--ADD CUSTOMER
CREATE OR REPLACE FUNCTION insert_customer(
    _first_name VARCHAR,
    _last_name VARCHAR,
    _phone_number VARCHAR,
    _email_address VARCHAR,
    _address VARCHAR,
    _payment VARCHAR
) RETURNS INTEGER AS $$
DECLARE
    customer_id INTEGER;
BEGIN
    INSERT INTO Customers (first_name, last_name, phone_number, email_address, address, payment)
    VALUES (p_first_name, p_last_name, p_phone_number, p_email_address, p_address, p_payment)
    RETURNING customer_id INTO customer_id;

    RETURN customer_id;
END;
$$ LANGUAGE plpgsql;

--ADD CAR
CREATE OR REPLACE FUNCTION insert_car(
    _price NUMERIC,
    _model VARCHAR(30),
    _new_car BOOLEAN,
    _customer_id INTEGER
) RETURNS INTEGER AS $$
DECLARE
    car_id INTEGER;
BEGIN
    INSERT INTO Car (price, model, new_car, customer_id)
    VALUES (p_price, p_model, p_new_car, p_customer_id)
    RETURNING car_id INTO car_id;

    RETURN car_id;
END;
$$ LANGUAGE plpgsql;

--ADD MECHANIC
CREATE OR REPLACE FUNCTION insert_mechanic(
    _first_name VARCHAR,
    _last_name VARCHAR,
    _phone_number VARCHAR
) RETURNS INTEGER AS $$
DECLARE
    mec_id INTEGER;
BEGIN
    INSERT INTO Mechanics (first_name, last_name, phone_number)
    VALUES (p_first_name, p_last_name, p_phone_number)
    RETURNING mec_id INTO mec_id;

    RETURN mec_id;
END;
$$ LANGUAGE plpgsql;

--ADD TICKET
CREATE OR REPLACE FUNCTION insert_service_ticket(
    _service_done VARCHAR,
    _service_total NUMERIC,
    _service_date DATE,
    _mec_id INTEGER,
    _car_id INTEGER
) RETURNS INTEGER AS $$
DECLARE
    service_ticket_id INTEGER;
BEGIN
    INSERT INTO Service_Ticket (service_done, service_total, service_date, mec_id, car_id)
    VALUES (p_service_done, p_service_total, p_service_date, p_mec_id, p_car_id)
    RETURNING service_ticket_id INTO service_ticket_id;

    RETURN service_ticket_id;
END;
$$ LANGUAGE plpgsql;

--ADD Staff
CREATE OR REPLACE FUNCTION insert_sales_staff(
    _first_name VARCHAR,
    _last_name VARCHAR,
    _phone_number VARCHAR,
    _email_address VARCHAR
) RETURNS INTEGER AS $$
DECLARE
    salesstaff_id INTEGER;
BEGIN
    INSERT INTO SalesStaff (first_name, last_name, phone_number, email_address)
    VALUES (p_first_name, p_last_name, p_phone_number, p_email_address)
    RETURNING salesstaff_id INTO salesstaff_id;

    RETURN salesstaff_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_invoice(
    p_invoice_date DATE,
    p_salesstaff_id INTEGER,
    p_car_id INTEGER
) RETURNS VOID AS $$
BEGIN
    
    INSERT INTO Invoice (invoice_date, salesstaff_id, car_id)
    VALUES (p_invoice_date, p_salesstaff_id, p_car_id);

   

    RAISE NOTICE 'Invoice successfull!';

END;
$$ LANGUAGE plpgsql;


ALTER TABLE Car
ADD COLUMN is_serviced BOOLEAN DEFAULT FALSE;


CREATE OR REPLACE PROCEDURE update_serviced_status(_car_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF (SELECT is_serviced FROM Car WHERE Car_ID = _car_id) = FALSE THEN   
        UPDATE Car
        SET is_serviced = TRUE
        WHERE Car_ID = _car_id;
    END IF;
END;
$$;


CALL update_service_status(1);

select *
from car;