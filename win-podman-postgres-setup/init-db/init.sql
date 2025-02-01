-- Create a new schema
CREATE SCHEMA my_schema;

-- Create a new table
CREATE TABLE my_schema.my_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Insert sample data
INSERT INTO my_schema.my_table (name) VALUES ('Sample Data');