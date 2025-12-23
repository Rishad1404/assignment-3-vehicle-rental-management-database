CREATE TABLE IF NOT EXISTS users (
  id  INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL, 
  phone_number VARCHAR(20),
  role VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS vehicles (
  id INT PRIMARY KEY,
  vehicle_name VARCHAR(100),
  vehicle_type VARCHAR(30),
  model VARCHAR(50),
  registration_number VARCHAR(50) UNIQUE,
  rent_per_day DECIMAL(10,2),
  availability_status VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS bookings (
  booking_id INT PRIMARY KEY,
  user_id INT REFERENCES users(id),
  vehicle_id INT REFERENCES vehicles(id),
  start_date DATE,
  end_date DATE,
  booking_status VARCHAR(20),
  total_cost DECIMAL(10,2)
);

INSERT INTO users (id, name, email, password, phone_number, role) VALUES
(1, 'Alice', 'alice@example.com', 'pass123', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', 'pass123', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', 'pass123', '1122334455', 'Customer');

INSERT INTO vehicles (id, vehicle_name, vehicle_type, model, registration_number, rent_per_day, availability_status) VALUES
(1, 'Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, booking_status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);



SELECT bookings.booking_id,
       users.name AS customer_name,
       vehicles.vehicle_name,
       bookings.start_date,
       bookings.end_date,
       bookings.booking_status
FROM bookings
INNER JOIN users ON bookings.user_id=users.id
INNER JOIN vehicles ON bookings.vehicle_id=vehicles.id;


SELECT * FROM vehicles 
WHERE NOT EXISTS(
  SELECT * FROM bookings
  WHERE bookings.vehicle_id=vehicles.id
)


SELECT *
FROM vehicles
WHERE availability_status = 'available'
AND vehicle_type = 'car';


SELECT vehicles.vehicle_name, 
       COUNT(bookings.booking_id) AS total_bookings
FROM bookings
JOIN vehicles ON bookings.vehicle_id=vehicles.id
GROUP BY vehicles.vehicle_name
HAVING count(bookings.booking_id)>2



