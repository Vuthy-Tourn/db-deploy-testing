-- Create database (optional if you already specified POSTGRES_DB)
-- CREATE DATABASE mydb;

-- Create table
CREATE TABLE IF NOT EXISTS courses (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    price NUMERIC(10,2),
    status BOOLEAN DEFAULT FALSE
);

-- Insert some sample data
INSERT INTO courses (code, title, price, status) VALUES
('ISTAD-001', 'Spring Boot REST API', 100.00, TRUE),
('ISTAD-002', 'Next.js', 60.00, TRUE),
('ISTAD-003', 'JavaScript', 80.00, TRUE);
