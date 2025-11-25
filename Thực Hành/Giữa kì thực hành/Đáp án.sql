-- Bài này làm các câu lẻ tại cô bảo thế
-- CAU 1
SELECT patient_name, date_of_birth, city FROM patients
WHERE gender = 'Female'

-- CAU 3
SELECT medicine_name FROM medicines
WHERE unit_price > 10000

-- CAU 5
SELECT doctor_name, specialization, experience_years FROM doctors
ORDER BY experience_years DESC
LIMIT 3

-- CAU 7
SELECT * FROM invoices
WHERE payment_status = 'Paid' or payment_status = 'Pending'
ORDER BY invoice_date

-- CAU 9
SELECT doctor_name, specialization, experience_years FROM doctors
WHERE experience_years BETWEEN 8 AND 15

-- CAU 11
SELECT DISTINCT city FROM patients

-- CAU 13
SELECT patient_name, date_of_birth, city, insurance_number FROM patients
WHERE city = 'Ho Chi Minh'
    AND gender = 'Female'
    AND insurance_number IS NOT NULL 
    AND (2025 - YEAR(date_of_birth)) BETWEEN 30 AND 50

-- CAU 15
SELECT doctor_name, specialization, phone, experience_years FROM doctors
WHERE email IS NULL
ORDER BY experience_years DESC

-- CAU 17
SELECT medicine_name, medicine_type, unit_price, expiry_date, quantity_in_stock FROM medicines
WHERE expiry_date < "2025-10-21"
ORDER BY expiry_date ASC 

-- CAU 19
SELECT
    status,
    cnt AS so_luong,
    ROUND(100.0 * cnt / SUM(cnt) OVER (), 2) AS ty_le
FROM (
    SELECT status, COUNT(*) AS cnt
    FROM appointments
    GROUP BY status
) AS t
ORDER BY cnt DESC;
