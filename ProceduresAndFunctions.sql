CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2)
);

-- Insert sample data
INSERT INTO employees (emp_name, department, salary) VALUES
('Alice', 'IT', 60000),
('Bob', 'HR', 50000),
('Charlie', 'Finance', 70000),
('David', 'IT', 65000);

CREATE OR REPLACE PROCEDURE give_raise(dept_name VARCHAR, raise_percent NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees
    SET salary = salary + (salary * raise_percent / 100)
    WHERE department = dept_name;

    RAISE NOTICE 'Salary updated for department: %', dept_name;
END;
$$;

-- Execute procedure
CALL give_raise('IT', 10); -- 10% raise for IT department

CREATE OR REPLACE FUNCTION get_total_salary(dept_name VARCHAR)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total_sal NUMERIC;
BEGIN
    SELECT SUM(salary) INTO total_sal
    FROM employees
    WHERE department = dept_name;

    RETURN total_sal;
END;
$$;

-- Call function
SELECT get_total_salary('IT');
