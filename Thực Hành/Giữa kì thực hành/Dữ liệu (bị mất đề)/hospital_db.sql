-- ============================================
-- TẠO CƠSỞ DỮ LIỆU QUẢN LÝ BỆNH VIỆN
-- ============================================
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- ============================================
-- TẠO BẢNG PHÒNG BAN
-- ============================================
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    head_doctor VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG BÁC SĨ
-- ============================================
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    doctor_name VARCHAR(150) NOT NULL,
    department_id INT NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    license_number VARCHAR(50) UNIQUE,
    experience_years INT,
    status VARCHAR(30) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_doctor_department FOREIGN KEY (department_id)
        REFERENCES departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG Y TÁ
-- ============================================
CREATE TABLE nurses (
    nurse_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nurse_name VARCHAR(150) NOT NULL,
    department_id INT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    license_number VARCHAR(50) UNIQUE,
    shift VARCHAR(30),
    status VARCHAR(30) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_nurse_department FOREIGN KEY (department_id)
        REFERENCES departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG BỆNH NHÂN
-- ============================================
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    patient_name VARCHAR(150) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(50),
    insurance_number VARCHAR(50),
    blood_type VARCHAR(10),
    emergency_contact VARCHAR(150),
    emergency_contact_phone VARCHAR(20),
    status VARCHAR(30) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- TẠO BẢNG KHÁM BỆNH
-- ============================================
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    department_id INT NOT NULL,
    reason_for_visit VARCHAR(255),
    status VARCHAR(30) DEFAULT 'Scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_department FOREIGN KEY (department_id)
        REFERENCES departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG NHẬP VIỆN
-- ============================================
CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    room_number VARCHAR(20),
    bed_number VARCHAR(10),
    admission_reason VARCHAR(255),
    diagnosis VARCHAR(255),
    status VARCHAR(30) DEFAULT 'Admitted',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_admission_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_admission_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_admission_department FOREIGN KEY (department_id)
        REFERENCES departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG BỆNH
-- ============================================
CREATE TABLE diseases (
    disease_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    disease_name VARCHAR(150) NOT NULL UNIQUE,
    disease_code VARCHAR(20) UNIQUE,
    description TEXT,
    severity_level VARCHAR(30),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG TIỀN SỬ BỆNH
-- ============================================
CREATE TABLE medical_history (
    history_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    patient_id INT NOT NULL,
    disease_id INT NOT NULL,
    diagnosis_date DATE NOT NULL,
    treatment VARCHAR(255),
    outcome VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_history_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_history_disease FOREIGN KEY (disease_id)
        REFERENCES diseases(disease_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG THUỐC
-- ============================================
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    medicine_name VARCHAR(150) NOT NULL UNIQUE,
    medicine_type VARCHAR(50),
    manufacturer VARCHAR(100),
    unit_price DECIMAL(10,2) NOT NULL,
    quantity_in_stock INT DEFAULT 0,
    expiry_date DATE,
    side_effects TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG ĐƠN THUỐC
-- ============================================
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    notes TEXT,
    status VARCHAR(30) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_prescription_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_prescription_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG CHI TIẾT ĐƠN THUỐC
-- ============================================
CREATE TABLE prescription_details (
    detail_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    prescription_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(50),
    frequency VARCHAR(100),
    duration_days INT,
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_detail_prescription FOREIGN KEY (prescription_id)
        REFERENCES prescriptions(prescription_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detail_medicine FOREIGN KEY (medicine_id)
        REFERENCES medicines(medicine_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- TẠO BẢNG HÓA ĐƠN
-- ============================================
CREATE TABLE invoices (
    invoice_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    patient_id INT NOT NULL,
    admission_id INT,
    appointment_id INT,
    invoice_date DATE NOT NULL,
    consultation_fee DECIMAL(10,2) DEFAULT 0,
    medicine_cost DECIMAL(10,2) DEFAULT 0,
    hospitalization_cost DECIMAL(10,2) DEFAULT 0,
    other_charges DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(15,2) DEFAULT 0,
    paid_amount DECIMAL(15,2) DEFAULT 0,
    payment_status VARCHAR(30) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_invoice_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_admission FOREIGN KEY (admission_id)
        REFERENCES admissions(admission_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET FOREIGN_KEY_CHECKS=0;
-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG DEPARTMENTS
-- ============================================
INSERT INTO departments (department_name, description, head_doctor, phone) VALUES
('Cardiology', 'Khoa Tim Mạch', 'Dr. Nguyen Tuan', '0901234567'),
('Neurology', 'Khoa Thần Kinh', 'Dr. Tran Hoa', '0912345678'),
('Orthopedics', 'Khoa Chỉnh Hình Xương', 'Dr. Le Minh', '0923456789'),
('General Surgery', 'Khoa Phẫu Thuật Tổng Quát', 'Dr. Pham Duc', '0934567890'),
('Pediatrics', 'Khoa Nhi', 'Dr. Hoang Linh', '0945678901'),
('Internal Medicine', 'Khoa Nội', 'Dr. Vu Long', '0956789012');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG DOCTORS
-- ============================================
INSERT INTO doctors (doctor_name, department_id, specialization, phone, email, license_number, experience_years, status) VALUES
('Dr. Nguyen Tuan', 1, 'Interventional Cardiology', '0901234567', 'tuan.nguyen@hospital.com', 'LIC001', 15, 'Active'),
('Dr. Tran Hoa', 2, 'Neurosurgery', '0912345678', 'hoa.tran@hospital.com', 'LIC002', 12, 'Active'),
('Dr. Le Minh', 3, 'Sports Medicine', '0923456789', 'minh.le@hospital.com', 'LIC003', 10, 'Active'),
('Dr. Pham Duc', 4, 'General Surgery', '0934567890', 'duc.pham@hospital.com', 'LIC004', 20, 'Active'),
('Dr. Hoang Linh', 5, 'Pediatric Care', '0945678901', 'linh.hoang@hospital.com', 'LIC005', 8, 'Active'),
('Dr. Vu Long', 6, 'Internal Medicine', '0956789012', 'long.vu@hospital.com', 'LIC006', 18, 'Active'),
('Dr. Tran Binh', 1, 'General Cardiology', '0967890123', 'binh.tran@hospital.com', 'LIC007', 7, 'Active'),
('Dr. Ngo Thao', 2, 'Neurology', '0978901234', 'thao.ngo@hospital.com', 'LIC008', 9, 'Active');

INSERT INTO doctors (doctor_name, department_id, specialization, phone, email, license_number, experience_years, status) 
VALUES
('Dr. Tran Anh Tuan', 1, 'Cardiac Surgery', '0989111111', NULL, 'LIC009', 25, 'Active'),
('Dr. Pham Van Hung', 2, 'Neurological Surgery', '0989222222', NULL, 'LIC010', 22, 'Active'),
('Dr. Le Thi Lan', 3, 'Orthopedic Specialist', '0989333333', NULL, 'LIC011', 16, 'Active'),
('Dr. Nguyen Duc Khanh', 1, 'Interventional Cardiology', '0989444444', NULL, 'LIC012', 18, 'Active'),
('Dr. Hoang Minh Trung', 4, 'General Surgery', '0989555555', NULL, 'LIC013', 20, 'Active'),
('Dr. Tran Thanh Hoa', 5, 'Pediatric Surgery', '0989666666', NULL, 'LIC014', 14, 'Active'),
('Dr. Vu Tuan Anh', 2, 'Neurology', '0989777777', NULL, 'LIC015', 11, 'Active'),
('Dr. Pham Linh Chi', 6, 'Gastroenterology', '0989888888', NULL, 'LIC016', 19, 'Active'),
('Dr. Le Kim Ngan', 1, 'Cardiology', '0989999999', NULL, 'LIC017', 17, 'Active'),
('Dr. Do Minh Duc', 3, 'Sports Orthopedic', '0988111111', NULL, 'LIC018', 13, 'Active');


-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG NURSES
-- ============================================
INSERT INTO nurses (nurse_name, department_id, phone, email, license_number, shift, status) VALUES
('Nurse Tran Hanh', 1, '0901111111', 'hanh.tran@hospital.com', 'NUR001', 'Morning', 'Active'),
('Nurse Pham Lan', 1, '0912222222', 'lan.pham@hospital.com', 'NUR002', 'Evening', 'Active'),
('Nurse Ngo Huong', 2, '0923333333', 'huong.ngo@hospital.com', 'NUR003', 'Night', 'Active'),
('Nurse Dang Thuy', 3, '0934444444', 'thuy.dang@hospital.com', 'NUR004', 'Morning', 'Active'),
('Nurse Le Quy', 4, '0945555555', 'quy.le@hospital.com', 'NUR005', 'Evening', 'Active'),
('Nurse Vu Minh', 5, '0956666666', 'minh.vu@hospital.com', 'NUR006', 'Morning', 'Active');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG PATIENTS
-- ============================================
INSERT INTO patients (patient_name, date_of_birth, gender, phone, email, address, city, insurance_number, blood_type, emergency_contact, emergency_contact_phone, status) 
VALUES
('Nguyen Van Anh', '1980-05-15', 'Male', '0987654321', 'anh.nguyen@email.com', '123 Nguyen Hue', 'Ho Chi Minh', 'INS001', 'O+', 'Tran Thu Ha', '0912345678', 'Active'),
('Tran Thi Huong', '1985-08-22', 'Female', '0987654322', 'huong.tran@email.com', '456 Tran Hung Dao', 'Hanoi', 'INS002', 'A+', 'Nguyen Van B', '0923456789', 'Active'),
('Le Van Minh', '1990-03-10', 'Male', '0987654323', 'minh.le@email.com', '789 Le Loi', 'Da Nang', 'INS003', 'B+', 'Le Thi Hoa', '0934567890', 'Active'),
('Pham Thi Yen', '1992-11-25', 'Female', '0987654324', 'yen.pham@email.com', '321 Pham Ngu Lao', 'Ho Chi Minh', 'INS004', 'AB+', 'Pham Van C', '0945678901', 'Active'),
('Vu Van Duc', '1988-06-08', 'Male', '0987654325', 'duc.vu@email.com', '654 Vu Tru', 'Hanoi', 'INS005', 'O+', 'Vu Thi Lan', '0956789012', 'Active'),
('Hoang Thi Mai', '1995-01-30', 'Female', '0987654326', 'mai.hoang@email.com', '987 Hoang Van Thu', 'Can Tho', 'INS006', 'A-', 'Hoang Van D', '0967890123', 'Active'),
('Do Van Khanh', '1982-09-12', 'Male', '0987654327', 'khanh.do@email.com', '147 Do Quang Dau', 'Ho Chi Minh', 'INS007', 'B-', 'Do Thi Thanh', '0978901234', 'Active');


INSERT INTO patients (patient_name, date_of_birth, gender, phone, email, address, city, insurance_number, blood_type, emergency_contact, emergency_contact_phone, status) 
VALUES
('Tran Van Thanh', '1975-12-20', 'Male', '0989777777', NULL, '500 Pasteur Street', 'Ho Chi Minh', 'INS008', 'O+', 'Tran Thi Xuan', '0989000001', 'Active'),
('Nguyen Thi Huyen', '1988-07-15', 'Female', '0989888888', NULL, '750 Le Van Sy', 'Hanoi', 'INS009', 'A+', 'Nguyen Van Khoa', '0989000002', 'Active'),
('Le Van Phuc', '1993-03-25', 'Male', '0989999999', NULL, '900 Dien Bien Phu', 'Da Nang', 'INS010', 'B+', 'Le Thi Huong', '0989000003', 'Active'),
('Pham Thi Linh', '1986-09-10', 'Female', '0981111111', NULL, '100 Hai Ba Trung', 'Can Tho', 'INS011', 'AB-', 'Pham Van Long', '0989000004', 'Active'),
('Vu Van Diep', '1980-01-05', 'Male', '0981222222', NULL, '200 Tran Phu', 'Nha Trang', 'INS012', 'O-', 'Vu Thi Kim', '0989000005', 'Active');
-- ============================================

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG BỆNH
-- ============================================
INSERT INTO diseases (disease_name, disease_code, description, severity_level) VALUES
('Hypertension', 'HTN001', 'Cao huyết áp', 'Moderate'),
('Diabetes Type 2', 'DM002', 'Bệnh tiểu đường type 2', 'Moderate'),
('Heart Disease', 'HD003', 'Bệnh tim', 'High'),
('Arthritis', 'ARH004', 'Bệnh viêm khớp', 'Moderate'),
('Asthma', 'AST005', 'Bệnh hen suyễn', 'Moderate'),
('Depression', 'DEP006', 'Tâm thần trầm cảm', 'Moderate'),
('Common Cold', 'CC007', 'Cảm cúm', 'Low'),
('Migraine', 'MG008', 'Đau đầu kinh niên', 'Moderate');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG MEDICINES
-- ============================================
INSERT INTO medicines (medicine_name, medicine_type, manufacturer, unit_price, quantity_in_stock, expiry_date, side_effects) VALUES
('Aspirin', 'Analgesic', 'Bayer', 5000, 500, '2025-12-31', 'Stomach upset, Bleeding'),
('Amoxicillin', 'Antibiotic', 'GSK', 15000, 300, '2025-06-30', 'Allergic reactions, Diarrhea'),
('Lisinopril', 'Antihypertensive', 'Pfizer', 12000, 250, '2025-09-30', 'Dizziness, Dry cough'),
('Metformin', 'Antidiabetic', 'Merck', 8000, 400, '2025-11-30', 'Nausea, Diarrhea'),
('Omeprazole', 'Proton Pump Inhibitor', 'AstraZeneca', 20000, 200, '2025-08-31', 'Headache, Diarrhea'),
('Ibuprofen', 'NSAID', 'Abbott', 6000, 600, '2025-10-31', 'Stomach irritation, Rash'),
('Paracetamol', 'Analgesic', 'GSK', 3000, 1000, '2025-12-31', 'Rare, Liver damage if overdose'),
('Loratadine', 'Antihistamine', 'Merck', 18000, 150, '2025-07-31', 'Drowsiness, Dry mouth'),
('Atenolol', 'Beta-blocker', 'Sandoz', 10000, 280, '2025-09-30', 'Fatigue, Dizziness'),
('Vitamin C', 'Supplement', 'Nature', 7000, 800, '2025-12-31', 'None');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG APPOINTMENTS
-- ============================================
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, department_id, reason_for_visit, status, notes) VALUES
(1, 1, '2024-03-15', '09:00:00', 1, 'Heart check-up', 'Completed', 'Patient showed normal ECG results'),
(2, 2, '2024-03-16', '10:30:00', 2, 'Neurological exam', 'Scheduled', 'Follow-up for headaches'),
(3, 3, '2024-03-17', '14:00:00', 3, 'Knee pain consultation', 'Completed', 'Prescribed physical therapy'),
(4, 5, '2024-03-18', '11:00:00', 5, 'Pediatric check-up', 'Scheduled', 'Annual health check'),
(5, 6, '2024-03-19', '15:30:00', 6, 'General health examination', 'Completed', 'All vitals normal'),
(6, 1, '2024-03-20', '09:30:00', 1, 'Cardiac consultation', 'Scheduled', 'BP monitoring needed'),
(7, 4, '2024-03-21', '13:00:00', 4, 'Pre-surgery evaluation', 'Scheduled', 'Approved for surgery');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG ADMISSIONS
-- ============================================

INSERT INTO admissions (patient_id, doctor_id, department_id, admission_date, discharge_date, room_number, bed_number, admission_reason, diagnosis, status) VALUES
(1, 1, 1, '2024-02-01', '2024-02-05', 'A101', 'B1', 'Chest pain', 'Hypertension', 'Discharged'),
(3, 3, 3, '2024-02-10', NULL, 'C203', 'B2', 'Severe knee injury', 'Fracture', 'Admitted'),
(5, 6, 6, '2024-02-15', '2024-02-17', 'D305', 'B1', 'General checkup', 'Diabetes Type 2', 'Discharged'),
(2, 2, 2, '2024-02-20', NULL, 'B102', 'B3', 'Migraine issues', 'Migraine', 'Admitted'),
(7, 4, 4, '2024-03-01', NULL, 'A204', 'B2', 'Pre-surgery care', 'Appendicitis', 'Admitted');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG MEDICAL_HISTORY
-- ============================================
INSERT INTO medical_history (patient_id, disease_id, diagnosis_date, treatment, outcome, notes) VALUES
(1, 1, '2020-06-15', 'Medication + Exercise', 'Controlled', 'Patient compliant with medication'),
(1, 3, '2019-01-10', 'Medication + Surgery consultation', 'Ongoing', 'Regular check-ups scheduled'),
(2, 8, '2021-03-20', 'Preventive medication', 'Managed', 'Episodes reduced'),
(3, 4, '2022-11-05', 'Physical therapy', 'Improved', 'Patient regained mobility'),
(4, 2, '2021-08-12', 'Dietary management', 'Controlled', 'HbA1c within normal range'),
(5, 1, '2020-09-03', 'Medication', 'Controlled', 'Blood pressure stable'),
(6, 5, '2022-01-22', 'Inhalers + Medication', 'Controlled', 'No severe attacks recently'),
(7, 2, '2021-12-15', 'Medication + Lifestyle changes', 'Controlled', 'Weight management ongoing');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG PRESCRIPTIONS
-- ============================================
INSERT INTO prescriptions (patient_id, doctor_id, prescription_date, notes, status) VALUES
(1, 1, '2024-03-15', 'Heart medication refill', 'Active'),
(2, 2, '2024-03-16', 'Migraine medication', 'Active'),
(3, 3, '2024-03-17', 'Pain management', 'Active'),
(4, 5, '2024-03-18', 'Vitamins and supplements', 'Active'),
(5, 6, '2024-03-19', 'Diabetes management', 'Active'),
(6, 1, '2024-03-20', 'Blood pressure medication', 'Active'),
(7, 4, '2024-03-21', 'Pre-surgery antibiotics', 'Active');

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG PRESCRIPTION_DETAILS
-- ============================================
INSERT INTO prescription_details (prescription_id, medicine_id, dosage, frequency, duration_days, quantity) VALUES
(1, 3, '10mg', 'Once daily', 30, 30),
(1, 9, '50mg', 'Twice daily', 30, 60),
(2, 8, '10mg', 'Once at night', 30, 30),
(2, 1, '500mg', 'As needed for pain', 30, 20),
(3, 6, '400mg', 'Three times daily', 14, 42),
(3, 4, '500mg', 'Twice daily', 7, 14),
(4, 10, '500mg', 'Once daily', 90, 90),
(5, 4, '1000mg', 'Three times daily', 90, 270),
(6, 3, '5mg', 'Once daily', 30, 30),
(7, 2, '500mg', 'Twice daily', 7, 14),
(7, 1, '500mg', 'Three times daily', 7, 21);

-- ============================================
-- THÊM DỮ LIỆU VÀO BẢNG INVOICES
-- ============================================
INSERT INTO invoices (patient_id, admission_id, appointment_id, invoice_date, consultation_fee, medicine_cost, hospitalization_cost, other_charges, total_amount, paid_amount, payment_status) VALUES
(1, 1, 1, '2024-02-05', 500000, 300000, 2000000, 200000, 3000000, 3000000, 'Paid'),
(3, 2, NULL, '2024-03-17', 500000, 150000, 0, 0, 650000, 0, 'Pending'),
(5, 3, NULL, '2024-02-17', 500000, 400000, 1500000, 100000, 2500000, 2500000, 'Paid'),
(2, 4, 2, '2024-03-16', 500000, 250000, 0, 50000, 800000, 0, 'Pending'),
(7, 5, 7, '2024-03-21', 500000, 200000, 0, 300000, 1000000, 0, 'Pending'),
(4, NULL, 4, '2024-03-18', 300000, 100000, 0, 0, 400000, 400000, 'Paid'),
(6, NULL, 6, '2024-03-20', 300000, 250000, 0, 50000, 600000, 0, 'Pending');

-- ============================================