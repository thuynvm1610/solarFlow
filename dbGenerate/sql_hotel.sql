/* =========================
   CREATE DATABASE
   ========================= */
DROP DATABASE IF EXISTS hotel;
CREATE DATABASE IF NOT EXISTS hotel
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE hotel;

/* =========================
   USERS
   ========================= */
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    gender ENUM('MALE','FEMALE'),
    dob DATE,
    city VARCHAR(50),
    phone VARCHAR(12),
    `role` ENUM('ADMIN', 'HOTEL_MANAGER', 'CUSTOMER') NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    `status` VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (email, password, full_name, gender, dob, city, phone, role, image_url) VALUES
-- ADMIN
('thuynvm1610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Nguyễn Văn Minh Thủy', 'MALE', '2004-10-16', 'Hải Phòng', '0375577856', 'ADMIN', 'admin_1'),
 
('linhlt2910@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Lê Thùy Linh', 'FEMALE', '2003-10-29', 'Hàỉ Phòng', '0345914403', 'ADMIN', 'admin_2'),
 
-- HOTEL_MANAGER
('quanlm1207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Lê Minh Quân','MALE','1995-07-12','Đà Nẵng','0901122334','HOTEL_MANAGER', 'staff_1'),

('phuongpt0909@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Phạm Thu Phương','FEMALE','1996-09-09','Hà Nội','0902233445','HOTEL_MANAGER', 'staff_2'),

('longhd2304@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Hoàng Đức Long','MALE','1993-04-23','Hồ Chí Minh','0903344556','HOTEL_MANAGER', 'staff_3'),

('hangu1508@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Nguyễn Ngọc Hà','FEMALE','1997-08-15','Hải Phòng','0904455667','HOTEL_MANAGER', 'staff_4'),

('toandk1101@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Đặng Khánh Toàn','MALE','1994-01-11','Huế','0905566778','HOTEL_MANAGER', 'staff_5'),

('tuanva2006@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Vũ Anh Tuấn','MALE','1992-06-20','Hồ Chí Minh','0906677889','HOTEL_MANAGER', 'staff_6'),

('linhbt0305@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Bùi Thị Linh','FEMALE','1999-05-03','Hà Nội','0907788990','HOTEL_MANAGER', 'staff_7'),

('hungnq1412@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Ngô Quốc Hưng','MALE','1991-12-14','Quảng Ninh','0911122233','HOTEL_MANAGER', 'staff_8'),

('hado2208@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Đỗ Thu Hà','FEMALE','1996-08-22','Nam Định','0912233445','HOTEL_MANAGER', 'staff_9'),

('phuctm0102@gmail.com','$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Trịnh Minh Phúc','MALE','1993-02-01','Hồ Chí Minh','0913344556','HOTEL_MANAGER', 'staff_10'),
 
-- CUSTOMER
('hoantt2505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Nguyễn Thị Hoa','FEMALE','2000-05-25','Hà Nội','0931122334','CUSTOMER', 'customer_1'),

('khoatm1707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Trần Minh Khoa','MALE','1999-07-17','HCM','0932233445','CUSTOMER', 'customer_2'),

('anhvl0209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Lê Việt Anh','MALE','2001-09-02','Đà Nẵng','0933344556','CUSTOMER', 'customer_3'),

('lanpt1103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Phạm Thị Lan','FEMALE','1998-03-11','Hải Phòng','0934455667','CUSTOMER', 'customer_4'),

('namh2306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Hoàng Nam','MALE','1997-06-23','Cần Thơ','0935566778','CUSTOMER', 'customer_5'),

('maing0508@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Ngọc Mai','FEMALE','2002-08-05','HCM','0936677889','CUSTOMER', 'customer_6'),

('dungva1904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Vũ Anh Dũng','MALE','1996-04-19','Bình Dương','0937788990','CUSTOMER', 'customer_7'),

('linhbm0712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Bùi Mỹ Linh','FEMALE','2000-12-07','Hà Nội','0941122334','CUSTOMER', 'customer_8'),

('hieunt3001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Ngô Thanh Hiếu','MALE','1995-01-30','Nghệ An','0942233445','CUSTOMER', 'customer_9'),

('trangdt1409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Đỗ Thu Trang','FEMALE','1999-09-14','Nam Định','0943344556','CUSTOMER', 'customer_10'),

('tuanat2602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Trần Anh Tuấn','MALE','1994-02-26','HCM','0944455667','CUSTOMER', 'customer_11'),

('binhnc1006@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Nguyễn Công Bình','MALE','1993-06-10','Quảng Bình','0945566778','CUSTOMER', 'customer_12'),

('hapt1808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Phan Thị Hà','FEMALE','2001-08-18','Thái Bình','0946677889','CUSTOMER', 'customer_13'),

('hoangvm0404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Vũ Minh Hoàng','MALE','1998-04-04','HCM','0947788990','CUSTOMER', 'customer_14'),

('vinhlq2101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Lê Quang Vinh','MALE','2000-01-21','Đà Nẵng','0951122334','CUSTOMER', 'customer_15'),

('myt1807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG',
 'Trà My','FEMALE','2003-07-18','Hà Nội','0952233445','CUSTOMER', 'customer_16'),

('khanhnt1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Khánh','FEMALE','1995-05-12','Hà Nội','0953344556','CUSTOMER', 'customer_17'),
('ducpv2807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Văn Đức','MALE','1992-07-28','HCM','0954455667','CUSTOMER', 'customer_18'),
('thuynt0903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Thủy','FEMALE','1998-03-09','Đà Nẵng','0955566778','CUSTOMER', 'customer_19'),
('longvd1506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đức Long','MALE','1996-06-15','Hải Phòng','0956677889','CUSTOMER', 'customer_20'),
('huonglt2211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Hương','FEMALE','1994-11-22','Cần Thơ','0957788990','CUSTOMER', 'customer_21'),
('tuanha0408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Anh Tuấn','MALE','1999-08-04','HCM','0961122334','CUSTOMER', 'customer_22'),
('linhpk1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Khánh Linh','FEMALE','2001-09-17','Bình Dương','0962233445','CUSTOMER', 'customer_23'),
('quangth3012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hữu Quang','MALE','1997-12-30','Hà Nội','0963344556','CUSTOMER', 'customer_24'),
('nhung0201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nhung','FEMALE','2000-01-02','Nam Định','0964455667','CUSTOMER', 'customer_25'),
('hungpt1404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thanh Hùng','MALE','1993-04-14','Nghệ An','0965566778','CUSTOMER', 'customer_26'),
('maidn2605@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Mai','FEMALE','1998-05-26','Đà Nẵng','0966677889','CUSTOMER', 'customer_27'),
('sonlv1910@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Văn Sơn','MALE','1995-10-19','HCM','0967788990','CUSTOMER', 'customer_28'),
('thuytm0307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Mỹ Thúy','FEMALE','2002-07-03','Hải Phòng','0971122334','CUSTOMER', 'customer_29'),
('datnh1108@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hải Đạt','MALE','1996-08-11','Quảng Ninh','0972233445','CUSTOMER', 'customer_30'),
('anhtt2012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trương Thị Anh','FEMALE','1999-12-20','Hà Nội','0973344556','CUSTOMER', 'customer_31'),
('binhvk0506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Khánh Bình','MALE','1994-06-05','HCM','0974455667','CUSTOMER', 'customer_32'),
('hoaln1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Ngọc Hoa','FEMALE','2001-01-18','Thái Bình','0975566778','CUSTOMER', 'customer_33'),
('tuandn2904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Tuấn','MALE','1997-04-29','Đà Nẵng','0976677889','CUSTOMER', 'customer_34'),
('linhbt1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Linh','FEMALE','2000-02-12','Hà Nội','0977788990','CUSTOMER', 'customer_35'),
('khoitm0611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Minh Khôi','MALE','1998-11-06','HCM','0981122334','CUSTOMER', 'customer_36'),
('nganph2503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hà Ngân','FEMALE','1996-03-25','Cần Thơ','0982233445','CUSTOMER', 'customer_37'),
('hungnt1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Hùng','MALE','1993-09-17','Hải Phòng','0983344556','CUSTOMER', 'customer_38'),
('mypt0805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thùy My','FEMALE','2002-05-08','Bình Dương','0984455667','CUSTOMER', 'customer_39'),
('quangvd2110@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đức Quang','MALE','1995-10-21','Đà Nẵng','0985566778','CUSTOMER', 'customer_40'),
('thaonh1306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hải Thảo','FEMALE','1999-06-13','Hà Nội','0986677889','CUSTOMER', 'customer_41'),
('namtk2701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Khánh Nam','MALE','1997-01-27','HCM','0987788990','CUSTOMER', 'customer_42'),
('hanhlt0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Hạnh','FEMALE','2001-12-09','Nam Định','0991122334','CUSTOMER', 'customer_43'),
('duongvh1504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hải Dương','MALE','1994-04-15','Nghệ An','0992233445','CUSTOMER', 'customer_44'),
('thuypt2608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thị Thủy','FEMALE','1998-08-26','Đà Nẵng','0993344556','CUSTOMER', 'customer_45'),
('hieuvt1011@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Trung Hiếu','MALE','1996-11-10','HCM','0994455667','CUSTOMER', 'customer_46'),
('landn3007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Lan','FEMALE','2000-07-30','Hải Phòng','0995566778','CUSTOMER', 'customer_47'),
('sonph1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hữu Sơn','MALE','1993-02-12','Quảng Ninh','0996677889','CUSTOMER', 'customer_48'),
('huyennt2405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Huyền','FEMALE','1999-05-24','Hà Nội','0997788990','CUSTOMER', 'customer_49'),
('thanhvd0609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đức Thành','MALE','1997-09-06','HCM','0921122334','CUSTOMER', 'customer_50'),
('ngalt1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Nga','FEMALE','2001-01-18','Thái Bình','0922233445','CUSTOMER', 'customer_51'),
('ductn2912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Ngọc Đức','MALE','1995-12-29','Đà Nẵng','0923344556','CUSTOMER', 'customer_52'),
('hoapm1104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Minh Hoa','FEMALE','1998-04-11','Hà Nội','0924455667','CUSTOMER', 'customer_53'),
('longnh2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hữu Long','MALE','1996-07-26','HCM','0925566778','CUSTOMER', 'customer_54'),
('vanbt0803@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Vân','FEMALE','2002-03-08','Cần Thơ','0926677889','CUSTOMER', 'customer_55'),
('tuanlt1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thanh Tuấn','MALE','1994-10-15','Hải Phòng','0927788990','CUSTOMER', 'customer_56'),
('thuydk2201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Khánh Thủy','FEMALE','2000-01-22','Bình Dương','0928811223','CUSTOMER', 'customer_57'),
('hungph0506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Huy Hùng','MALE','1997-06-05','Đà Nẵng','0929922334','CUSTOMER', 'customer_58'),
('linhnt1308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thùy Linh','FEMALE','1999-08-13','Hà Nội','0920033445','CUSTOMER', 'customer_59'),
('quanvd2711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đình Quân','MALE','1995-11-27','HCM','0920144556','CUSTOMER', 'customer_60'),
('maitn0904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Ngọc Mai','FEMALE','2001-04-09','Nam Định','0920255667','CUSTOMER', 'customer_61'),
('anhph1702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hồng Anh','MALE','1993-02-17','Nghệ An','0920366778','CUSTOMER', 'customer_62'),
('thuypk2809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Kim Thủy','FEMALE','1998-09-28','Đà Nẵng','0920477889','CUSTOMER', 'customer_63'),
('sonvh1405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hải Sơn','MALE','1996-05-14','HCM','0920588990','CUSTOMER', 'customer_64'),
('ngand2610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thị Nga','FEMALE','2000-10-26','Hải Phòng','0920699112','CUSTOMER', 'customer_65'),
('tuannh0301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hoàng Tuấn','MALE','1994-01-03','Quảng Ninh','0920710223','CUSTOMER', 'customer_66'),
('hienlt1507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Hiền','FEMALE','1999-07-15','Hà Nội','0920821334','CUSTOMER', 'customer_67'),
('binhth2712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hải Bình','MALE','1997-12-27','HCM','0920932445','CUSTOMER', 'customer_68'),
('huongpm0906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Mỹ Hương','FEMALE','2001-06-09','Thái Bình','0921043556','CUSTOMER', 'customer_69'),
('khoivd2103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Duy Khôi','MALE','1995-03-21','Đà Nẵng','0921154667','CUSTOMER', 'customer_70'),
('lanpt1108@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thùy Lan','FEMALE','1998-08-11','Hà Nội','0921265778','CUSTOMER', 'customer_71'),
('hungdn2404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Hùng','MALE','1996-04-24','HCM','0921376889','CUSTOMER', 'customer_72'),
('thubn0611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Ngọc Thu','FEMALE','2000-11-06','Cần Thơ','0921487990','CUSTOMER', 'customer_73'),
('datlh1802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hữu Đạt','MALE','1993-02-18','Hải Phòng','0921598112','CUSTOMER', 'customer_74'),
('hoanv3009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Văn Hòa','MALE','1999-09-30','Bình Dương','0921609223','CUSTOMER', 'customer_75'),
('linhtt1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thùy Linh','FEMALE','1997-05-12','Đà Nẵng','0921710334','CUSTOMER', 'customer_76'),
('tuanpk2510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Khánh Tuấn','MALE','1995-10-25','Hà Nội','0921821445','CUSTOMER', 'customer_77'),
('mynh0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hồng My','FEMALE','2001-03-07','HCM','0921932556','CUSTOMER', 'customer_78'),
('anhvt1408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Tuấn Anh','MALE','1994-08-14','Nam Định','0922043667','CUSTOMER', 'customer_79'),
('thaodt2601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thị Thảo','FEMALE','1998-01-26','Nghệ An','0922154778','CUSTOMER', 'customer_80'),
('quangpl0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Lê Quang','MALE','1996-12-09','Đà Nẵng','0922265889','CUSTOMER', 'customer_81'),
('hienpm1504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Minh Hiền','FEMALE','2000-04-15','HCM','0922376990','CUSTOMER', 'customer_82'),
('sonnt2707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Trung Sơn','MALE','1997-07-27','Hải Phòng','0922487112','CUSTOMER', 'customer_83'),
('huonglt0311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Hương','FEMALE','1999-11-03','Quảng Ninh','0922598223','CUSTOMER', 'customer_84'),
('datpv1806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Văn Đạt','MALE','1995-06-18','Hà Nội','0922609334','CUSTOMER', 'customer_85'),
('anhth2202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hồng Ánh','FEMALE','2001-02-22','HCM','0922710445','CUSTOMER', 'customer_86'),
('binhvl1009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Lê Bình','MALE','1993-09-10','Thái Bình','0922821556','CUSTOMER', 'customer_87'),
('huend2405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Đức Huệ','FEMALE','1998-05-24','Đà Nẵng','0922932667','CUSTOMER', 'customer_88'),
('khoiph0701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Huy Khôi','MALE','1996-01-07','Hà Nội','0923043778','CUSTOMER', 'customer_89'),
('landt1312@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thị Lan','FEMALE','2000-12-13','HCM','0923154889','CUSTOMER', 'customer_90'),
('tuannh2608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hữu Tuấn','MALE','1994-08-26','Cần Thơ','0923265990','CUSTOMER', 'customer_91'),
('thuybt1104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thị Thủy','FEMALE','1997-04-11','Hải Phòng','0923376112','CUSTOMER', 'customer_92'),
('hunglt2911@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Trọng Hùng','MALE','1995-11-29','Bình Dương','0923487223','CUSTOMER', 'customer_93'),
('hoapt0503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Hoa','FEMALE','1999-03-05','Đà Nẵng','0923598334','CUSTOMER', 'customer_94'),
('longvh1706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hữu Long','MALE','1996-06-17','Hà Nội','0923609445','CUSTOMER', 'customer_95'),
('linhdn2102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Linh','FEMALE','2001-02-21','HCM','0923710556','CUSTOMER', 'customer_96'),
('sonpk1410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Khánh Sơn','MALE','1993-10-14','Nam Định','0923821667','CUSTOMER', 'customer_97'),
('thuypt0607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thị Thủy','FEMALE','1998-07-06','Nghệ An','0923932778','CUSTOMER', 'customer_98'),
('anhnh1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hoàng Anh','MALE','1997-01-18','Đà Nẵng','0924043889','CUSTOMER', 'customer_99'),
('mainl2512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Lan Mai','FEMALE','2000-12-25','HCM','0924154990','CUSTOMER', 'customer_100'),
('thaobitran2504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Bích Thảo','FEMALE','1990-10-26','Bến Tre','0386105213','CUSTOMER', 'customer_101'),
('hieuantran1602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Anh Hiếu','MALE','1994-12-15','Bến Tre','0926733654','CUSTOMER', 'customer_102'),
('binhvavu1608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Văn Bình','MALE','1997-11-15','Huế','0982683850','CUSTOMER', 'customer_103'),
('vanbitran1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Bích Vân','FEMALE','1991-01-20','Thanh Hóa','0399024284','CUSTOMER', 'customer_104'),
('quangkhbui1206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Khánh Quang','MALE','1998-10-16','Ninh Thuận','0338798612','CUSTOMER', 'customer_105'),
('hoabido2807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Bích Hoa','FEMALE','1994-11-02','Nam Định','0911400455','CUSTOMER', 'customer_106'),
('quangvapham1704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Văn Quang','MALE','1997-01-07','Cần Thơ','0327695465','CUSTOMER', 'customer_107'),
('linhthnguyen1708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Linh','FEMALE','1998-06-25','Thái Bình','0920180554','CUSTOMER', 'customer_108'),
('hunghahoang1112@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hải Hùng','MALE','1994-02-25','Hải Dương','0387077124','CUSTOMER', 'customer_109'),
('longhodang1411@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hoàng Long','MALE','1997-03-04','Đồng Nai','0343464188','CUSTOMER', 'customer_110'),
('binhvaphan0509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Văn Bình','MALE','1995-10-19','Vĩnh Phúc','0971952255','CUSTOMER', 'customer_111'),
('chauthnguyen2307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thu Châu','FEMALE','2005-07-03','Hưng Yên','0374831073','CUSTOMER', 'customer_112'),
('phonganho0808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Anh Phong','MALE','2004-09-24','Quảng Nam','0902664229','CUSTOMER', 'customer_113'),
('huyenthle0501@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Huyền','FEMALE','1998-12-26','Quảng Ngãi','0351447449','CUSTOMER', 'customer_114'),
('trangphhoang1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Phương Trang','FEMALE','1995-08-23','Đồng Nai','0946348450','CUSTOMER', 'customer_115'),
('dungthnguyen2604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh Dũng','MALE','1993-10-10','Đà Nẵng','0372383613','CUSTOMER', 'customer_116'),
('thuykiphan2506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Kim Thủy','FEMALE','1998-07-26','Vĩnh Long','0397488256','CUSTOMER', 'customer_117'),
('lanthnguyen2808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Lan','FEMALE','2003-08-21','Bình Định','0977863030','CUSTOMER', 'customer_118'),
('vinhqudo1201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Quang Vinh','MALE','1998-01-01','Bình Dương','0375754157','CUSTOMER', 'customer_119'),
('kienthnguyen0805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh Kiên','MALE','1999-11-05','Hải Dương','0940350259','CUSTOMER', 'customer_120'),
('thuhale1201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hà Thu','FEMALE','2001-01-01','Ninh Thuận','0350001204','CUSTOMER', 'customer_121'),
('chauthhoang0104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thu Châu','FEMALE','2003-10-31','Hải Dương','0928889730','CUSTOMER', 'customer_122'),
('datngho0708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Đạt','MALE','1999-11-15','Quảng Bình','0926488601','CUSTOMER', 'customer_123'),
('ngahapham2705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hà Nga','FEMALE','2005-03-26','Hà Tĩnh','0943140146','CUSTOMER', 'customer_124'),
('anhtuduong0611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuyết Anh','FEMALE','1991-10-01','Hưng Yên','0931434633','CUSTOMER', 'customer_125'),
('vanthhoang1307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thu Vân','FEMALE','1990-04-14','Đà Nẵng','0957227164','CUSTOMER', 'customer_126'),
('hoahadang0510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hà Hoa','FEMALE','1999-12-31','Bình Thuận','0916637720','CUSTOMER', 'customer_127'),
('vinhhabui2410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hải Vinh','MALE','1993-03-11','Lâm Đồng','0955288082','CUSTOMER', 'customer_128'),
('longqubui1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Quang Long','MALE','1996-07-28','Bình Dương','0368960487','CUSTOMER', 'customer_129'),
('dungmiphan0801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Dũng','MALE','1999-02-10','Khánh Hòa','0326243865','CUSTOMER', 'customer_130'),
('thaohopham2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hồng Thảo','FEMALE','1992-04-10','Quảng Nam','0976630613','CUSTOMER', 'customer_131'),
('thanhanho1708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Anh Thành','MALE','1995-06-15','Đà Nẵng','0383318865','CUSTOMER', 'customer_132'),
('nhunghongo2812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hồng Nhung','FEMALE','1997-11-02','An Giang','0985727803','CUSTOMER', 'customer_133'),
('hunghongo0608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hoàng Hưng','MALE','1992-12-29','Nam Định','0382577050','CUSTOMER', 'customer_134'),
('toantuduong2009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuấn Toàn','MALE','2004-11-06','Hà Nội','0960261023','CUSTOMER', 'customer_135'),
('hamynguyen1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Mỹ Hà','FEMALE','1993-11-03','Tiền Giang','0318374014','CUSTOMER', 'customer_136'),
('vinhhuho2105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hữu Vinh','MALE','1995-07-25','Thanh Hóa','0946198657','CUSTOMER', 'customer_137'),
('huongdiduong2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Diệu Hương','FEMALE','1996-09-15','Hà Nội','0928000083','CUSTOMER', 'customer_138'),
('nhunglaly0805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Lan Nhung','FEMALE','1991-12-07','Đà Nẵng','0318839868','CUSTOMER', 'customer_139'),
('tamkhngo0607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Khánh Tâm','MALE','1991-11-22','Phú Yên','0362427933','CUSTOMER', 'customer_140'),
('thuthduong0712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Thu','FEMALE','2000-11-12','Tiền Giang','0341849431','CUSTOMER', 'customer_141'),
('khoitudang2505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Tuấn Khôi','MALE','2004-03-02','Bình Định','0907644379','CUSTOMER', 'customer_142'),
('landile0406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Diệu Lan','FEMALE','1993-09-30','Hải Dương','0941964023','CUSTOMER', 'customer_143'),
('nhungkipham2603@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Kim Nhung','FEMALE','2004-09-06','Bến Tre','0972286622','CUSTOMER', 'customer_144'),
('lanthdo2506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thị Lan','FEMALE','1991-02-10','Ninh Thuận','0332115827','CUSTOMER', 'customer_145'),
('tamtule2703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Tuấn Tâm','MALE','2003-10-06','Lâm Đồng','0967242941','CUSTOMER', 'customer_146'),
('anhphle0709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Phương Anh','FEMALE','1999-03-26','Bến Tre','0378796127','CUSTOMER', 'customer_147'),
('lanphpham1703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Phương Lan','FEMALE','1993-08-15','Quảng Ngãi','0369391494','CUSTOMER', 'customer_148'),
('uyenthdo2404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Uyên','FEMALE','2002-01-28','Bến Tre','0952674777','CUSTOMER', 'customer_149'),
('sonhuly2306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hữu Sơn','MALE','2001-09-12','Hưng Yên','0945764253','CUSTOMER', 'customer_150'),
('ngathtran0301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thị Nga','FEMALE','2003-06-27','Đồng Nai','0325961429','CUSTOMER', 'customer_151'),
('lannghoang0801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Ngọc Lan','FEMALE','1997-02-14','Quảng Ninh','0960390184','CUSTOMER', 'customer_152'),
('ngamyvu1009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Mỹ Nga','FEMALE','1998-06-26','Cần Thơ','0365083223','CUSTOMER', 'customer_153'),
('hunghutran1101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hữu Hưng','MALE','1999-08-29','Tiền Giang','0948528526','CUSTOMER', 'customer_154'),
('phucthle1905@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thanh Phúc','MALE','1991-08-22','Đồng Nai','0354833201','CUSTOMER', 'customer_155'),
('lantuphan2309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Tuyết Lan','FEMALE','2002-04-05','An Giang','0329667426','CUSTOMER', 'customer_156'),
('khoivadang1401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Văn Khôi','MALE','1991-10-12','Bình Phước','0378470917','CUSTOMER', 'customer_157'),
('phuchodo0701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hoàng Phúc','MALE','1998-03-06','Bình Định','0382932787','CUSTOMER', 'customer_158'),
('thanhtungo1903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Tuấn Thành','MALE','2003-04-06','Lâm Đồng','0905733321','CUSTOMER', 'customer_159'),
('toandutran2711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Duy Toàn','MALE','1996-07-19','Kiên Giang','0315694390','CUSTOMER', 'customer_160'),
('nhungthduong0406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thùy Nhung','FEMALE','1990-01-18','Quảng Ninh','0933340215','CUSTOMER', 'customer_161'),
('phuccole2301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Công Phúc','MALE','2002-04-22','Cần Thơ','0926757763','CUSTOMER', 'customer_162'),
('chaungho0408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Châu','FEMALE','1992-07-28','Quảng Nam','0387012261','CUSTOMER', 'customer_163'),
('namdubui2012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Đức Nam','MALE','1992-01-01','HCM','0931242950','CUSTOMER', 'customer_164'),
('mailaphan2702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Lan Mai','FEMALE','1995-12-12','Nghệ An','0310895344','CUSTOMER', 'customer_165'),
('thaolaphan2201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Lan Thảo','FEMALE','2000-02-01','Đồng Nai','0331413684','CUSTOMER', 'customer_166'),
('vanmydo1903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Mỹ Vân','FEMALE','1999-06-05','Vĩnh Phúc','0393018709','CUSTOMER', 'customer_167'),
('datvanguyen1809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Văn Đạt','MALE','1998-02-18','Khánh Hòa','0344449145','CUSTOMER', 'customer_168'),
('huyenkipham1803@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Kim Huyền','FEMALE','1990-09-11','Tiền Giang','0955864376','CUSTOMER', 'customer_169'),
('huongthle0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Hương','FEMALE','2003-08-14','Hải Dương','0906744116','CUSTOMER', 'customer_170'),
('datvale1612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Văn Đạt','MALE','2003-07-22','Phú Yên','0347916916','CUSTOMER', 'customer_171'),
('ngakiduong2502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Kim Nga','FEMALE','2002-10-07','Phú Yên','0920309838','CUSTOMER', 'customer_172'),
('ngabinguyen2008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Bích Nga','FEMALE','1994-05-20','Hải Dương','0960422722','CUSTOMER', 'customer_173'),
('hungqupham0902@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Quang Hưng','MALE','2001-11-26','Huế','0916989378','CUSTOMER', 'customer_174'),
('ngahaduong2409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hà Nga','FEMALE','1999-04-26','An Giang','0324418703','CUSTOMER', 'customer_175'),
('toananhoang1112@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Anh Toàn','MALE','1998-09-05','Bến Tre','0928976093','CUSTOMER', 'customer_176'),
('khoicovu1502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Công Khôi','MALE','2003-06-11','Ninh Thuận','0986490724','CUSTOMER', 'customer_177'),
('huongbido2402@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Bích Hương','FEMALE','2002-05-07','Hà Nội','0397486699','CUSTOMER', 'customer_178'),
('vinhcotran0802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Công Vinh','MALE','1999-08-12','Vĩnh Phúc','0905150790','CUSTOMER', 'customer_179'),
('namvaho0507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Văn Nam','MALE','2002-12-14','Hà Nội','0932079555','CUSTOMER', 'customer_180'),
('thunghoang1803@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Ngọc Thu','FEMALE','1996-03-12','Đồng Nai','0979471965','CUSTOMER', 'customer_181'),
('nhungbido1102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Bích Nhung','FEMALE','2005-04-09','Quảng Bình','0372064584','CUSTOMER', 'customer_182'),
('thuhavu1107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hà Thu','FEMALE','2005-06-17','Vĩnh Phúc','0918103617','CUSTOMER', 'customer_183'),
('longhupham0909@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hữu Long','MALE','1999-10-14','Tiền Giang','0379766111','CUSTOMER', 'customer_184'),
('hieuanngo2407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Anh Hiếu','MALE','1994-08-05','Quảng Ninh','0366354687','CUSTOMER', 'customer_185'),
('thuythtran2707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thu Thủy','FEMALE','1997-06-01','Đồng Nai','0936748340','CUSTOMER', 'customer_186'),
('huyenmyhoang2608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Mỹ Huyền','FEMALE','2003-05-05','Hà Nội','0353501349','CUSTOMER', 'customer_187'),
('thuthvu0901@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thùy Thu','FEMALE','1998-10-26','Hải Phòng','0360505299','CUSTOMER', 'customer_188'),
('phuchudang2609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hữu Phúc','MALE','1999-03-07','Hà Tĩnh','0338792868','CUSTOMER', 'customer_189'),
('namhaly2701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hải Nam','MALE','1997-04-27','HCM','0952451549','CUSTOMER', 'customer_190'),
('lanngtran0308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Ngọc Lan','FEMALE','1991-08-25','Hà Tĩnh','0311736977','CUSTOMER', 'customer_191'),
('haphtran2807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Phương Hà','FEMALE','2002-07-28','Quảng Bình','0351292747','CUSTOMER', 'customer_192'),
('thanhdutran1009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Đức Thành','MALE','1999-03-04','HCM','0927307824','CUSTOMER', 'customer_193'),
('tuananpham2702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Anh Tuấn','MALE','2000-12-02','An Giang','0940386307','CUSTOMER', 'customer_194'),
('phuongphdang1712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Phương Phương','FEMALE','1993-03-25','Tiền Giang','0346835727','CUSTOMER', 'customer_195'),
('hanhdido1802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Diệu Hạnh','FEMALE','2001-06-07','Bình Thuận','0929745503','CUSTOMER', 'customer_196'),
('khoitupham2808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Tuấn Khôi','MALE','2003-04-18','Nghệ An','0957143577','CUSTOMER', 'customer_197'),
('longngho1610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Long','MALE','1999-12-26','Hải Dương','0396037875','CUSTOMER', 'customer_198'),
('sonngduong1811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Ngọc Sơn','MALE','2001-12-29','Bình Định','0949005167','CUSTOMER', 'customer_199'),
('mytupham0503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Tuyết My','FEMALE','2001-11-18','Thanh Hóa','0355902625','CUSTOMER', 'customer_200'),
('hanhphnguyen2002@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Phương Hạnh','FEMALE','1999-05-08','Hà Tĩnh','0920073470','CUSTOMER', 'customer_201'),
('uyenhaho2710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hà Uyên','FEMALE','1991-06-07','Vĩnh Phúc','0989049725','CUSTOMER', 'customer_202'),
('nhungngly0810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Nhung','FEMALE','2005-10-13','Bình Dương','0311600015','CUSTOMER', 'customer_203'),
('chaulatran1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Lan Châu','FEMALE','1990-12-29','Bình Thuận','0362218103','CUSTOMER', 'customer_204'),
('thanhhoho1105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hoàng Thành','MALE','1990-04-11','Lâm Đồng','0967395488','CUSTOMER', 'customer_205'),
('phuccodang2705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Công Phúc','MALE','2003-09-26','Ninh Thuận','0912632437','CUSTOMER', 'customer_206'),
('quangando2405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Anh Quang','MALE','2004-02-27','Vĩnh Long','0392537213','CUSTOMER', 'customer_207'),
('taiduhoang2611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Đức Tài','MALE','1990-09-12','Đà Nẵng','0966741387','CUSTOMER', 'customer_208'),
('quangdule2010@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Đức Quang','MALE','2004-04-30','HCM','0949691971','CUSTOMER', 'customer_209'),
('nhungkiduong2007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Kim Nhung','FEMALE','2000-03-03','Kiên Giang','0921559587','CUSTOMER', 'customer_210'),
('hanhthdo1806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Hạnh','FEMALE','2004-05-16','Bắc Ninh','0315999796','CUSTOMER', 'customer_211'),
('quangtungo0410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Tuấn Quang','MALE','1996-08-06','Nam Định','0389592163','CUSTOMER', 'customer_212'),
('vanphbui2104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Phương Vân','FEMALE','1996-02-11','Quảng Bình','0901373226','CUSTOMER', 'customer_213'),
('ngahohoang1406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hồng Nga','FEMALE','2000-07-17','Vĩnh Phúc','0332254576','CUSTOMER', 'customer_214'),
('phucanly2001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Anh Phúc','MALE','2002-01-01','Bình Dương','0333935373','CUSTOMER', 'customer_215'),
('longngle1901@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Ngọc Long','MALE','2003-03-26','Nam Định','0327621403','CUSTOMER', 'customer_216'),
('hungquphan0610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Quang Hưng','MALE','1991-10-24','Bến Tre','0381726871','CUSTOMER', 'customer_217'),
('toancopham0109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Công Toàn','MALE','1993-08-27','Tiền Giang','0942748761','CUSTOMER', 'customer_218'),
('hungngdang0712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Hưng','MALE','2000-05-29','Đồng Nai','0943515489','CUSTOMER', 'customer_219'),
('hahaho0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hà Hà','FEMALE','1991-11-28','Phú Yên','0907375587','CUSTOMER', 'customer_220'),
('dungngdang0201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Dũng','MALE','1997-04-16','Đồng Nai','0372662409','CUSTOMER', 'customer_221'),
('thuythduong1904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thị Thủy','FEMALE','2001-04-08','Nam Định','0327651287','CUSTOMER', 'customer_222'),
('uyenmyhoang0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Mỹ Uyên','FEMALE','2005-02-13','Trà Vinh','0333876918','CUSTOMER', 'customer_223'),
('maiphdang1606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Phương Mai','FEMALE','1999-05-25','Phú Yên','0918496357','CUSTOMER', 'customer_224'),
('mythtran2812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thị My','FEMALE','1990-02-24','Lâm Đồng','0923239552','CUSTOMER', 'customer_225'),
('linhkitran1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Kim Linh','FEMALE','1997-02-09','Tây Ninh','0981914093','CUSTOMER', 'customer_226'),
('hungvaly0909@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Văn Hùng','MALE','1993-08-05','Huế','0315563605','CUSTOMER', 'customer_227'),
('khoituduong0303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuấn Khôi','MALE','2004-09-20','Bình Định','0371978744','CUSTOMER', 'customer_228'),
('kiencodang1705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Công Kiên','MALE','1995-04-14','Lâm Đồng','0343991259','CUSTOMER', 'customer_229'),
('hungthngo1305@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thanh Hưng','MALE','1998-06-01','Cần Thơ','0927075553','CUSTOMER', 'customer_230'),
('anhhophan1602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hồng Anh','FEMALE','2001-11-19','Khánh Hòa','0340997870','CUSTOMER', 'customer_231'),
('ngaholy2204@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hồng Nga','FEMALE','2004-05-31','Hải Phòng','0917276186','CUSTOMER', 'customer_232'),
('phuonghado0611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hà Phương','FEMALE','2005-01-24','Quảng Nam','0970623025','CUSTOMER', 'customer_233'),
('vinhquvu0311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Quang Vinh','MALE','2005-05-21','Quảng Ngãi','0340241722','CUSTOMER', 'customer_234'),
('hahaphan0209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hà Hà','FEMALE','1999-05-16','Vĩnh Long','0974461423','CUSTOMER', 'customer_235'),
('lantupham2203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Tuyết Lan','FEMALE','1999-07-24','Hà Nội','0929537508','CUSTOMER', 'customer_236'),
('maibitran0206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Bích Mai','FEMALE','1996-07-14','Bình Định','0915510667','CUSTOMER', 'customer_237'),
('phuonglatran1305@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Lan Phương','FEMALE','1993-06-28','Bình Dương','0952222751','CUSTOMER', 'customer_238'),
('hungtungo1110@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Tuấn Hùng','MALE','2005-12-14','Hải Dương','0345466367','CUSTOMER', 'customer_239'),
('phucthdo2405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Phúc','MALE','2003-06-09','Bình Phước','0345525464','CUSTOMER', 'customer_240'),
('thaobivu2705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Bích Thảo','FEMALE','2002-03-12','Bình Định','0395733867','CUSTOMER', 'customer_241'),
('maimybui2410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Mỹ Mai','FEMALE','1995-09-22','Đà Nẵng','0383342277','CUSTOMER', 'customer_242'),
('thuythnguyen0201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Thủy','FEMALE','2003-11-21','Thái Bình','0333402177','CUSTOMER', 'customer_243'),
('phuongbivu0102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Bích Phương','FEMALE','1994-08-14','Phú Yên','0917989120','CUSTOMER', 'customer_244'),
('taivaly2201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Văn Tài','MALE','2005-03-04','Nam Định','0333962553','CUSTOMER', 'customer_245'),
('vanphvu0502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Phương Vân','FEMALE','1992-03-19','Bến Tre','0344769519','CUSTOMER', 'customer_246'),
('mytuvu2807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Tuyết My','FEMALE','1991-03-21','Lâm Đồng','0917823444','CUSTOMER', 'customer_247'),
('phongthdo1308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Phong','MALE','1990-04-17','Hải Phòng','0374486421','CUSTOMER', 'customer_248'),
('thumyho2604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Mỹ Thu','FEMALE','1995-09-03','Thanh Hóa','0902308628','CUSTOMER', 'customer_249'),
('thuthly1601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thu Thu','FEMALE','1999-11-15','Hà Nội','0924013675','CUSTOMER', 'customer_250'),
('namngly2101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Nam','MALE','1994-02-19','Kiên Giang','0312998092','CUSTOMER', 'customer_251'),
('lanthho0207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thu Lan','FEMALE','1997-02-08','Bắc Ninh','0918186965','CUSTOMER', 'customer_252'),
('kiencole1209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Công Kiên','MALE','2004-08-01','Quảng Ninh','0950364616','CUSTOMER', 'customer_253'),
('kienthdang0804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thanh Kiên','MALE','2004-07-07','Vĩnh Phúc','0946326968','CUSTOMER', 'customer_254'),
('lanbitran2507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Bích Lan','FEMALE','1990-07-11','HCM','0377147874','CUSTOMER', 'customer_255'),
('sondubui0304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Duy Sơn','MALE','2003-04-23','Quảng Ngãi','0339415989','CUSTOMER', 'customer_256'),
('quanghoduong0104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hoàng Quang','MALE','2001-04-30','Nam Định','0342805312','CUSTOMER', 'customer_257'),
('khoiqudang2106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Quang Khôi','MALE','1993-06-19','Tiền Giang','0379224885','CUSTOMER', 'customer_258'),
('huyenhole2206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hồng Huyền','FEMALE','2003-05-06','Thanh Hóa','0386371847','CUSTOMER', 'customer_259'),
('huyenthle1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thùy Huyền','FEMALE','1994-02-21','Tiền Giang','0978701729','CUSTOMER', 'customer_260'),
('toanngngo0211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc Toàn','MALE','1994-05-26','An Giang','0961144726','CUSTOMER', 'customer_261'),
('maimyphan2302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Mỹ Mai','FEMALE','1995-06-25','Hải Dương','0905754856','CUSTOMER', 'customer_262'),
('quangduly0210@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Đức Quang','MALE','1990-03-24','Tây Ninh','0951481263','CUSTOMER', 'customer_263'),
('phongthpham0909@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thanh Phong','MALE','1994-05-28','Bình Phước','0394547092','CUSTOMER', 'customer_264'),
('tamanbui0301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Anh Tâm','MALE','1991-04-23','Hưng Yên','0922182810','CUSTOMER', 'customer_265'),
('hungdungo0712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Duy Hùng','MALE','2002-07-21','Thanh Hóa','0376579043','CUSTOMER', 'customer_266'),
('ngathpham2201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thu Nga','FEMALE','2004-09-05','Nam Định','0963969064','CUSTOMER', 'customer_267'),
('thuytuvu0502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Tuyết Thủy','FEMALE','2002-10-10','Nam Định','0397305566','CUSTOMER', 'customer_268'),
('hanhlapham1604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Lan Hạnh','FEMALE','2003-10-15','HCM','0924382703','CUSTOMER', 'customer_269'),
('maiphly0503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Phương Mai','FEMALE','2001-03-20','Hưng Yên','0322672275','CUSTOMER', 'customer_270'),
('linhtudo0603@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Tuyết Linh','FEMALE','1991-12-19','Nam Định','0969545130','CUSTOMER', 'customer_271'),
('linhmytran1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Mỹ Linh','FEMALE','2000-10-02','An Giang','0909780397','CUSTOMER', 'customer_272'),
('hungdutran1107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Duy Hùng','MALE','2005-10-02','Cần Thơ','0399022038','CUSTOMER', 'customer_273'),
('thuykile1401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Kim Thủy','FEMALE','1996-06-14','Đồng Nai','0337530769','CUSTOMER', 'customer_274'),
('toancongo1509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Công Toàn','MALE','2000-09-24','Lâm Đồng','0312571099','CUSTOMER', 'customer_275'),
('uyenthdang0407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thùy Uyên','FEMALE','1996-02-20','Quảng Bình','0923793123','CUSTOMER', 'customer_276'),
('ngaditran0812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Diệu Nga','FEMALE','2002-04-03','Bình Thuận','0394177415','CUSTOMER', 'customer_277'),
('phuchaly2504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hải Phúc','MALE','1998-12-08','Đà Nẵng','0983229561','CUSTOMER', 'customer_278'),
('anhkihoang0609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Kim Anh','FEMALE','2003-11-15','Quảng Bình','0965516997','CUSTOMER', 'customer_279'),
('longdule0507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Đức Long','MALE','1993-10-16','Bến Tre','0960834378','CUSTOMER', 'customer_280'),
('vinhvavu0512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Văn Vinh','MALE','1999-05-30','Đồng Nai','0326410579','CUSTOMER', 'customer_281'),
('khoingbui2806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Ngọc Khôi','MALE','1992-02-09','Bến Tre','0930934676','CUSTOMER', 'customer_282'),
('chauthly0204@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thanh Châu','FEMALE','2004-12-16','Bình Định','0310943050','CUSTOMER', 'customer_283'),
('khoikhduong1209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Khánh Khôi','MALE','1990-05-30','Bình Thuận','0335002156','CUSTOMER', 'customer_284'),
('linhthtran0607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thu Linh','FEMALE','2005-10-17','Huế','0324378134','CUSTOMER', 'customer_285'),
('anhlapham0111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Lan Anh','FEMALE','1996-12-13','Nam Định','0977576536','CUSTOMER', 'customer_286'),
('chauthho2601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thùy Châu','FEMALE','2001-03-07','Bắc Ninh','0354737243','CUSTOMER', 'customer_287'),
('huyendido0606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Diệu Huyền','FEMALE','1992-02-06','Nghệ An','0981679188','CUSTOMER', 'customer_288'),
('kienthduong2409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Kiên','MALE','1992-11-27','Thái Bình','0908123930','CUSTOMER', 'customer_289'),
('huongthpham0805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Hương','FEMALE','2002-01-09','Bình Phước','0314062729','CUSTOMER', 'customer_290'),
('thaothphan1302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thanh Thảo','FEMALE','1993-04-27','Bắc Ninh','0356633711','CUSTOMER', 'customer_291'),
('dungquhoang1108@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Quang Dũng','MALE','1993-11-29','Quảng Nam','0381741931','CUSTOMER', 'customer_292'),
('huongthtran0402@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thanh Hương','FEMALE','2001-01-19','Tiền Giang','0336824962','CUSTOMER', 'customer_293'),
('huyenbibui1711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Bích Huyền','FEMALE','1990-03-29','Nghệ An','0370018244','CUSTOMER', 'customer_294'),
('nhungtuly1610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuyết Nhung','FEMALE','2001-04-29','Bắc Ninh','0310822076','CUSTOMER', 'customer_295'),
('quangcovu0903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Công Quang','MALE','1991-10-17','Lâm Đồng','0929163181','CUSTOMER', 'customer_296'),
('thaobidang2810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Bích Thảo','FEMALE','1992-08-18','Đồng Nai','0310026102','CUSTOMER', 'customer_297'),
('thaongho1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Thảo','FEMALE','2005-02-15','Bình Phước','0975314710','CUSTOMER', 'customer_298'),
('linhphdang0810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Phương Linh','FEMALE','1994-08-16','Hải Phòng','0911397858','CUSTOMER', 'customer_299'),
('ngahatran1806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hà Nga','FEMALE','1991-08-18','Vĩnh Phúc','0398338063','CUSTOMER', 'customer_300'),
('tamcovu2104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Công Tâm','MALE','1998-06-01','Thái Bình','0343410495','CUSTOMER', 'customer_301'),
('tuananbui0505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Anh Tuấn','MALE','1994-08-24','Cần Thơ','0361154809','CUSTOMER', 'customer_302'),
('hathbui1707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thùy Hà','FEMALE','2004-05-22','Hưng Yên','0989551797','CUSTOMER', 'customer_303'),
('lanthvu1606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thu Lan','FEMALE','2005-04-28','Quảng Nam','0989852254','CUSTOMER', 'customer_304'),
('huongthtran2303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thùy Hương','FEMALE','2005-01-10','Kiên Giang','0937283998','CUSTOMER', 'customer_305'),
('uyenthhoang2107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thanh Uyên','FEMALE','1993-08-04','Bình Định','0939865048','CUSTOMER', 'customer_306'),
('dungqule0409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Quang Dũng','MALE','1994-04-07','Bắc Ninh','0353944807','CUSTOMER', 'customer_307'),
('kienmihoang0511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Minh Kiên','MALE','2002-07-23','Long An','0943173477','CUSTOMER', 'customer_308'),
('hoamyho0907@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Mỹ Hoa','FEMALE','2000-11-06','Quảng Ninh','0337756093','CUSTOMER', 'customer_309'),
('huyenkily2506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Kim Huyền','FEMALE','1993-06-10','Cần Thơ','0929118318','CUSTOMER', 'customer_310'),
('phuongthho2505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thị Phương','FEMALE','1996-07-21','Quảng Ninh','0311990137','CUSTOMER', 'customer_311'),
('hanhmyngo2801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Mỹ Hạnh','FEMALE','1992-11-20','Bình Định','0989981776','CUSTOMER', 'customer_312'),
('phuongmyngo1012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Mỹ Phương','FEMALE','1996-12-11','Bắc Ninh','0930764912','CUSTOMER', 'customer_313'),
('tuanannguyen0110@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Anh Tuấn','MALE','1995-09-24','HCM','0398683803','CUSTOMER', 'customer_314'),
('sonmiphan1107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Sơn','MALE','2005-10-01','Vĩnh Long','0954293848','CUSTOMER', 'customer_315'),
('huyenngnguyen0407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Ngọc Huyền','FEMALE','1994-11-30','Lâm Đồng','0350183137','CUSTOMER', 'customer_316'),
('ngahaly2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hà Nga','FEMALE','1991-11-10','Tây Ninh','0379752196','CUSTOMER', 'customer_317'),
('phuctudang1410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Tuấn Phúc','MALE','2002-06-15','Bến Tre','0945346959','CUSTOMER', 'customer_318'),
('phucthphan1405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thanh Phúc','MALE','1992-04-26','Quảng Ngãi','0963265812','CUSTOMER', 'customer_319'),
('hungmihoang1301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Minh Hưng','MALE','2002-05-31','Tiền Giang','0987334881','CUSTOMER', 'customer_320'),
('trangthho1608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thị Trang','FEMALE','2002-03-14','Quảng Ninh','0397704763','CUSTOMER', 'customer_321'),
('mymyly0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Mỹ My','FEMALE','2001-01-03','Hải Phòng','0983059068','CUSTOMER', 'customer_322'),
('hoakido0602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Kim Hoa','FEMALE','1995-11-26','Thái Bình','0923670196','CUSTOMER', 'customer_323'),
('kienduho0704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Duy Kiên','MALE','1996-01-27','Trà Vinh','0925320859','CUSTOMER', 'customer_324'),
('tuancoho2702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Công Tuấn','MALE','1992-12-07','Huế','0958225874','CUSTOMER', 'customer_325'),
('phongmile2711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Minh Phong','MALE','2003-11-28','Hà Nội','0365257639','CUSTOMER', 'customer_326'),
('thaotuduong0309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuyết Thảo','FEMALE','2002-04-08','Đà Nẵng','0341280530','CUSTOMER', 'customer_327'),
('phuongthhoang2103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thị Phương','FEMALE','2001-04-28','Lâm Đồng','0961682656','CUSTOMER', 'customer_328'),
('ngabiphan1407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Bích Nga','FEMALE','1995-11-11','Hà Tĩnh','0988620795','CUSTOMER', 'customer_329'),
('hanhdibui1504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Diệu Hạnh','FEMALE','2002-01-18','Khánh Hòa','0316637621','CUSTOMER', 'customer_330'),
('quangthle0509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thanh Quang','MALE','1995-10-13','Vĩnh Phúc','0368830914','CUSTOMER', 'customer_331'),
('huongladuong2810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Lan Hương','FEMALE','2002-06-18','Bắc Ninh','0915644204','CUSTOMER', 'customer_332'),
('mytuly1906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuyết My','FEMALE','1994-11-10','Hà Nội','0321862148','CUSTOMER', 'customer_333'),
('uyenmynguyen1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Mỹ Uyên','FEMALE','2005-05-11','Phú Yên','0906568178','CUSTOMER', 'customer_334'),
('khoicoduong2406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Công Khôi','MALE','2002-08-11','Quảng Ngãi','0917231494','CUSTOMER', 'customer_335'),
('khoihodo2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hoàng Khôi','MALE','1998-03-21','HCM','0338826922','CUSTOMER', 'customer_336'),
('hanhphpham1703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Phương Hạnh','FEMALE','2002-01-30','Khánh Hòa','0943076365','CUSTOMER', 'customer_337'),
('chaubile2103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Bích Châu','FEMALE','2000-07-19','Nam Định','0969845960','CUSTOMER', 'customer_338'),
('tuanngbui1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Ngọc Tuấn','MALE','2004-09-23','Hưng Yên','0319630426','CUSTOMER', 'customer_339'),
('toanmiho0210@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Minh Toàn','MALE','2004-01-18','Hải Dương','0975932346','CUSTOMER', 'customer_340'),
('trangthvu2212@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thùy Trang','FEMALE','1995-09-06','HCM','0332237220','CUSTOMER', 'customer_341'),
('khoihaly0905@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hải Khôi','MALE','1994-08-23','Ninh Thuận','0960126755','CUSTOMER', 'customer_342'),
('huyenladuong1511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Lan Huyền','FEMALE','1990-05-29','Phú Yên','0382053270','CUSTOMER', 'customer_343'),
('phuongngphan0306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Ngọc Phương','FEMALE','1994-03-14','Hà Tĩnh','0952621852','CUSTOMER', 'customer_344'),
('hoabivu2512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Bích Hoa','FEMALE','1990-08-29','Khánh Hòa','0928030345','CUSTOMER', 'customer_345'),
('mylavu0404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Lan My','FEMALE','1994-02-04','Bến Tre','0933287387','CUSTOMER', 'customer_346'),
('tranghaphan2211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hà Trang','FEMALE','2002-12-29','Tây Ninh','0332256329','CUSTOMER', 'customer_347'),
('anhthbui1201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Anh','FEMALE','1993-02-04','Tiền Giang','0923576722','CUSTOMER', 'customer_348'),
('hungthngo2307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thanh Hưng','MALE','2001-11-20','Đà Nẵng','0355708174','CUSTOMER', 'customer_349'),
('myngngo1911@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc My','FEMALE','1992-08-20','Quảng Bình','0377061933','CUSTOMER', 'customer_350'),
('phuccobui2710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Công Phúc','MALE','1994-11-03','Khánh Hòa','0961228878','CUSTOMER', 'customer_351'),
('anhmyphan0107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Mỹ Anh','FEMALE','1993-03-16','Hưng Yên','0912092551','CUSTOMER', 'customer_352'),
('huongtudo2010@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Tuyết Hương','FEMALE','1992-07-01','Phú Yên','0377991954','CUSTOMER', 'customer_353'),
('maithtran1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thị Mai','FEMALE','2002-07-05','Quảng Nam','0365803677','CUSTOMER', 'customer_354'),
('nhunghabui1609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hà Nhung','FEMALE','2004-04-27','Hưng Yên','0934260045','CUSTOMER', 'customer_355'),
('dathango1511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hải Đạt','MALE','1993-10-15','Nghệ An','0925844403','CUSTOMER', 'customer_356'),
('khoicophan1410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Công Khôi','MALE','2004-06-22','Cần Thơ','0918127021','CUSTOMER', 'customer_357'),
('thuydibui2306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Diệu Thủy','FEMALE','2002-08-07','Hà Tĩnh','0343205286','CUSTOMER', 'customer_358'),
('longvapham1411@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Văn Long','MALE','2005-10-21','Vĩnh Phúc','0325357371','CUSTOMER', 'customer_359'),
('linhkido2208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Kim Linh','FEMALE','1991-01-06','Bình Định','0926029207','CUSTOMER', 'customer_360'),
('phucthdo2208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Phúc','MALE','1992-04-09','Bến Tre','0333716697','CUSTOMER', 'customer_361'),
('hungdudo2707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Đức Hùng','MALE','2005-05-23','Bắc Ninh','0360325537','CUSTOMER', 'customer_362'),
('phuongkily2512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Kim Phương','FEMALE','2001-02-15','Nghệ An','0970871425','CUSTOMER', 'customer_363'),
('hahaho1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hà Hà','FEMALE','2001-07-20','Vĩnh Phúc','0974441213','CUSTOMER', 'customer_364'),
('huyenmybui1304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Mỹ Huyền','FEMALE','2000-01-23','Lâm Đồng','0361818233','CUSTOMER', 'customer_365'),
('dungkhduong1910@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Khánh Dũng','MALE','1990-10-01','Long An','0975255175','CUSTOMER', 'customer_366'),
('namkhpham0411@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Khánh Nam','MALE','2002-11-29','Quảng Bình','0349274829','CUSTOMER', 'customer_367'),
('quangkhdang2404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Khánh Quang','MALE','2004-10-23','Tây Ninh','0398543375','CUSTOMER', 'customer_368'),
('binhhudang0601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hữu Bình','MALE','1994-09-07','Đồng Nai','0355493402','CUSTOMER', 'customer_369'),
('uyenkihoang1712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Kim Uyên','FEMALE','2002-06-01','Lâm Đồng','0925868335','CUSTOMER', 'customer_370'),
('khoihotran0309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hoàng Khôi','MALE','1991-01-31','Bình Dương','0916394114','CUSTOMER', 'customer_371'),
('vanthdang2211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thị Vân','FEMALE','1994-11-18','Bình Phước','0988683584','CUSTOMER', 'customer_372'),
('hieuhotran2105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hoàng Hiếu','MALE','1995-06-08','Bến Tre','0369148763','CUSTOMER', 'customer_373'),
('anhngduong2512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Ngọc Anh','FEMALE','2003-12-20','Hưng Yên','0979934939','CUSTOMER', 'customer_374'),
('maithhoang2108@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thu Mai','FEMALE','2004-04-23','Bình Dương','0932165457','CUSTOMER', 'customer_375'),
('hanhdile2304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Diệu Hạnh','FEMALE','1997-04-07','Bình Phước','0926739938','CUSTOMER', 'customer_376'),
('quangngphan0212@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Ngọc Quang','MALE','1990-01-09','Hải Dương','0920617234','CUSTOMER', 'customer_377'),
('hieuanphan1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Anh Hiếu','MALE','1993-03-17','Huế','0310362883','CUSTOMER', 'customer_378'),
('thanhvaho1408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Văn Thành','MALE','2004-09-17','Trà Vinh','0347458468','CUSTOMER', 'customer_379'),
('hungkhho0706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Khánh Hùng','MALE','1998-12-27','Quảng Ninh','0904797822','CUSTOMER', 'customer_380'),
('toanvango0810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Văn Toàn','MALE','1991-01-25','Quảng Ngãi','0379459633','CUSTOMER', 'customer_381'),
('thanhhudang0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hữu Thành','MALE','2003-06-19','Bến Tre','0952525508','CUSTOMER', 'customer_382'),
('haphduong0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Phương Hà','FEMALE','2002-09-08','Phú Yên','0908395753','CUSTOMER', 'customer_383'),
('tuanmingo0707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Minh Tuấn','MALE','2005-12-26','Hưng Yên','0964278794','CUSTOMER', 'customer_384'),
('phuchale0207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hải Phúc','MALE','1998-02-14','Quảng Bình','0396116970','CUSTOMER', 'customer_385'),
('huongdipham1409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Diệu Hương','FEMALE','1996-02-01','Huế','0969598014','CUSTOMER', 'customer_386'),
('vanthly0504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thùy Vân','FEMALE','1993-08-27','Hà Nội','0972884230','CUSTOMER', 'customer_387'),
('thutuphan1811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Tuyết Thu','FEMALE','2000-07-30','Bình Thuận','0932560218','CUSTOMER', 'customer_388'),
('thuthho1701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thanh Thu','FEMALE','2005-01-04','Bắc Ninh','0976271684','CUSTOMER', 'customer_389'),
('uyentutran1206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Tuyết Uyên','FEMALE','1994-09-08','Hà Tĩnh','0956319281','CUSTOMER', 'customer_390'),
('thaothhoang0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thu Thảo','FEMALE','1996-12-13','Đồng Nai','0958581449','CUSTOMER', 'customer_391'),
('quanghongo1909@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hoàng Quang','MALE','1998-01-17','Lâm Đồng','0340510813','CUSTOMER', 'customer_392'),
('longanngo2804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Anh Long','MALE','2002-12-24','HCM','0358310209','CUSTOMER', 'customer_393'),
('uyenthdang2708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thu Uyên','FEMALE','1996-02-23','Bình Thuận','0912638879','CUSTOMER', 'customer_394'),
('dungmitran1911@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Minh Dũng','MALE','1991-08-16','Bắc Ninh','0320061572','CUSTOMER', 'customer_395'),
('hanhdiho2106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Diệu Hạnh','FEMALE','2003-02-02','Bình Thuận','0972474319','CUSTOMER', 'customer_396'),
('maibiho2605@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Bích Mai','FEMALE','1996-01-31','Cần Thơ','0364064212','CUSTOMER', 'customer_397'),
('toanhudo2106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hữu Toàn','MALE','1999-02-01','Hưng Yên','0313475929','CUSTOMER', 'customer_398'),
('hungvahoang2309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Văn Hùng','MALE','1990-06-30','Tây Ninh','0985237165','CUSTOMER', 'customer_399'),
('sonquvu1206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Quang Sơn','MALE','2002-11-15','Bến Tre','0933080827','CUSTOMER', 'customer_400'),
('thudibui0804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Diệu Thu','FEMALE','1995-04-27','Ninh Thuận','0985070652','CUSTOMER', 'customer_401'),
('linhthngo1702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thùy Linh','FEMALE','1996-04-17','Đà Nẵng','0341796088','CUSTOMER', 'customer_402'),
('dattuduong1002@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuấn Đạt','MALE','1996-01-30','Quảng Ngãi','0388785372','CUSTOMER', 'customer_403'),
('thaomyhoang0205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Mỹ Thảo','FEMALE','2005-11-29','Long An','0313124986','CUSTOMER', 'customer_404'),
('thuykivu0909@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Kim Thủy','FEMALE','1990-06-22','Kiên Giang','0398796097','CUSTOMER', 'customer_405'),
('hanhngnguyen2502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Ngọc Hạnh','FEMALE','1994-06-13','Tiền Giang','0956535109','CUSTOMER', 'customer_406'),
('huyentule1204@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Tuyết Huyền','FEMALE','1995-06-14','Bình Định','0375245662','CUSTOMER', 'customer_407'),
('binhhaly1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hải Bình','MALE','1994-06-25','Quảng Nam','0393649516','CUSTOMER', 'customer_408'),
('lanthduong0103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Lan','FEMALE','1997-10-17','Lâm Đồng','0378093332','CUSTOMER', 'customer_409'),
('hungdunguyen1012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Duy Hùng','MALE','2001-07-09','Trà Vinh','0974198665','CUSTOMER', 'customer_410'),
('thuydiphan0502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Diệu Thủy','FEMALE','1999-12-08','Bến Tre','0391873002','CUSTOMER', 'customer_411'),
('phuonghongo0306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hồng Phương','FEMALE','2003-05-11','Quảng Bình','0987771048','CUSTOMER', 'customer_412'),
('phuongthduong0504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thùy Phương','FEMALE','1993-04-19','Thanh Hóa','0350816604','CUSTOMER', 'customer_413'),
('mailaduong2402@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Lan Mai','FEMALE','1993-07-02','Hà Tĩnh','0922831995','CUSTOMER', 'customer_414'),
('nhungbingo1004@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Bích Nhung','FEMALE','2001-09-02','Hải Phòng','0384652966','CUSTOMER', 'customer_415'),
('hanhhaphan0406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hà Hạnh','FEMALE','1999-03-26','An Giang','0386509593','CUSTOMER', 'customer_416'),
('thubingo0906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Bích Thu','FEMALE','2002-12-18','Tây Ninh','0387372316','CUSTOMER', 'customer_417'),
('hieungdo2412@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Hiếu','MALE','2001-03-09','Bến Tre','0975250525','CUSTOMER', 'customer_418'),
('huongthphan1001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thanh Hương','FEMALE','2003-08-14','Nam Định','0347004677','CUSTOMER', 'customer_419'),
('sonkhduong1402@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Khánh Sơn','MALE','2001-02-17','Khánh Hòa','0362373437','CUSTOMER', 'customer_420'),
('hoakipham1704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Kim Hoa','FEMALE','1995-10-11','Đồng Nai','0904606734','CUSTOMER', 'customer_421'),
('longhophan1405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hoàng Long','MALE','1991-11-14','Bình Dương','0380391765','CUSTOMER', 'customer_422'),
('linhbipham0304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Bích Linh','FEMALE','1996-01-07','Bình Định','0971138982','CUSTOMER', 'customer_423'),
('thuyngdo1102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Thủy','FEMALE','2001-12-06','Trà Vinh','0375342128','CUSTOMER', 'customer_424'),
('chaungngo0403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc Châu','FEMALE','1993-02-25','Bình Định','0398965940','CUSTOMER', 'customer_425'),
('ngaphtran1603@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Phương Nga','FEMALE','1991-08-27','Bình Dương','0393086411','CUSTOMER', 'customer_426'),
('hanhhonguyen2809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hồng Hạnh','FEMALE','1991-08-08','Hải Dương','0332285396','CUSTOMER', 'customer_427'),
('hungduly2808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Duy Hùng','MALE','2004-04-10','Ninh Thuận','0315974849','CUSTOMER', 'customer_428'),
('kienhale2105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hải Kiên','MALE','2005-08-02','Bình Thuận','0924525165','CUSTOMER', 'customer_429'),
('nhunglapham2308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Lan Nhung','FEMALE','1995-03-02','Đà Nẵng','0937884404','CUSTOMER', 'customer_430'),
('hungvale0402@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Văn Hưng','MALE','1998-06-29','Trà Vinh','0955639931','CUSTOMER', 'customer_431'),
('linhthphan0401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thị Linh','FEMALE','2001-06-26','Kiên Giang','0960832111','CUSTOMER', 'customer_432'),
('hungconguyen1702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Công Hùng','MALE','1992-06-18','Hà Tĩnh','0953026324','CUSTOMER', 'customer_433'),
('lanphho1303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Phương Lan','FEMALE','1998-03-19','Bình Định','0900714149','CUSTOMER', 'customer_434'),
('datngtran1607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Ngọc Đạt','MALE','1996-06-20','Tây Ninh','0333620194','CUSTOMER', 'customer_435'),
('anhlango2302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Lan Anh','FEMALE','2003-07-29','Hà Nội','0983625422','CUSTOMER', 'customer_436'),
('thuyhango2009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hà Thủy','FEMALE','1995-05-21','Hải Phòng','0353374698','CUSTOMER', 'customer_437'),
('dungthnguyen1201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh Dũng','MALE','2004-12-31','Hưng Yên','0372891499','CUSTOMER', 'customer_438'),
('binhvaly0110@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Văn Bình','MALE','1994-06-04','Tiền Giang','0385298362','CUSTOMER', 'customer_439'),
('dungkhtran2510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Khánh Dũng','MALE','2001-12-26','Tiền Giang','0361825436','CUSTOMER', 'customer_440'),
('thaolaphan2506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Lan Thảo','FEMALE','1997-07-22','Nam Định','0355072230','CUSTOMER', 'customer_441'),
('kienduly1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Duy Kiên','MALE','2000-04-11','Khánh Hòa','0390761390','CUSTOMER', 'customer_442'),
('mymyho2604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Mỹ My','FEMALE','1994-04-22','Quảng Bình','0920430720','CUSTOMER', 'customer_443'),
('thutungo1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Tuyết Thu','FEMALE','1990-10-11','An Giang','0963544930','CUSTOMER', 'customer_444'),
('vantuho0107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Tuyết Vân','FEMALE','2001-04-27','Vĩnh Long','0960775862','CUSTOMER', 'customer_445'),
('ngahole1312@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hồng Nga','FEMALE','2000-09-06','Bắc Ninh','0989212513','CUSTOMER', 'customer_446'),
('hungdungo0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Đức Hùng','MALE','2001-09-02','Bến Tre','0354898753','CUSTOMER', 'customer_447'),
('huyenthbui0211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Huyền','FEMALE','2000-10-22','Hải Phòng','0974158486','CUSTOMER', 'customer_448'),
('hanhbihoang2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Bích Hạnh','FEMALE','1993-05-09','Thanh Hóa','0318018858','CUSTOMER', 'customer_449'),
('tuanhule1603@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hữu Tuấn','MALE','2002-10-05','Tây Ninh','0342562371','CUSTOMER', 'customer_450'),
('hungdungo2304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Duy Hưng','MALE','1995-01-16','Hưng Yên','0372161331','CUSTOMER', 'customer_451'),
('linhbiho0111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Bích Linh','FEMALE','2001-07-21','Nghệ An','0334094474','CUSTOMER', 'customer_452'),
('toantudo2511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Tuấn Toàn','MALE','2002-10-25','Hải Phòng','0312094360','CUSTOMER', 'customer_453'),
('phuongngpham1903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Ngọc Phương','FEMALE','1993-07-24','Trà Vinh','0349062614','CUSTOMER', 'customer_454'),
('longthdo2312@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Long','MALE','1995-02-27','Bình Thuận','0955678851','CUSTOMER', 'customer_455'),
('binhdudang2406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Duy Bình','MALE','1994-04-21','Vĩnh Phúc','0382607414','CUSTOMER', 'customer_456'),
('thanhduduong1307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Đức Thành','MALE','2004-02-23','Vĩnh Phúc','0962611944','CUSTOMER', 'customer_457'),
('quanghohoang0401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hoàng Quang','MALE','2005-07-20','Bình Phước','0360357341','CUSTOMER', 'customer_458'),
('trangphnguyen2111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Phương Trang','FEMALE','2000-01-02','Bến Tre','0317695900','CUSTOMER', 'customer_459'),
('hanhmyho2407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Mỹ Hạnh','FEMALE','2002-03-10','Trà Vinh','0966072080','CUSTOMER', 'customer_460'),
('kienduho1908@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Duy Kiên','MALE','1997-12-09','Cần Thơ','0942211856','CUSTOMER', 'customer_461'),
('hunghaphan0710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hải Hùng','MALE','1992-09-01','Bình Thuận','0923217162','CUSTOMER', 'customer_462'),
('vinhdutran1706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Đức Vinh','MALE','1996-06-01','Kiên Giang','0319150613','CUSTOMER', 'customer_463'),
('tamhonguyen1101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hoàng Tâm','MALE','2000-04-24','Quảng Ninh','0372724224','CUSTOMER', 'customer_464'),
('hieudunguyen1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Duy Hiếu','MALE','1998-03-06','Hải Phòng','0374897533','CUSTOMER', 'customer_465'),
('longkhtran1004@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Khánh Long','MALE','1990-04-02','Quảng Ninh','0938020168','CUSTOMER', 'customer_466'),
('longduvu1808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Duy Long','MALE','2001-03-14','Hà Nội','0397037037','CUSTOMER', 'customer_467'),
('thuythly2408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thị Thủy','FEMALE','2003-04-22','Đà Nẵng','0942824921','CUSTOMER', 'customer_468'),
('hoanghoang1604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Ngọc Hoa','FEMALE','1990-08-09','Phú Yên','0956145368','CUSTOMER', 'customer_469'),
('huonghodang0401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hồng Hương','FEMALE','1997-05-09','Phú Yên','0341195549','CUSTOMER', 'customer_470'),
('sonhabui1705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hải Sơn','MALE','1990-11-03','Bình Phước','0337523319','CUSTOMER', 'customer_471'),
('chauthpham0202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Châu','FEMALE','2002-02-05','Bến Tre','0366454999','CUSTOMER', 'customer_472'),
('tuanminguyen2502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Minh Tuấn','MALE','1996-06-10','Hải Dương','0924894891','CUSTOMER', 'customer_473'),
('lanlavu1603@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Lan Lan','FEMALE','1991-11-28','Huế','0959361664','CUSTOMER', 'customer_474'),
('thanhanphan1706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Anh Thành','MALE','1999-12-26','Hà Tĩnh','0939631915','CUSTOMER', 'customer_475'),
('hathhoang2712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thị Hà','FEMALE','2003-01-05','Đồng Nai','0325038791','CUSTOMER', 'customer_476'),
('hadile1907@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Diệu Hà','FEMALE','1995-08-07','An Giang','0339909112','CUSTOMER', 'customer_477'),
('myngbui1806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Ngọc My','FEMALE','1993-09-14','HCM','0348847584','CUSTOMER', 'customer_478'),
('vinhdunguyen0311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Đức Vinh','MALE','1997-11-29','Phú Yên','0377880679','CUSTOMER', 'customer_479'),
('vinhanhoang0204@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Anh Vinh','MALE','1995-05-20','Hải Dương','0393816759','CUSTOMER', 'customer_480'),
('phongtutran2610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Tuấn Phong','MALE','2003-02-14','Bình Định','0393193622','CUSTOMER', 'customer_481'),
('thuymybui2708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Mỹ Thủy','FEMALE','1994-01-27','Thái Bình','0910716486','CUSTOMER', 'customer_482'),
('datkhle1612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Khánh Đạt','MALE','2005-03-20','Vĩnh Long','0907935550','CUSTOMER', 'customer_483'),
('dunghodo2006@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hoàng Dũng','MALE','2004-12-23','Nam Định','0373113524','CUSTOMER', 'customer_484'),
('vankingo0810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Kim Vân','FEMALE','2005-02-05','Trà Vinh','0936099920','CUSTOMER', 'customer_485'),
('longkhdang1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Khánh Long','MALE','2001-01-23','Đà Nẵng','0324357812','CUSTOMER', 'customer_486'),
('vinhanbui0504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Anh Vinh','MALE','1993-09-27','Bình Phước','0323002525','CUSTOMER', 'customer_487'),
('phucanhoang1710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Anh Phúc','MALE','1991-09-07','Hải Phòng','0331442489','CUSTOMER', 'customer_488'),
('datduho1812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Đức Đạt','MALE','2001-04-20','Khánh Hòa','0960370997','CUSTOMER', 'customer_489'),
('tuanhohoang0401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hoàng Tuấn','MALE','1990-02-03','Bắc Ninh','0385665559','CUSTOMER', 'customer_490'),
('kienduphan2405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Duy Kiên','MALE','1995-04-28','Bến Tre','0957134373','CUSTOMER', 'customer_491'),
('chaudile2705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Diệu Châu','FEMALE','2004-11-08','Bình Phước','0334755174','CUSTOMER', 'customer_492'),
('hunganbui2306@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Anh Hùng','MALE','2004-01-31','Vĩnh Phúc','0975408735','CUSTOMER', 'customer_493'),
('vantubui2303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Tuyết Vân','FEMALE','1995-10-30','Vĩnh Long','0929226762','CUSTOMER', 'customer_494'),
('nhunglado1711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Lan Nhung','FEMALE','1994-05-24','Kiên Giang','0922208627','CUSTOMER', 'customer_495'),
('anhbiho2110@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Bích Anh','FEMALE','1991-04-06','Hưng Yên','0912719093','CUSTOMER', 'customer_496'),
('quangthvu2809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thanh Quang','MALE','2000-01-26','Quảng Nam','0365532579','CUSTOMER', 'customer_497'),
('dungkhngo1309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Khánh Dũng','MALE','1999-03-31','Hưng Yên','0346481595','CUSTOMER', 'customer_498'),
('tuanthtran0904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thanh Tuấn','MALE','2003-04-29','Quảng Bình','0350942840','CUSTOMER', 'customer_499'),
('toanthho2202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thanh Toàn','MALE','1995-02-07','An Giang','0960483823','CUSTOMER', 'customer_500'),
('hanhngngo0408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc Hạnh','FEMALE','1992-01-12','Bến Tre','0915378256','CUSTOMER', 'customer_501'),
('namhale2102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hải Nam','MALE','1996-03-09','Bình Định','0321252754','CUSTOMER', 'customer_502'),
('thukiho0406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Kim Thu','FEMALE','2004-06-10','Ninh Thuận','0951123138','CUSTOMER', 'customer_503'),
('ngamybui1711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Mỹ Nga','FEMALE','1993-12-25','Lâm Đồng','0353859081','CUSTOMER', 'customer_504'),
('mytubui1410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Tuyết My','FEMALE','2004-09-28','Bình Thuận','0388035025','CUSTOMER', 'customer_505'),
('hunghale2609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hải Hùng','MALE','1996-01-02','Nam Định','0918043042','CUSTOMER', 'customer_506'),
('quangdunguyen2407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Duy Quang','MALE','1992-06-01','Hưng Yên','0353422630','CUSTOMER', 'customer_507'),
('hungdutran2709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Đức Hưng','MALE','1992-11-28','Đồng Nai','0962290746','CUSTOMER', 'customer_508'),
('quangdunguyen1403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Đức Quang','MALE','2005-02-27','Bến Tre','0937133516','CUSTOMER', 'customer_509'),
('thaohaduong0206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hà Thảo','FEMALE','1998-12-22','Nam Định','0923778475','CUSTOMER', 'customer_510'),
('thaothpham2704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Thảo','FEMALE','2005-10-09','An Giang','0958267254','CUSTOMER', 'customer_511'),
('chauthnguyen0302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh Châu','FEMALE','1994-08-24','Nghệ An','0901758684','CUSTOMER', 'customer_512'),
('maitudo1506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Tuyết Mai','FEMALE','1995-03-04','Hưng Yên','0319692000','CUSTOMER', 'customer_513'),
('tuanvaly1812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Văn Tuấn','MALE','2002-02-11','Tiền Giang','0345006730','CUSTOMER', 'customer_514'),
('quangqupham0202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Quang Quang','MALE','1990-09-06','Bình Phước','0976770589','CUSTOMER', 'customer_515'),
('tamngphan1003@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Ngọc Tâm','MALE','1993-03-14','Khánh Hòa','0910067167','CUSTOMER', 'customer_516'),
('dathungo1406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hữu Đạt','MALE','2001-07-11','Trà Vinh','0350299034','CUSTOMER', 'customer_517'),
('namthbui2203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Nam','MALE','2004-01-15','Phú Yên','0344639822','CUSTOMER', 'customer_518'),
('anhmyhoang0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Mỹ Anh','FEMALE','1998-06-21','Bình Định','0394004483','CUSTOMER', 'customer_519'),
('hanhkiphan1408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Kim Hạnh','FEMALE','2003-11-01','Bình Phước','0941878695','CUSTOMER', 'customer_520'),
('vinhcohoang0509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Công Vinh','MALE','1990-01-31','Bình Phước','0903968495','CUSTOMER', 'customer_521'),
('tamanle2006@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Anh Tâm','MALE','1990-01-11','Bình Dương','0938605116','CUSTOMER', 'customer_522'),
('sondudang1204@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Duy Sơn','MALE','1991-02-27','Phú Yên','0934370408','CUSTOMER', 'customer_523'),
('kienthduong2008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Kiên','MALE','2001-05-25','Phú Yên','0955470359','CUSTOMER', 'customer_524'),
('hanhlabui1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Lan Hạnh','FEMALE','2000-03-06','Bình Định','0987789382','CUSTOMER', 'customer_525'),
('khoituvu1109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Tuấn Khôi','MALE','1993-08-20','Thái Bình','0349790682','CUSTOMER', 'customer_526'),
('trangmytran1806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Mỹ Trang','FEMALE','1995-09-10','Trà Vinh','0927954955','CUSTOMER', 'customer_527'),
('nhungthho1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thùy Nhung','FEMALE','1997-03-01','Cần Thơ','0949590233','CUSTOMER', 'customer_528'),
('hieuduphan2610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Đức Hiếu','MALE','2004-12-19','Thái Bình','0357230844','CUSTOMER', 'customer_529'),
('sontunguyen1611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Sơn','MALE','1995-08-17','Quảng Bình','0316983922','CUSTOMER', 'customer_530'),
('vinhqupham1301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Quang Vinh','MALE','1995-01-30','Đồng Nai','0901430652','CUSTOMER', 'customer_531'),
('trangmyngo0706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Mỹ Trang','FEMALE','1996-07-01','Nam Định','0311577245','CUSTOMER', 'customer_532'),
('phucduduong1403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Duy Phúc','MALE','2002-01-14','Quảng Ngãi','0988961870','CUSTOMER', 'customer_533'),
('linhhatran2706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hà Linh','FEMALE','1995-03-07','Tiền Giang','0350899930','CUSTOMER', 'customer_534'),
('hungkhvu0204@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Khánh Hưng','MALE','1997-02-24','Huế','0920321757','CUSTOMER', 'customer_535'),
('vinhhohoang2511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hoàng Vinh','MALE','1992-06-15','Hải Dương','0323899450','CUSTOMER', 'customer_536'),
('taidupham2701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Duy Tài','MALE','1997-06-05','Hà Nội','0920654827','CUSTOMER', 'customer_537'),
('lanthho1203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thị Lan','FEMALE','2005-04-07','Thanh Hóa','0326184424','CUSTOMER', 'customer_538'),
('sonanvu0402@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Anh Sơn','MALE','1997-09-15','HCM','0958673327','CUSTOMER', 'customer_539'),
('thaongngo0804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc Thảo','FEMALE','1998-06-14','Long An','0979146757','CUSTOMER', 'customer_540'),
('maidivu2211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Diệu Mai','FEMALE','2002-06-01','Tiền Giang','0988326942','CUSTOMER', 'customer_541'),
('thuphpham0302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Phương Thu','FEMALE','2003-12-22','Vĩnh Phúc','0323564222','CUSTOMER', 'customer_542'),
('phonghadang2111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hải Phong','MALE','1994-04-08','Bình Định','0344351071','CUSTOMER', 'customer_543'),
('nhungdihoang1608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Diệu Nhung','FEMALE','1992-08-26','Quảng Ninh','0398566184','CUSTOMER', 'customer_544'),
('uyentuly2012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuyết Uyên','FEMALE','1998-04-19','Hưng Yên','0364585067','CUSTOMER', 'customer_545'),
('haphphan0701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Phương Hà','FEMALE','2002-11-01','Hải Phòng','0977687595','CUSTOMER', 'customer_546'),
('hadile2105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Diệu Hà','FEMALE','2002-11-02','Bình Phước','0331452809','CUSTOMER', 'customer_547'),
('namvatran1309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Văn Nam','MALE','2002-06-05','Hải Dương','0357709977','CUSTOMER', 'customer_548'),
('hungdudo2506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Đức Hưng','MALE','2003-03-25','Hưng Yên','0365982150','CUSTOMER', 'customer_549'),
('quangminguyen2001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Minh Quang','MALE','2001-12-13','Hải Phòng','0903240775','CUSTOMER', 'customer_550'),
('huyenthphan1611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thùy Huyền','FEMALE','1997-03-21','Nghệ An','0931572703','CUSTOMER', 'customer_551'),
('tuanhoduong2502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hoàng Tuấn','MALE','2002-09-26','Thái Bình','0944760842','CUSTOMER', 'customer_552'),
('mainghoang1606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Ngọc Mai','FEMALE','1990-02-05','Đồng Nai','0966364915','CUSTOMER', 'customer_553'),
('uyenphly1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Phương Uyên','FEMALE','1993-09-14','Hải Dương','0925272100','CUSTOMER', 'customer_554'),
('huyenphdo2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Phương Huyền','FEMALE','1997-09-06','Bình Định','0908971217','CUSTOMER', 'customer_555'),
('sonmile0704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Minh Sơn','MALE','1997-10-08','Thái Bình','0362158260','CUSTOMER', 'customer_556'),
('taithdo1102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Tài','MALE','1994-11-25','Quảng Ngãi','0973795853','CUSTOMER', 'customer_557'),
('hoatunguyen1509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuyết Hoa','FEMALE','1992-10-06','HCM','0935133041','CUSTOMER', 'customer_558'),
('uyenbily1112@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Bích Uyên','FEMALE','2001-09-08','Hải Dương','0318769251','CUSTOMER', 'customer_559'),
('chauthbui2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thị Châu','FEMALE','2005-05-08','Quảng Nam','0984707559','CUSTOMER', 'customer_560'),
('maimydo1901@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Mỹ Mai','FEMALE','1995-06-18','Phú Yên','0388040965','CUSTOMER', 'customer_561'),
('thubingo2206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Bích Thu','FEMALE','1992-03-24','Quảng Ninh','0338949206','CUSTOMER', 'customer_562'),
('uyendiphan2612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Diệu Uyên','FEMALE','1998-08-21','Bình Thuận','0914892906','CUSTOMER', 'customer_563'),
('nhungphdang0605@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Phương Nhung','FEMALE','1992-12-20','An Giang','0375703098','CUSTOMER', 'customer_564'),
('uyenthdo1501@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thùy Uyên','FEMALE','1999-03-25','Ninh Thuận','0384050609','CUSTOMER', 'customer_565'),
('thaothvu1110@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thị Thảo','FEMALE','1992-02-21','Cần Thơ','0920629978','CUSTOMER', 'customer_566'),
('tuanvanguyen2005@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Văn Tuấn','MALE','1991-10-09','Quảng Ngãi','0365444786','CUSTOMER', 'customer_567'),
('thungngo0101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc Thu','FEMALE','1998-04-18','Huế','0323297067','CUSTOMER', 'customer_568'),
('kienhudo2209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hữu Kiên','MALE','2001-07-16','Bình Dương','0950357004','CUSTOMER', 'customer_569'),
('hieuvango2408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Văn Hiếu','MALE','2002-07-31','Quảng Bình','0362611280','CUSTOMER', 'customer_570'),
('taitunguyen2302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Tài','MALE','1991-04-12','Hải Dương','0324694581','CUSTOMER', 'customer_571'),
('nhungthle0810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Nhung','FEMALE','1992-08-03','Ninh Thuận','0953743521','CUSTOMER', 'customer_572'),
('tuankhbui0804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Khánh Tuấn','MALE','2003-03-27','Bắc Ninh','0963579803','CUSTOMER', 'customer_573'),
('hakihoang0102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Kim Hà','FEMALE','2002-04-25','Bình Thuận','0333731972','CUSTOMER', 'customer_574'),
('hathphan1611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thùy Hà','FEMALE','1998-03-16','Long An','0369368820','CUSTOMER', 'customer_575'),
('hieungbui2006@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Ngọc Hiếu','MALE','2003-02-01','Tây Ninh','0310635300','CUSTOMER', 'customer_576'),
('uyenthhoang0105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thanh Uyên','FEMALE','1993-12-19','Bình Định','0950812713','CUSTOMER', 'customer_577'),
('dungvanguyen0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Văn Dũng','MALE','1997-10-21','Hà Tĩnh','0984967836','CUSTOMER', 'customer_578'),
('taihaho2602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hải Tài','MALE','1996-07-23','An Giang','0913725324','CUSTOMER', 'customer_579'),
('quangtutran0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Tuấn Quang','MALE','2003-02-10','Hà Nội','0387784687','CUSTOMER', 'customer_580'),
('mymyvu0102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Mỹ My','FEMALE','2002-07-08','Vĩnh Phúc','0956574053','CUSTOMER', 'customer_581'),
('thaolavu0209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Lan Thảo','FEMALE','1992-05-29','Bắc Ninh','0964796386','CUSTOMER', 'customer_582'),
('toantuho1105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Tuấn Toàn','MALE','2004-03-16','Hải Phòng','0956974243','CUSTOMER', 'customer_583'),
('hungdungo2507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Duy Hưng','MALE','2001-12-10','Bến Tre','0922137106','CUSTOMER', 'customer_584'),
('tuandupham0504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Duy Tuấn','MALE','1998-03-02','Bắc Ninh','0378073440','CUSTOMER', 'customer_585'),
('hunghupham0206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hữu Hùng','MALE','2004-07-07','Khánh Hòa','0314352301','CUSTOMER', 'customer_586'),
('hanhlanguyen0109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Lan Hạnh','FEMALE','1990-03-17','Bắc Ninh','0360164003','CUSTOMER', 'customer_587'),
('hungdutran1412@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Duy Hùng','MALE','2004-03-11','Nghệ An','0361875640','CUSTOMER', 'customer_588'),
('hatuho1707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Tuyết Hà','FEMALE','1997-04-10','Tiền Giang','0930678202','CUSTOMER', 'customer_589'),
('thanhhuly1104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hữu Thành','MALE','2005-08-01','Bình Thuận','0908116287','CUSTOMER', 'customer_590'),
('ngalaly1108@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Lan Nga','FEMALE','1999-11-09','Khánh Hòa','0900514088','CUSTOMER', 'customer_591'),
('sonmiphan2612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Sơn','MALE','1997-11-06','Bình Phước','0354219347','CUSTOMER', 'customer_592'),
('mymyly0103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Mỹ My','FEMALE','1991-04-27','Đồng Nai','0314832598','CUSTOMER', 'customer_593'),
('ngabinguyen2312@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Bích Nga','FEMALE','1996-03-23','Thanh Hóa','0939481549','CUSTOMER', 'customer_594'),
('dungvado1405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Văn Dũng','MALE','1994-08-08','Phú Yên','0917934003','CUSTOMER', 'customer_595'),
('nhungthdang2212@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thu Nhung','FEMALE','1994-02-01','Vĩnh Phúc','0341437766','CUSTOMER', 'customer_596'),
('binhcodo2604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Công Bình','MALE','2002-06-18','An Giang','0960623038','CUSTOMER', 'customer_597'),
('lanhohoang2602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hồng Lan','FEMALE','1996-09-03','Ninh Thuận','0907316505','CUSTOMER', 'customer_598'),
('phonghuho1409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hữu Phong','MALE','1998-08-30','Ninh Thuận','0906439179','CUSTOMER', 'customer_599'),
('khoithnguyen1210@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh Khôi','MALE','1998-02-25','Đà Nẵng','0986041209','CUSTOMER', 'customer_600'),
('quanganpham1107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Anh Quang','MALE','1994-07-28','Kiên Giang','0381718183','CUSTOMER', 'customer_601'),
('lankily1102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Kim Lan','FEMALE','1999-06-23','Quảng Ninh','0319746887','CUSTOMER', 'customer_602'),
('hungtuphan0908@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Tuấn Hưng','MALE','1991-02-27','Bình Thuận','0967445133','CUSTOMER', 'customer_603'),
('thaothnguyen2807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thu Thảo','FEMALE','1993-07-10','Vĩnh Long','0918135295','CUSTOMER', 'customer_604'),
('uyenlatran2407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Lan Uyên','FEMALE','1990-11-26','Bình Phước','0949152108','CUSTOMER', 'customer_605'),
('hunghaduong2706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hải Hưng','MALE','1996-08-13','Hà Tĩnh','0348601023','CUSTOMER', 'customer_606'),
('huongthdo2811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Hương','FEMALE','1993-10-03','Tây Ninh','0972410029','CUSTOMER', 'customer_607'),
('hungqudang1812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Quang Hưng','MALE','2005-12-18','Lâm Đồng','0347834346','CUSTOMER', 'customer_608'),
('dungvapham2503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Văn Dũng','MALE','2002-05-16','Hải Dương','0318581889','CUSTOMER', 'customer_609'),
('kiendungo1804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Duy Kiên','MALE','1994-01-28','Vĩnh Long','0951039903','CUSTOMER', 'customer_610'),
('thanhhudo2805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hữu Thành','MALE','2001-03-22','Huế','0381194797','CUSTOMER', 'customer_611'),
('mythphan1310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thùy My','FEMALE','1995-10-21','Hà Nội','0966201389','CUSTOMER', 'customer_612'),
('kienquho0308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Quang Kiên','MALE','1999-06-10','Lâm Đồng','0977115988','CUSTOMER', 'customer_613'),
('longmiphan2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Long','MALE','1992-07-10','Vĩnh Phúc','0361529180','CUSTOMER', 'customer_614'),
('hangdang2201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Hà','FEMALE','2000-04-19','Cần Thơ','0381783417','CUSTOMER', 'customer_615'),
('vinhhotran1507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hoàng Vinh','MALE','2004-08-30','Quảng Ninh','0974682050','CUSTOMER', 'customer_616'),
('hungvahoang2106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Văn Hùng','MALE','1998-12-23','Ninh Thuận','0986361057','CUSTOMER', 'customer_617'),
('datqudang1008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Quang Đạt','MALE','1995-06-29','Lâm Đồng','0909803480','CUSTOMER', 'customer_618'),
('thuymyle2111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Mỹ Thủy','FEMALE','2002-11-25','Bình Dương','0952306972','CUSTOMER', 'customer_619'),
('hungdungo1206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Đức Hùng','MALE','2005-07-31','Long An','0331242890','CUSTOMER', 'customer_620'),
('mybivu0404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Bích My','FEMALE','1998-06-08','Quảng Ninh','0939239516','CUSTOMER', 'customer_621'),
('hungdutran1001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Duy Hưng','MALE','2001-10-02','Hải Phòng','0933635575','CUSTOMER', 'customer_622'),
('hanhkidang1612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Kim Hạnh','FEMALE','1993-07-12','Đồng Nai','0954441697','CUSTOMER', 'customer_623'),
('huyenlapham0802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Lan Huyền','FEMALE','1991-11-04','Tây Ninh','0949383352','CUSTOMER', 'customer_624'),
('hakidang2509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Kim Hà','FEMALE','2002-12-29','Phú Yên','0373218188','CUSTOMER', 'customer_625'),
('thuyladuong2601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Lan Thủy','FEMALE','1996-12-24','Tiền Giang','0912354186','CUSTOMER', 'customer_626'),
('nhungtule0107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Tuyết Nhung','FEMALE','1993-05-10','Đà Nẵng','0934988624','CUSTOMER', 'customer_627'),
('vinhduduong2103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Đức Vinh','MALE','1990-07-22','Nghệ An','0334767583','CUSTOMER', 'customer_628'),
('vanthly2609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thu Vân','FEMALE','1996-03-16','Quảng Ninh','0971502925','CUSTOMER', 'customer_629'),
('phuongthpham1409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Phương','FEMALE','2003-12-29','Đà Nẵng','0903995177','CUSTOMER', 'customer_630'),
('datngho2711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Đạt','MALE','1990-04-01','Khánh Hòa','0368982774','CUSTOMER', 'customer_631'),
('mythngo1504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thị My','FEMALE','1994-03-04','Huế','0929132304','CUSTOMER', 'customer_632'),
('hanhtudo2707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Tuyết Hạnh','FEMALE','2001-06-25','Hà Nội','0952878333','CUSTOMER', 'customer_633'),
('thanhvabui1208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Văn Thành','MALE','2000-05-21','Vĩnh Phúc','0359941237','CUSTOMER', 'customer_634'),
('vinhhudo1311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hữu Vinh','MALE','2004-03-04','Quảng Bình','0924553102','CUSTOMER', 'customer_635'),
('khoitunguyen1811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Khôi','MALE','1998-06-26','Bắc Ninh','0981351208','CUSTOMER', 'customer_636'),
('hanhkitran1604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Kim Hạnh','FEMALE','1990-07-17','Huế','0913775090','CUSTOMER', 'customer_637'),
('binhtuphan0902@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Tuấn Bình','MALE','2003-03-02','Tây Ninh','0394931708','CUSTOMER', 'customer_638'),
('ngahovu1008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hồng Nga','FEMALE','1994-06-21','Nam Định','0386991155','CUSTOMER', 'customer_639'),
('sonngle2505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Ngọc Sơn','MALE','1995-10-05','Phú Yên','0364334670','CUSTOMER', 'customer_640'),
('thuthho1401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thùy Thu','FEMALE','1995-05-28','Quảng Ninh','0379378161','CUSTOMER', 'customer_641'),
('chauhovu2406@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hồng Châu','FEMALE','2003-12-02','Kiên Giang','0324490157','CUSTOMER', 'customer_642'),
('tamngho2503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Tâm','MALE','1999-04-28','Ninh Thuận','0377977162','CUSTOMER', 'customer_643'),
('longhado1102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hải Long','MALE','1994-10-28','Hưng Yên','0340345541','CUSTOMER', 'customer_644'),
('namdupham2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Đức Nam','MALE','1998-12-10','Quảng Bình','0393444288','CUSTOMER', 'customer_645'),
('sonhahoang2106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hải Sơn','MALE','1995-09-01','Đà Nẵng','0948402094','CUSTOMER', 'customer_646'),
('sonhubui0105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hữu Sơn','MALE','1992-03-30','Bình Phước','0336448322','CUSTOMER', 'customer_647'),
('mythvu2401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thùy My','FEMALE','1993-12-15','Phú Yên','0342946736','CUSTOMER', 'customer_648'),
('binhhavu0904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hải Bình','MALE','2004-09-12','Hà Tĩnh','0395136733','CUSTOMER', 'customer_649'),
('hungthdo2505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Hùng','MALE','2000-01-11','Hải Dương','0979870562','CUSTOMER', 'customer_650'),
('datanho2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Anh Đạt','MALE','1991-09-05','Lâm Đồng','0398025309','CUSTOMER', 'customer_651'),
('datmiho2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Minh Đạt','MALE','1998-06-07','Thanh Hóa','0901581614','CUSTOMER', 'customer_652'),
('tuanthdang1411@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thanh Tuấn','MALE','1994-03-04','Trà Vinh','0344606161','CUSTOMER', 'customer_653'),
('binhqudo2007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Quang Bình','MALE','2005-10-20','Tây Ninh','0952363115','CUSTOMER', 'customer_654'),
('linhthtran0710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thùy Linh','FEMALE','1995-09-14','Bình Định','0366180833','CUSTOMER', 'customer_655'),
('hanhthho2710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thùy Hạnh','FEMALE','2003-07-30','Bình Dương','0328439114','CUSTOMER', 'customer_656'),
('taihule2403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hữu Tài','MALE','1994-09-04','Hưng Yên','0379445578','CUSTOMER', 'customer_657'),
('quangthduong1707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Quang','MALE','1991-04-01','Thanh Hóa','0929528191','CUSTOMER', 'customer_658'),
('longduvu0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đức Long','MALE','1993-02-25','Thanh Hóa','0314888790','CUSTOMER', 'customer_659'),
('hanhlado1301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Lan Hạnh','FEMALE','2000-03-06','Huế','0349799325','CUSTOMER', 'customer_660'),
('hoathly1409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thùy Hoa','FEMALE','2003-10-21','Ninh Thuận','0330216000','CUSTOMER', 'customer_661'),
('phongthduong1503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Phong','MALE','1993-04-23','Huế','0957760459','CUSTOMER', 'customer_662'),
('mybibui0304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Bích My','FEMALE','1993-04-23','Vĩnh Long','0386478799','CUSTOMER', 'customer_663'),
('dattunguyen0802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Đạt','MALE','1994-03-26','Thanh Hóa','0945066487','CUSTOMER', 'customer_664'),
('hungdudang0111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Duy Hùng','MALE','2003-12-28','Long An','0333527218','CUSTOMER', 'customer_665'),
('huyenthngo0509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thu Huyền','FEMALE','1999-11-14','Cần Thơ','0905680360','CUSTOMER', 'customer_666'),
('nhunghoduong1301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hồng Nhung','FEMALE','1998-10-16','Bến Tre','0986904437','CUSTOMER', 'customer_667'),
('thuyphduong1706@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Phương Thủy','FEMALE','2005-08-21','Hải Dương','0916834064','CUSTOMER', 'customer_668'),
('hakivu1911@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Kim Hà','FEMALE','1994-06-20','Quảng Bình','0323894084','CUSTOMER', 'customer_669'),
('chauthngo1005@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thùy Châu','FEMALE','1994-08-29','Nam Định','0379598089','CUSTOMER', 'customer_670'),
('uyenthho2705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thanh Uyên','FEMALE','1996-05-21','Nam Định','0909754033','CUSTOMER', 'customer_671'),
('hungdutran2704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Duy Hưng','MALE','2003-03-04','Quảng Nam','0942818300','CUSTOMER', 'customer_672'),
('maithvu0410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thu Mai','FEMALE','1996-10-09','An Giang','0328395879','CUSTOMER', 'customer_673'),
('chauhabui2404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hà Châu','FEMALE','1991-12-01','Ninh Thuận','0933649087','CUSTOMER', 'customer_674'),
('huongphle1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Phương Hương','FEMALE','1993-04-12','HCM','0974930508','CUSTOMER', 'customer_675'),
('huyentungo0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Tuyết Huyền','FEMALE','1991-10-18','Thanh Hóa','0902580636','CUSTOMER', 'customer_676'),
('vinhngho0607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Vinh','MALE','1996-05-10','Ninh Thuận','0347309678','CUSTOMER', 'customer_677'),
('thuythdo1611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thanh Thủy','FEMALE','1997-07-28','Quảng Ngãi','0966238566','CUSTOMER', 'customer_678'),
('kienhudo1906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hữu Kiên','MALE','1993-10-04','An Giang','0350531546','CUSTOMER', 'customer_679'),
('thuyngle1704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Ngọc Thủy','FEMALE','1990-01-04','Đồng Nai','0936358129','CUSTOMER', 'customer_680'),
('hieuthly1511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thanh Hiếu','MALE','2001-11-21','Bình Phước','0378871655','CUSTOMER', 'customer_681'),
('vanmyho1004@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Mỹ Vân','FEMALE','2005-02-07','Quảng Ninh','0395897610','CUSTOMER', 'customer_682'),
('huyenbiho1708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Bích Huyền','FEMALE','1996-11-02','Bến Tre','0326011881','CUSTOMER', 'customer_683'),
('khoicoho2210@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Công Khôi','MALE','2005-03-25','Trà Vinh','0340371217','CUSTOMER', 'customer_684'),
('linhhaly1908@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hà Linh','FEMALE','1992-11-14','Quảng Nam','0344102618','CUSTOMER', 'customer_685'),
('phuongdivu0310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Diệu Phương','FEMALE','2001-10-13','Hải Phòng','0361077824','CUSTOMER', 'customer_686'),
('datanngo0803@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Anh Đạt','MALE','1993-08-25','Long An','0333897209','CUSTOMER', 'customer_687'),
('thanhtuly1507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuấn Thành','MALE','1995-03-22','Huế','0344609161','CUSTOMER', 'customer_688'),
('phucqutran1704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Quang Phúc','MALE','1990-07-10','Bến Tre','0961951737','CUSTOMER', 'customer_689'),
('mythtran0507@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thu My','FEMALE','2005-12-23','Quảng Ngãi','0337458814','CUSTOMER', 'customer_690'),
('thuthnguyen0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thùy Thu','FEMALE','1991-10-26','Bình Phước','0335859783','CUSTOMER', 'customer_691'),
('thuymynguyen0806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Mỹ Thủy','FEMALE','1999-02-18','Đà Nẵng','0944863517','CUSTOMER', 'customer_692'),
('lanthngo2004@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thị Lan','FEMALE','2000-10-11','Đà Nẵng','0902183509','CUSTOMER', 'customer_693'),
('ngalaly2808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Lan Nga','FEMALE','1990-07-07','Tây Ninh','0354547536','CUSTOMER', 'customer_694'),
('nhungmydo0505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Mỹ Nhung','FEMALE','1998-11-08','Bắc Ninh','0377004421','CUSTOMER', 'customer_695'),
('linhdiho1408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Diệu Linh','FEMALE','1995-11-05','Hải Phòng','0369203124','CUSTOMER', 'customer_696'),
('huongphphan0209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Phương Hương','FEMALE','1993-05-01','HCM','0337616810','CUSTOMER', 'customer_697'),
('uyenthduong1408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thanh Uyên','FEMALE','2005-11-24','Quảng Ninh','0359299719','CUSTOMER', 'customer_698'),
('anhbingo2609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Bích Anh','FEMALE','1993-11-26','Đồng Nai','0960169072','CUSTOMER', 'customer_699'),
('anhlabui0501@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Lan Anh','FEMALE','1990-01-02','Hưng Yên','0922978590','CUSTOMER', 'customer_700'),
('hakiduong2002@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Kim Hà','FEMALE','1997-07-30','Quảng Nam','0350610920','CUSTOMER', 'customer_701'),
('tuancole2702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Công Tuấn','MALE','2004-03-30','An Giang','0900559325','CUSTOMER', 'customer_702'),
('hanhtuduong1702@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuyết Hạnh','FEMALE','2001-05-13','Đà Nẵng','0335129441','CUSTOMER', 'customer_703'),
('chauthdang2502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thị Châu','FEMALE','1998-12-29','Quảng Ninh','0909919325','CUSTOMER', 'customer_704'),
('hakile1001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Kim Hà','FEMALE','1991-10-22','Hải Phòng','0927600761','CUSTOMER', 'customer_705'),
('habingo0709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Bích Hà','FEMALE','1993-12-26','Quảng Ninh','0366439982','CUSTOMER', 'customer_706'),
('datcodang2209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Công Đạt','MALE','1992-08-14','Bình Phước','0950482041','CUSTOMER', 'customer_707'),
('linhkingo0609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Kim Linh','FEMALE','2001-12-02','Quảng Bình','0328273905','CUSTOMER', 'customer_708'),
('chauthnguyen1802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thu Châu','FEMALE','1996-06-12','Ninh Thuận','0373349178','CUSTOMER', 'customer_709'),
('taikhnguyen2003@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Khánh Tài','MALE','2001-01-17','Bình Dương','0332830933','CUSTOMER', 'customer_710'),
('hungdudang1810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Duy Hùng','MALE','2001-06-08','Quảng Ninh','0901142542','CUSTOMER', 'customer_711'),
('vinhhaduong0609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hải Vinh','MALE','2003-03-17','Ninh Thuận','0349280959','CUSTOMER', 'customer_712'),
('phuongkitran0502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Kim Phương','FEMALE','2001-08-04','Bình Định','0971628082','CUSTOMER', 'customer_713'),
('toanmile0404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Minh Toàn','MALE','1997-03-09','Bình Thuận','0343921101','CUSTOMER', 'customer_714'),
('hungvaly1002@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Văn Hưng','MALE','2002-05-26','Quảng Ngãi','0920846375','CUSTOMER', 'customer_715'),
('nhungphbui1707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Phương Nhung','FEMALE','1990-01-08','Hưng Yên','0908503042','CUSTOMER', 'customer_716'),
('binhmivu2311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Minh Bình','MALE','1992-06-14','Cần Thơ','0396067683','CUSTOMER', 'customer_717'),
('ngaphly1408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Phương Nga','FEMALE','1995-06-30','Bắc Ninh','0906787235','CUSTOMER', 'customer_718'),
('phongvahoang1810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Văn Phong','MALE','1996-03-12','Thái Bình','0323457283','CUSTOMER', 'customer_719'),
('anhphnguyen2508@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Phương Anh','FEMALE','1996-08-19','Thanh Hóa','0395611561','CUSTOMER', 'customer_720'),
('binhandang0304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Anh Bình','MALE','1996-07-10','Bến Tre','0384882827','CUSTOMER', 'customer_721'),
('thuythpham0408@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Thủy','FEMALE','1995-04-27','Vĩnh Long','0359409148','CUSTOMER', 'customer_722'),
('chaututran0111@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Tuyết Châu','FEMALE','1991-12-05','Vĩnh Long','0904606267','CUSTOMER', 'customer_723'),
('khoikhvu0309@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Khánh Khôi','MALE','1990-01-19','Tây Ninh','0386391877','CUSTOMER', 'customer_724'),
('namhudo1101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hữu Nam','MALE','2004-01-30','An Giang','0336408968','CUSTOMER', 'customer_725'),
('binhmiphan0504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Bình','MALE','1996-09-09','Vĩnh Long','0938374786','CUSTOMER', 'customer_726'),
('trangbinguyen2805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Bích Trang','FEMALE','1998-02-15','Trà Vinh','0341215166','CUSTOMER', 'customer_727'),
('hungmiphan1311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Hùng','MALE','2004-01-21','Bến Tre','0392906202','CUSTOMER', 'customer_728'),
('datngbui0805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Ngọc Đạt','MALE','1994-05-19','Bến Tre','0322603245','CUSTOMER', 'customer_729'),
('vinhtuly0802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuấn Vinh','MALE','1991-03-07','Lâm Đồng','0389653484','CUSTOMER', 'customer_730'),
('hungandang2401@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Anh Hùng','MALE','1991-07-13','Quảng Bình','0369229321','CUSTOMER', 'customer_731'),
('hungvado1410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Văn Hưng','MALE','1996-02-14','Hải Dương','0350275807','CUSTOMER', 'customer_732'),
('kiendudang0606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Đức Kiên','MALE','1995-08-01','Bình Định','0915180612','CUSTOMER', 'customer_733'),
('hahovu2301@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hồng Hà','FEMALE','1992-12-21','Huế','0378714312','CUSTOMER', 'customer_734'),
('nhungmyduong2704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Mỹ Nhung','FEMALE','2000-07-04','Nam Định','0334806578','CUSTOMER', 'customer_735'),
('hanhngngo0704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Ngọc Hạnh','FEMALE','2005-02-13','Vĩnh Phúc','0394725936','CUSTOMER', 'customer_736'),
('mydingo2209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Diệu My','FEMALE','1997-02-19','Hải Dương','0349980788','CUSTOMER', 'customer_737'),
('hieuqule1607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Quang Hiếu','MALE','2002-10-06','Quảng Ngãi','0925129186','CUSTOMER', 'customer_738'),
('vanbihoang1509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Bích Vân','FEMALE','1997-03-29','Khánh Hòa','0380021322','CUSTOMER', 'customer_739'),
('quangcodang0802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Công Quang','MALE','1993-03-20','Hà Tĩnh','0945183501','CUSTOMER', 'customer_740'),
('mythnguyen1412@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh My','FEMALE','1997-07-20','An Giang','0943720151','CUSTOMER', 'customer_741'),
('myngtran0709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Ngọc My','FEMALE','1992-07-23','Vĩnh Phúc','0327685816','CUSTOMER', 'customer_742'),
('binhvado2510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Văn Bình','MALE','1994-02-11','Bình Định','0323773691','CUSTOMER', 'customer_743'),
('thuthtran1608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thị Thu','FEMALE','1993-02-17','Hà Nội','0323438448','CUSTOMER', 'customer_744'),
('datminguyen1505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Minh Đạt','MALE','1993-12-14','Tiền Giang','0325778035','CUSTOMER', 'customer_745'),
('hieumiphan1106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Hiếu','MALE','1999-05-15','Trà Vinh','0906013828','CUSTOMER', 'customer_746'),
('chauthduong2001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thùy Châu','FEMALE','2005-10-07','Nghệ An','0397073621','CUSTOMER', 'customer_747'),
('vanngdo1010@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Vân','FEMALE','1999-12-16','Hưng Yên','0347471346','CUSTOMER', 'customer_748'),
('quangduhoang0903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Duy Quang','MALE','2002-06-14','Nghệ An','0373614546','CUSTOMER', 'customer_749'),
('trangdiphan0101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Diệu Trang','FEMALE','2001-02-25','Bình Dương','0348195211','CUSTOMER', 'customer_750'),
('thaotuphan2003@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Tuyết Thảo','FEMALE','1997-07-17','Vĩnh Phúc','0922804784','CUSTOMER', 'customer_751'),
('namvango1912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Văn Nam','MALE','2002-09-15','Bình Phước','0947140998','CUSTOMER', 'customer_752'),
('trangladang0905@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Lan Trang','FEMALE','2003-05-04','Đồng Nai','0989495861','CUSTOMER', 'customer_753'),
('namngly0611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Nam','MALE','2003-11-17','Ninh Thuận','0939785418','CUSTOMER', 'customer_754'),
('hanhbihoang2410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Bích Hạnh','FEMALE','1993-04-19','Tiền Giang','0363362207','CUSTOMER', 'customer_755'),
('phucthly1009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thanh Phúc','MALE','1997-06-10','Bình Phước','0937664283','CUSTOMER', 'customer_756'),
('chauphle2304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Phương Châu','FEMALE','1997-07-24','Bến Tre','0940696379','CUSTOMER', 'customer_757'),
('uyenlabui0908@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Lan Uyên','FEMALE','2003-10-29','Cần Thơ','0371164826','CUSTOMER', 'customer_758'),
('hangduong0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Ngọc Hà','FEMALE','2000-10-01','Thanh Hóa','0977830989','CUSTOMER', 'customer_759'),
('maithngo2202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Thị Mai','FEMALE','1991-11-24','Cần Thơ','0327973235','CUSTOMER', 'customer_760'),
('thuhodang1704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Hồng Thu','FEMALE','2001-04-06','Bắc Ninh','0972676011','CUSTOMER', 'customer_761'),
('namhopham2811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hoàng Nam','MALE','1992-05-08','Tây Ninh','0921445774','CUSTOMER', 'customer_762'),
('ngahongo1203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hồng Nga','FEMALE','1990-05-25','Tiền Giang','0363879275','CUSTOMER', 'customer_763'),
('ngakipham2708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Kim Nga','FEMALE','2001-02-03','Quảng Bình','0377061459','CUSTOMER', 'customer_764'),
('linhhovu2105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hồng Linh','FEMALE','1994-03-08','Hà Tĩnh','0932658946','CUSTOMER', 'customer_765'),
('uyenngduong0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Ngọc Uyên','FEMALE','2004-12-28','Lâm Đồng','0905620047','CUSTOMER', 'customer_766'),
('toanhule1106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hữu Toàn','MALE','2001-08-20','Quảng Bình','0370611263','CUSTOMER', 'customer_767'),
('ngakiphan1202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Kim Nga','FEMALE','1997-01-06','Đà Nẵng','0325608782','CUSTOMER', 'customer_768'),
('maimyduong0506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Mỹ Mai','FEMALE','1996-08-10','Bắc Ninh','0933656508','CUSTOMER', 'customer_769'),
('datmiho0808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Minh Đạt','MALE','1998-06-18','Quảng Bình','0395494420','CUSTOMER', 'customer_770'),
('hoathbui2802@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thu Hoa','FEMALE','1993-06-12','Phú Yên','0382520793','CUSTOMER', 'customer_771'),
('chaungpham2608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Ngọc Châu','FEMALE','2002-03-07','Tiền Giang','0397979957','CUSTOMER', 'customer_772'),
('hoalanguyen2807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Lan Hoa','FEMALE','1991-06-08','Hà Tĩnh','0957870954','CUSTOMER', 'customer_773'),
('longkhtran2009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Khánh Long','MALE','2002-02-24','Bình Dương','0949373177','CUSTOMER', 'customer_774'),
('anhthho1902@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thùy Anh','FEMALE','1991-04-23','Phú Yên','0376183306','CUSTOMER', 'customer_775'),
('hoatutran1505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Tuyết Hoa','FEMALE','1990-12-08','Hà Nội','0906067106','CUSTOMER', 'customer_776'),
('huyenngduong2610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Ngọc Huyền','FEMALE','1995-11-29','Bến Tre','0960757196','CUSTOMER', 'customer_777'),
('longvaly2809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Văn Long','MALE','2003-01-01','Tây Ninh','0313703834','CUSTOMER', 'customer_778'),
('anhphpham1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Phương Anh','FEMALE','1991-01-03','Lâm Đồng','0399688883','CUSTOMER', 'customer_779'),
('vinhtuhoang2611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Tuấn Vinh','MALE','2004-04-10','Đà Nẵng','0319168134','CUSTOMER', 'customer_780'),
('trangthdang0911@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thùy Trang','FEMALE','1994-10-30','Phú Yên','0941541179','CUSTOMER', 'customer_781'),
('thulaly0102@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Lan Thu','FEMALE','1992-03-05','Bình Dương','0940614277','CUSTOMER', 'customer_782'),
('thuyhoduong2606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hồng Thủy','FEMALE','2001-04-01','Bình Định','0368072176','CUSTOMER', 'customer_783'),
('namcongo0403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Công Nam','MALE','2003-12-29','Thanh Hóa','0373313369','CUSTOMER', 'customer_784'),
('huonghaho1106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hà Hương','FEMALE','2002-05-07','Quảng Nam','0926292693','CUSTOMER', 'customer_785'),
('sonvapham1101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Văn Sơn','MALE','2000-04-18','Quảng Bình','0386718963','CUSTOMER', 'customer_786'),
('thaodinguyen2711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Diệu Thảo','FEMALE','1994-10-04','Tiền Giang','0966930318','CUSTOMER', 'customer_787'),
('myphho2512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Phương My','FEMALE','1997-07-27','Quảng Bình','0923369907','CUSTOMER', 'customer_788'),
('hanhladuong2307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Lan Hạnh','FEMALE','1992-08-27','Kiên Giang','0961880412','CUSTOMER', 'customer_789'),
('thanhhanguyen1203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hải Thành','MALE','1997-05-28','Vĩnh Long','0914843509','CUSTOMER', 'customer_790'),
('namhoduong0103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hoàng Nam','MALE','2002-09-12','Nam Định','0908541299','CUSTOMER', 'customer_791'),
('vanthly2009@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thanh Vân','FEMALE','2004-12-05','Vĩnh Phúc','0925082655','CUSTOMER', 'customer_792'),
('huongmynguyen1707@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Mỹ Hương','FEMALE','2002-07-31','Cần Thơ','0356825598','CUSTOMER', 'customer_793'),
('huongthle0511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Hương','FEMALE','1992-03-03','Hà Nội','0981534072','CUSTOMER', 'customer_794'),
('dungkhnguyen0411@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Khánh Dũng','MALE','2004-07-26','Hưng Yên','0332242896','CUSTOMER', 'customer_795'),
('longanpham1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Anh Long','MALE','1997-07-07','An Giang','0943560822','CUSTOMER', 'customer_796'),
('trangbidang0705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Bích Trang','FEMALE','2001-04-23','Cần Thơ','0330474637','CUSTOMER', 'customer_797'),
('tuanquhoang0407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Quang Tuấn','MALE','2003-11-03','Hà Tĩnh','0329776680','CUSTOMER', 'customer_798'),
('tamhoho1705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hoàng Tâm','MALE','1994-09-15','Quảng Ninh','0952996216','CUSTOMER', 'customer_799'),
('thaohonguyen2310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hồng Thảo','FEMALE','1997-09-21','Quảng Ngãi','0384197244','CUSTOMER', 'customer_800'),
('hanhmydo1008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Mỹ Hạnh','FEMALE','1991-05-01','Hà Tĩnh','0351479903','CUSTOMER', 'customer_801'),
('phuongholy1804@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hồng Phương','FEMALE','2004-09-11','An Giang','0964402685','CUSTOMER', 'customer_802'),
('chaubile0303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Bích Châu','FEMALE','1991-09-16','Bắc Ninh','0397724951','CUSTOMER', 'customer_803'),
('taivadang2303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Văn Tài','MALE','1990-12-07','Quảng Ngãi','0320623394','CUSTOMER', 'customer_804'),
('hahohoang0805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hồng Hà','FEMALE','2002-07-18','Hà Nội','0323160621','CUSTOMER', 'customer_805'),
('vinhcoduong0212@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Công Vinh','MALE','1990-01-29','Vĩnh Long','0344145600','CUSTOMER', 'customer_806'),
('dungquhoang2109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Quang Dũng','MALE','1993-03-26','Huế','0975261243','CUSTOMER', 'customer_807'),
('nammitran2104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Minh Nam','MALE','1994-07-13','Phú Yên','0341493920','CUSTOMER', 'customer_808'),
('phuonghoho0506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hồng Phương','FEMALE','2000-10-18','Khánh Hòa','0905417397','CUSTOMER', 'customer_809'),
('lanbipham1811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Bích Lan','FEMALE','2005-07-23','Cần Thơ','0376211014','CUSTOMER', 'customer_810'),
('chaulango0704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Lan Châu','FEMALE','1997-09-06','Ninh Thuận','0966255181','CUSTOMER', 'customer_811'),
('dungvaduong1303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Văn Dũng','MALE','2001-06-27','An Giang','0375902493','CUSTOMER', 'customer_812'),
('mytudang0509@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Tuyết My','FEMALE','2000-06-03','Bến Tre','0322215927','CUSTOMER', 'customer_813'),
('tuanquho0907@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Quang Tuấn','MALE','2002-03-04','Lâm Đồng','0391850074','CUSTOMER', 'customer_814'),
('trangdihoang1001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Diệu Trang','FEMALE','2005-06-05','Cần Thơ','0360946519','CUSTOMER', 'customer_815'),
('hieuhupham2008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hữu Hiếu','MALE','1991-08-31','An Giang','0382432305','CUSTOMER', 'customer_816'),
('phuongthnguyen2605@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Phương','FEMALE','2000-03-23','Nam Định','0927361079','CUSTOMER', 'customer_817'),
('hanhngly0601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Hạnh','FEMALE','1997-11-29','Đồng Nai','0320158228','CUSTOMER', 'customer_818'),
('sonhabui2311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hải Sơn','MALE','1993-07-05','Phú Yên','0362011896','CUSTOMER', 'customer_819'),
('uyenthbui0708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Uyên','FEMALE','2003-11-23','An Giang','0916639549','CUSTOMER', 'customer_820'),
('thanhdudo1104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Duy Thành','MALE','1990-03-05','Bến Tre','0363062575','CUSTOMER', 'customer_821'),
('thuymydo0101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Mỹ Thủy','FEMALE','1994-05-04','Khánh Hòa','0957453881','CUSTOMER', 'customer_822'),
('huyenthduong1809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thị Huyền','FEMALE','2000-09-05','Lâm Đồng','0375769104','CUSTOMER', 'customer_823'),
('tuanando0910@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Anh Tuấn','MALE','2001-07-22','Nam Định','0906336351','CUSTOMER', 'customer_824'),
('thuythdang2008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thu Thủy','FEMALE','2005-08-01','Trà Vinh','0988521484','CUSTOMER', 'customer_825'),
('hungdudo1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Duy Hùng','MALE','1998-07-30','Nam Định','0329350133','CUSTOMER', 'customer_826'),
('maibivu2801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Bích Mai','FEMALE','2001-11-06','Quảng Ninh','0900902002','CUSTOMER', 'customer_827'),
('thanhngly0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Thành','MALE','1999-06-05','Hưng Yên','0900631455','CUSTOMER', 'customer_828'),
('mainghoang1310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Ngọc Mai','FEMALE','2004-06-26','Khánh Hòa','0932664627','CUSTOMER', 'customer_829'),
('hahapham1808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hà Hà','FEMALE','1991-10-05','An Giang','0340617504','CUSTOMER', 'customer_830'),
('thumypham0508@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Mỹ Thu','FEMALE','1992-11-22','Bến Tre','0958752645','CUSTOMER', 'customer_831'),
('huyenkido2705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Kim Huyền','FEMALE','2004-11-27','Quảng Ngãi','0399375998','CUSTOMER', 'customer_832'),
('linhmypham2007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Mỹ Linh','FEMALE','1999-03-07','Khánh Hòa','0926084202','CUSTOMER', 'customer_833'),
('huongbinguyen0206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Bích Hương','FEMALE','1996-06-12','Thái Bình','0320577580','CUSTOMER', 'customer_834'),
('hunghaho2010@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hải Hùng','MALE','2002-10-29','Bình Định','0310499930','CUSTOMER', 'customer_835'),
('hoathdang2209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thị Hoa','FEMALE','2001-07-10','Bình Thuận','0921045317','CUSTOMER', 'customer_836'),
('khoianvu2602@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Anh Khôi','MALE','1999-02-05','Bình Thuận','0959420882','CUSTOMER', 'customer_837'),
('ngatupham2005@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Tuyết Nga','FEMALE','1998-01-19','Cần Thơ','0933872775','CUSTOMER', 'customer_838'),
('hahatran2502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hà Hà','FEMALE','2004-05-11','Hưng Yên','0934576003','CUSTOMER', 'customer_839'),
('vinhanduong1303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Anh Vinh','MALE','1990-07-13','Ninh Thuận','0931128932','CUSTOMER', 'customer_840'),
('vanthle1908@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thị Vân','FEMALE','1998-10-11','Trà Vinh','0311234534','CUSTOMER', 'customer_841'),
('thanhdudo1705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Đức Thành','MALE','1990-12-22','Tây Ninh','0982191358','CUSTOMER', 'customer_842'),
('nhungngdang1906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Nhung','FEMALE','2003-06-11','Quảng Nam','0384004962','CUSTOMER', 'customer_843'),
('haphnguyen1003@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Phương Hà','FEMALE','1992-11-28','Khánh Hòa','0908898663','CUSTOMER', 'customer_844'),
('hamydang1407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Mỹ Hà','FEMALE','2003-10-16','Hải Phòng','0974256080','CUSTOMER', 'customer_845'),
('ngatutran1506@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Tuyết Nga','FEMALE','2001-01-30','Thanh Hóa','0928684334','CUSTOMER', 'customer_846'),
('anhngho1001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Ngọc Anh','FEMALE','1997-02-18','Bình Phước','0374373369','CUSTOMER', 'customer_847'),
('thuhobui2609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hồng Thu','FEMALE','2000-12-01','Ninh Thuận','0360400847','CUSTOMER', 'customer_848'),
('tamquly1106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Quang Tâm','MALE','2000-12-24','Quảng Bình','0986148614','CUSTOMER', 'customer_849'),
('mythdo1508@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thu My','FEMALE','2001-05-30','Quảng Nam','0973684341','CUSTOMER', 'customer_850'),
('thutule0407@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Tuyết Thu','FEMALE','2005-03-22','Bình Dương','0942084855','CUSTOMER', 'customer_851'),
('thanhhunguyen2505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hữu Thành','MALE','2003-02-02','Quảng Ninh','0911992013','CUSTOMER', 'customer_852'),
('longhohoang0607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hoàng Long','MALE','1997-11-10','Tiền Giang','0966253768','CUSTOMER', 'customer_853'),
('taivango0106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Văn Tài','MALE','1991-03-24','Bình Dương','0331285803','CUSTOMER', 'customer_854'),
('dunghutran1203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hữu Dũng','MALE','2004-01-09','Thanh Hóa','0342046013','CUSTOMER', 'customer_855'),
('tamngpham0607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Ngọc Tâm','MALE','1997-01-14','Long An','0963036535','CUSTOMER', 'customer_856'),
('taihavu1101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hải Tài','MALE','1995-04-24','Quảng Nam','0959510809','CUSTOMER', 'customer_857'),
('phuongkinguyen2512@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Kim Phương','FEMALE','1999-04-09','Thanh Hóa','0324930098','CUSTOMER', 'customer_858'),
('huonghodo2601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Hồng Hương','FEMALE','1997-01-30','Hà Tĩnh','0333361187','CUSTOMER', 'customer_859'),
('hunghongo1712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hoàng Hưng','MALE','2002-07-11','Nghệ An','0902893838','CUSTOMER', 'customer_860'),
('linhthbui2806@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thùy Linh','FEMALE','2005-08-13','Hà Nội','0963322023','CUSTOMER', 'customer_861'),
('thanhdudang0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Đức Thành','MALE','2003-04-22','Tây Ninh','0316532592','CUSTOMER', 'customer_862'),
('hanhhaphan1708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Hà Hạnh','FEMALE','2005-12-19','Quảng Nam','0941356017','CUSTOMER', 'customer_863'),
('dattuvu2008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Tuấn Đạt','MALE','1992-02-03','Tiền Giang','0974320421','CUSTOMER', 'customer_864'),
('hoadinguyen2311@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Diệu Hoa','FEMALE','2003-10-14','Hải Phòng','0939057044','CUSTOMER', 'customer_865'),
('vanmyho0206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Mỹ Vân','FEMALE','1991-05-10','Bình Phước','0904598181','CUSTOMER', 'customer_866'),
('thaomyly2108@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Mỹ Thảo','FEMALE','1999-02-01','Tiền Giang','0962716459','CUSTOMER', 'customer_867'),
('kienmipham1610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Minh Kiên','MALE','1998-12-31','Quảng Bình','0316040275','CUSTOMER', 'customer_868'),
('phonghanguyen2211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hải Phong','MALE','1991-11-10','Bình Phước','0969144659','CUSTOMER', 'customer_869'),
('sontuly1911@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuấn Sơn','MALE','1993-05-07','Hải Phòng','0365378971','CUSTOMER', 'customer_870'),
('thanhhaduong1109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hải Thành','MALE','2003-03-05','An Giang','0970499409','CUSTOMER', 'customer_871'),
('myphpham1303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Phương My','FEMALE','1994-05-07','Hà Tĩnh','0930579803','CUSTOMER', 'customer_872'),
('longtuhoang1308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Tuấn Long','MALE','1993-09-11','Thái Bình','0340065734','CUSTOMER', 'customer_873'),
('tamdule2207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Duy Tâm','MALE','1994-08-01','Long An','0385608571','CUSTOMER', 'customer_874'),
('lanlaly1005@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Lan Lan','FEMALE','1996-07-14','Trà Vinh','0377934481','CUSTOMER', 'customer_875'),
('mytuduong2209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Tuyết My','FEMALE','2003-05-08','Kiên Giang','0316421973','CUSTOMER', 'customer_876'),
('lanthtran1004@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thùy Lan','FEMALE','1993-04-02','Kiên Giang','0329144233','CUSTOMER', 'customer_877'),
('tamtubui2002@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Tuấn Tâm','MALE','2003-08-11','Vĩnh Long','0921825358','CUSTOMER', 'customer_878'),
('hanhthhoang2811@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thu Hạnh','FEMALE','1992-04-09','Quảng Ninh','0383047629','CUSTOMER', 'customer_879'),
('thuydidang0609@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Diệu Thủy','FEMALE','2003-03-21','Bình Định','0333901740','CUSTOMER', 'customer_880'),
('khoiandang0412@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Anh Khôi','MALE','2005-03-17','Cần Thơ','0391092388','CUSTOMER', 'customer_881'),
('hungkhhoang0201@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Khánh Hưng','MALE','2000-06-15','Bình Định','0972230301','CUSTOMER', 'customer_882'),
('thaothho1303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thanh Thảo','FEMALE','2004-09-02','Đà Nẵng','0906030472','CUSTOMER', 'customer_883'),
('tamanngo0409@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Anh Tâm','MALE','2005-11-21','HCM','0366856951','CUSTOMER', 'customer_884'),
('taithdang0606@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thanh Tài','MALE','2004-07-18','Hải Dương','0908830538','CUSTOMER', 'customer_885'),
('ngaphbui2001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Phương Nga','FEMALE','2003-09-28','Bình Dương','0375094364','CUSTOMER', 'customer_886'),
('phuongkinguyen1308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Kim Phương','FEMALE','1991-07-15','Khánh Hòa','0930367283','CUSTOMER', 'customer_887'),
('hathdo2003@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thị Hà','FEMALE','1995-01-07','Bến Tre','0385426832','CUSTOMER', 'customer_888'),
('myphdang0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Phương My','FEMALE','1999-02-26','Vĩnh Phúc','0935070508','CUSTOMER', 'customer_889'),
('dungkhtran2708@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Khánh Dũng','MALE','1994-12-26','Quảng Ninh','0983930174','CUSTOMER', 'customer_890'),
('hungmiduong0903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Minh Hưng','MALE','1993-09-11','Vĩnh Long','0331888449','CUSTOMER', 'customer_891'),
('quanghule2101@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hữu Quang','MALE','2003-12-21','Vĩnh Long','0341353063','CUSTOMER', 'customer_892'),
('taihungo2002@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hữu Tài','MALE','2004-02-26','Long An','0316333138','CUSTOMER', 'customer_893'),
('uyenhaly1412@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Hà Uyên','FEMALE','1991-09-01','Vĩnh Long','0939724881','CUSTOMER', 'customer_894'),
('hangtran0611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Ngọc Hà','FEMALE','1993-06-14','Đà Nẵng','0396873231','CUSTOMER', 'customer_895'),
('tuanduvu0502@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đức Tuấn','MALE','2000-08-29','Khánh Hòa','0380260825','CUSTOMER', 'customer_896'),
('phucquly0901@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Quang Phúc','MALE','1991-12-02','Tây Ninh','0320824914','CUSTOMER', 'customer_897'),
('taimiphan1008@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Minh Tài','MALE','1996-11-14','Nam Định','0392490985','CUSTOMER', 'customer_898'),
('hanhhongo2011@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hồng Hạnh','FEMALE','1990-12-04','Tiền Giang','0315848142','CUSTOMER', 'customer_899'),
('linhthly1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thị Linh','FEMALE','2001-12-19','Bình Dương','0325073921','CUSTOMER', 'customer_900'),
('vinhduduong2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Đức Vinh','MALE','1997-11-25','Quảng Ninh','0921882278','CUSTOMER', 'customer_901'),
('sonhobui0404@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hoàng Sơn','MALE','1997-05-26','Nam Định','0968616849','CUSTOMER', 'customer_902'),
('dattunguyen2303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Đạt','MALE','1993-07-15','Bến Tre','0942726604','CUSTOMER', 'customer_903'),
('namhoduong1809@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Hoàng Nam','MALE','1990-02-01','Lâm Đồng','0985897354','CUSTOMER', 'customer_904'),
('namvale1504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Văn Nam','MALE','1991-07-29','Ninh Thuận','0354972859','CUSTOMER', 'customer_905'),
('anhdily1611@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Diệu Anh','FEMALE','2002-10-14','Thái Bình','0378199402','CUSTOMER', 'customer_906'),
('ngaladuong0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Lan Nga','FEMALE','1993-05-27','HCM','0952282727','CUSTOMER', 'customer_907'),
('quangngnguyen1103@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Ngọc Quang','MALE','2001-07-12','Tây Ninh','0966122346','CUSTOMER', 'customer_908'),
('linhkibui0208@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Kim Linh','FEMALE','2005-11-03','Bến Tre','0374398009','CUSTOMER', 'customer_909'),
('quanghuhoang1007@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hữu Quang','MALE','1994-01-03','Nghệ An','0932183909','CUSTOMER', 'customer_910'),
('thuymyly0810@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Mỹ Thủy','FEMALE','2000-08-21','Quảng Ninh','0947569030','CUSTOMER', 'customer_911'),
('thaotudang1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Tuyết Thảo','FEMALE','1990-12-25','Cần Thơ','0968507387','CUSTOMER', 'customer_912'),
('huyenthhoang1106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Thùy Huyền','FEMALE','1995-02-13','Bình Dương','0953774683','CUSTOMER', 'customer_913'),
('hahahoang0403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hà Hà','FEMALE','1994-02-25','Bắc Ninh','0951740820','CUSTOMER', 'customer_914'),
('huyenbiho0205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Bích Huyền','FEMALE','1994-08-21','Cần Thơ','0316692922','CUSTOMER', 'customer_915'),
('hoalango1005@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Lan Hoa','FEMALE','2001-07-24','Quảng Nam','0312609146','CUSTOMER', 'customer_916'),
('huyenhopham2308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Hồng Huyền','FEMALE','1997-12-02','Thanh Hóa','0343777367','CUSTOMER', 'customer_917'),
('hoathdo2812@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thùy Hoa','FEMALE','1996-04-20','Bình Dương','0342062397','CUSTOMER', 'customer_918'),
('mybipham1303@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Bích My','FEMALE','2005-07-17','Nghệ An','0978735189','CUSTOMER', 'customer_919'),
('thaodile0705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Diệu Thảo','FEMALE','2004-04-17','Bến Tre','0973017617','CUSTOMER', 'customer_920'),
('phongantran0211@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Anh Phong','MALE','2005-07-24','An Giang','0940663044','CUSTOMER', 'customer_921'),
('linhthphan0901@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thị Linh','FEMALE','2004-03-22','Kiên Giang','0922258960','CUSTOMER', 'customer_922'),
('kiendungo0709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Duy Kiên','MALE','1990-01-15','Thái Bình','0399838807','CUSTOMER', 'customer_923'),
('uyenthbui2203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thị Uyên','FEMALE','2000-12-12','Quảng Ngãi','0983836951','CUSTOMER', 'customer_924'),
('thuladang1203@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Lan Thu','FEMALE','1997-09-02','Lâm Đồng','0310753432','CUSTOMER', 'customer_925'),
('binhhobui1903@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Hoàng Bình','MALE','2000-02-02','Trà Vinh','0396213247','CUSTOMER', 'customer_926'),
('phuongthpham2808@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thùy Phương','FEMALE','1994-02-17','Hải Dương','0328570111','CUSTOMER', 'customer_927'),
('maiphvu2410@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Phương Mai','FEMALE','1999-04-10','Thanh Hóa','0345973077','CUSTOMER', 'customer_928'),
('khoivatran2003@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Văn Khôi','MALE','1995-01-14','Hà Nội','0361877020','CUSTOMER', 'customer_929'),
('thaobivu2504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Bích Thảo','FEMALE','2003-01-29','Cần Thơ','0351442051','CUSTOMER', 'customer_930'),
('kienvapham1906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Văn Kiên','MALE','1994-07-26','Hải Dương','0971476282','CUSTOMER', 'customer_931'),
('quangconguyen0310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Công Quang','MALE','1997-09-16','Trà Vinh','0326352647','CUSTOMER', 'customer_932'),
('phuongngdang1011@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Phương','FEMALE','1998-10-16','Phú Yên','0313881482','CUSTOMER', 'customer_933'),
('hoathduong0711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thu Hoa','FEMALE','2003-10-30','Khánh Hòa','0385557903','CUSTOMER', 'customer_934'),
('vanbido2805@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Bích Vân','FEMALE','1990-03-08','Hải Phòng','0969995392','CUSTOMER', 'customer_935'),
('phucthbui0304@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Phúc','MALE','1993-01-29','Khánh Hòa','0981829503','CUSTOMER', 'customer_936'),
('linhthnguyen0605@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Linh','FEMALE','1997-09-05','Hà Tĩnh','0312557680','CUSTOMER', 'customer_937'),
('dathongo0209@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hoàng Đạt','MALE','2002-01-08','Vĩnh Phúc','0342480264','CUSTOMER', 'customer_938'),
('dunghale0207@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Hải Dũng','MALE','1993-10-23','Nghệ An','0310307650','CUSTOMER', 'customer_939'),
('datngly1011@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Đạt','MALE','1997-02-15','Bến Tre','0946516174','CUSTOMER', 'customer_940'),
('longkhbui2405@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Khánh Long','MALE','2002-06-06','Quảng Ngãi','0900483437','CUSTOMER', 'customer_941'),
('khoitunguyen0712@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Tuấn Khôi','MALE','2003-06-05','Long An','0379513832','CUSTOMER', 'customer_942'),
('phucngdang1310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Phúc','MALE','1995-11-08','Cần Thơ','0913051727','CUSTOMER', 'customer_943'),
('taihuho1001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Hữu Tài','MALE','1993-07-08','Bình Định','0386971422','CUSTOMER', 'customer_944'),
('dattuly0202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Tuấn Đạt','MALE','1999-05-17','An Giang','0357104651','CUSTOMER', 'customer_945'),
('habinguyen2601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Bích Hà','FEMALE','2005-06-01','Hà Tĩnh','0968245460','CUSTOMER', 'customer_946'),
('binhthvu0212@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Thanh Bình','MALE','2003-12-04','Tây Ninh','0393432388','CUSTOMER', 'customer_947'),
('khoithbui1801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Thanh Khôi','MALE','2005-10-30','Cần Thơ','0337003375','CUSTOMER', 'customer_948'),
('huyenphphan0910@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Phương Huyền','FEMALE','2005-07-23','Vĩnh Long','0902594965','CUSTOMER', 'customer_949'),
('thanhthtran1403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Thanh Thành','MALE','2002-09-02','Đồng Nai','0377749029','CUSTOMER', 'customer_950'),
('thumyhoang2107@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Mỹ Thu','FEMALE','1990-05-22','Hải Dương','0388619169','CUSTOMER', 'customer_951'),
('binhkhduong0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Khánh Bình','MALE','2002-10-26','Bình Dương','0920342087','CUSTOMER', 'customer_952'),
('trangdihoang2510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Diệu Trang','FEMALE','2003-11-02','Tiền Giang','0960321582','CUSTOMER', 'customer_953'),
('khoivaduong2001@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Văn Khôi','MALE','2003-07-02','An Giang','0910411614','CUSTOMER', 'customer_954'),
('dunganpham0302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Anh Dũng','MALE','1999-01-11','Bắc Ninh','0332464032','CUSTOMER', 'customer_955'),
('myngpham1701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Ngọc My','FEMALE','1991-07-16','HCM','0905818888','CUSTOMER', 'customer_956'),
('dungkhvu1510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Khánh Dũng','MALE','1994-09-16','Lâm Đồng','0923824191','CUSTOMER', 'customer_957'),
('huyenthphan1610@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thanh Huyền','FEMALE','2000-06-12','Hải Phòng','0367558535','CUSTOMER', 'customer_958'),
('namkhly2704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Khánh Nam','MALE','1996-05-24','Bình Phước','0908922860','CUSTOMER', 'customer_959'),
('datquhoang1711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Quang Đạt','MALE','1994-11-28','Cần Thơ','0378053969','CUSTOMER', 'customer_960'),
('khoianpham0703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Anh Khôi','MALE','2004-07-06','Cần Thơ','0965127517','CUSTOMER', 'customer_961'),
('quangdule0906@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Duy Quang','MALE','1995-10-12','Hải Phòng','0319831513','CUSTOMER', 'customer_962'),
('binhdutran0510@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Duy Bình','MALE','2000-10-19','Cần Thơ','0389568465','CUSTOMER', 'customer_963'),
('hathho1206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Thùy Hà','FEMALE','1990-09-13','Quảng Ngãi','0989439932','CUSTOMER', 'customer_964'),
('mythduong1310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Thị My','FEMALE','1990-07-03','Tây Ninh','0916655196','CUSTOMER', 'customer_965'),
('taiantran0701@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Anh Tài','MALE','2002-04-13','HCM','0940842394','CUSTOMER', 'customer_966'),
('lanbily0612@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Bích Lan','FEMALE','1993-01-05','Thanh Hóa','0359224662','CUSTOMER', 'customer_967'),
('chaulanguyen1608@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Lan Châu','FEMALE','1994-02-12','Bắc Ninh','0940107875','CUSTOMER', 'customer_968'),
('namngpham0705@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Ngọc Nam','MALE','2004-10-18','Quảng Bình','0352142666','CUSTOMER', 'customer_969'),
('mythdo1711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Thùy My','FEMALE','1997-05-16','Huế','0911346212','CUSTOMER', 'customer_970'),
('namdule2305@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Đức Nam','MALE','1991-05-20','HCM','0986308728','CUSTOMER', 'customer_971'),
('hungtuho1504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Tuấn Hưng','MALE','1994-03-18','HCM','0342007511','CUSTOMER', 'customer_972'),
('linhngly1105@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Ngọc Linh','FEMALE','2004-04-14','Vĩnh Phúc','0982526392','CUSTOMER', 'customer_973'),
('thuditran0704@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Diệu Thu','FEMALE','1992-09-11','An Giang','0380804910','CUSTOMER', 'customer_974'),
('vanthle1310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thanh Vân','FEMALE','2001-11-08','Phú Yên','0356826984','CUSTOMER', 'customer_975'),
('binhquphan2012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Quang Bình','MALE','2004-07-09','Huế','0942386291','CUSTOMER', 'customer_976'),
('binhvaduong0503@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Văn Bình','MALE','2004-03-04','Lâm Đồng','0963055739','CUSTOMER', 'customer_977'),
('lanbido1904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Bích Lan','FEMALE','1995-06-02','Quảng Ninh','0346920775','CUSTOMER', 'customer_978'),
('tuanvaduong2703@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Dương Văn Tuấn','MALE','1993-06-08','Ninh Thuận','0922923425','CUSTOMER', 'customer_979'),
('linhdiho2302@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Diệu Linh','FEMALE','1990-07-29','Nam Định','0987584069','CUSTOMER', 'customer_980'),
('hoaphtran0202@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Phương Hoa','FEMALE','1996-05-23','Quảng Ngãi','0386618516','CUSTOMER', 'customer_981'),
('hungduvu0807@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Đức Hùng','MALE','2000-12-24','Hà Nội','0310160486','CUSTOMER', 'customer_982'),
('hungdutran1605@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Đức Hưng','MALE','1999-09-16','Khánh Hòa','0909140591','CUSTOMER', 'customer_983'),
('huyenkinguyen1904@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Kim Huyền','FEMALE','1991-01-14','Bình Phước','0343826953','CUSTOMER', 'customer_984'),
('huongtule2511@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Tuyết Hương','FEMALE','1999-12-04','Tiền Giang','0321773627','CUSTOMER', 'customer_985'),
('myphdo1210@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Phương My','FEMALE','2002-03-22','Nghệ An','0909659606','CUSTOMER', 'customer_986'),
('nhungthly2106@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lý Thùy Nhung','FEMALE','1992-07-04','Hà Nội','0944165619','CUSTOMER', 'customer_987'),
('taihahoang0508@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Hải Tài','MALE','1994-04-14','Tiền Giang','0901895225','CUSTOMER', 'customer_988'),
('thanhhuvu1109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hữu Thành','MALE','1997-05-08','HCM','0369426978','CUSTOMER', 'customer_989'),
('phuongkido2403@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Kim Phương','FEMALE','1991-10-01','Hà Tĩnh','0358553775','CUSTOMER', 'customer_990'),
('longngdang2601@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Ngọc Long','MALE','1997-08-23','Phú Yên','0358569159','CUSTOMER', 'customer_991'),
('tammitran1607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Minh Tâm','MALE','1992-01-03','Quảng Ngãi','0335932197','CUSTOMER', 'customer_992'),
('uyenhavu2711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hà Uyên','FEMALE','1994-04-29','Hà Tĩnh','0984661072','CUSTOMER', 'customer_993'),
('datanle1709@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Anh Đạt','MALE','1990-12-22','Thanh Hóa','0398557046','CUSTOMER', 'customer_994'),
('hieutuphan1104@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Tuấn Hiếu','MALE','2003-06-25','Long An','0905394897','CUSTOMER', 'customer_995'),
('hanhtuho2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hồ Tuyết Hạnh','FEMALE','2001-03-25','Thanh Hóa','0337302501','CUSTOMER', 'customer_996'),
('tamvale0109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Văn Tâm','MALE','1993-11-24','Bình Phước','0381690142','CUSTOMER', 'customer_997'),
('taiantran2012@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Anh Tài','MALE','1993-07-22','Khánh Hòa','0374573650','CUSTOMER', 'customer_998'),
('ngangphan1307@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Ngọc Nga','FEMALE','1997-01-09','Hưng Yên','0907769092','CUSTOMER', 'customer_999'),
('namhongo0710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Ngô Hoàng Nam','MALE','2001-02-01','Vĩnh Phúc','0928318262','CUSTOMER', 'customer_1000'),
('linhnt2801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thị Linh','FEMALE','1995-01-28','Hà Nội','0931234567','CUSTOMER', 'customer_1001'),
('tuanvh1505@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Hải Tuấn','MALE','1998-05-15','HCM','0942345678','CUSTOMER', 'customer_1002'),
('maipt0912@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Thị Mai','FEMALE','2000-12-09','Đà Nẵng','0953456789','CUSTOMER', 'customer_1003'),
('hunglt2206@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Lê Thanh Hùng','MALE','1996-06-22','Hải Phòng','0964567890','CUSTOMER', 'customer_1004'),
('hoadn1803@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đỗ Ngọc Hoa','FEMALE','1999-03-18','Cần Thơ','0975678901','CUSTOMER', 'customer_1005'),
('anhth0711@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Hoàng Anh','MALE','1997-11-07','Bình Dương','0986789012','CUSTOMER', 'customer_1006'),
('thuypk2504@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Kim Thủy','FEMALE','2001-04-25','Đồng Nai','0997890123','CUSTOMER', 'customer_1007'),
('longnh1310@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Hữu Long','MALE','1994-10-13','Quảng Ninh','0908901234','CUSTOMER', 'customer_1008'),
('landt2607@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Đặng Thị Lan','FEMALE','1998-07-26','Nghệ An','0919012345','CUSTOMER', 'customer_1009'),
('binh1902@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Bùi Văn Bình','MALE','1995-02-19','Thái Bình','0920123456','CUSTOMER', 'customer_1010'),
('huongvm0801@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Vũ Mỹ Hương','FEMALE','2002-01-08','Nam Định','0931234568','CUSTOMER', 'customer_1011'),
('sontk1604@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Trần Khánh Sơn','MALE','1996-04-16','Huế','0942345679','CUSTOMER', 'customer_1012'),
('ngapt2109@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phan Thị Nga','FEMALE','1999-09-21','Quảng Nam','0953456780','CUSTOMER', 'customer_1013'),
('quanph1205@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Phạm Huy Quân','MALE','1997-05-12','Khánh Hòa','0964567891','CUSTOMER', 'customer_1014'),
('thunt0308@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Nguyễn Thanh Thu','FEMALE','2000-08-03','Lâm Đồng','0975678902','CUSTOMER', 'customer_1015'),
('dathn2710@gmail.com', '$2a$10$7EqJtq98hPqEX7fNZaFWoOhi5Q6nK0lE8Xc3k5YwJ3kZrZKz3yXbG', 'Hoàng Nam Đạt','MALE','1993-10-27','Kiên Giang','0986789013','CUSTOMER', 'customer_1016');

/* =========================
   HOTELS
   ========================= */
CREATE TABLE hotels (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    floor INT,
    `description` TEXT,
    `type` ENUM('HOTEL', 'HOMESTAY', 'RESORT'),
    address VARCHAR(500) NOT NULL,
    city VARCHAR(30) NOT NULL,
    star_rating INT,
    review_rating DECIMAL(3,1),
    check_in_time TIME,
    check_out_time TIME,
    check_in_instructions TEXT,
    policy_text TEXT,
    `status` VARCHAR(20) DEFAULT 'ACTIVE',
    manager_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hotel_manager
        FOREIGN KEY (manager_id) REFERENCES users(id)
);

INSERT INTO hotels 
(`name`, floor, `description`, `type`, address, city, star_rating, review_rating, check_in_time, check_out_time, check_in_instructions,
policy_text, manager_id) 
VALUES
(
	-- name
	'Ha Noi Le Grand Hotel',
    -- floor
    7,
    -- description
	'Không chỉ sở hữu vị trí giúp quý khách dễ dàng ghé thăm những địa điểm lý thú trong chuyến hành trình, Ha Noi Le Grand Hotel cũng sẽ mang đến cho quý khách trải nghiệm lưu trú mỹ mãn.
	Ha Noi Le Grand Hotel là đề xuất hàng đầu dành cho những tín đồ du lịch "bụi" mong muốn được nghỉ tại một khách sạn vừa thoải mái lại hợp túi tiền.
	Dành cho những du khách muốn du lịch thoải mái cùng ngân sách tiết kiệm, Ha Noi Le Grand Hotel sẽ là lựa chọn lưu trú hoàn hảo, nơi cung cấp các tiện nghi chất lượng và dịch vụ tuyệt vời.
	Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại Ha Noi Le Grand Hotel
	Ha Noi Le Grand Hotel là lựa chọn sáng giá dành cho những ai đang tìm kiếm một trải nghiệm xa hoa đầy thú vị trong kỳ nghỉ của mình. Lưu trú tại đây cũng là cách để quý khách chiều chuộng bản thân với những dịch vụ xuất sắc nhất và khiến kỳ nghỉ của mình trở nên thật đáng nhớ.
	Từ sự kiện doanh nghiệp đến họp mặt công ty, Ha Noi Le Grand Hotel cung cấp đầy đủ các dịch vụ và tiện nghi đáp ứng mọi nhu cầu của quý khách và đồng nghiệp.
	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Ha Noi Le Grand Hotel, một khách sạn tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.
	Nếu dự định có một kỳ nghỉ dài, thì Ha Noi Le Grand Hotel chính là lựa chọn dành cho quý khách. Với đầy đủ tiện nghi với chất lượng dịch vụ tuyệt vời, Ha Noi Le Grand Hotel sẽ khiến quý khách cảm thấy thoải mái như đang ở nhà vậy.
	Du lịch một mình cũng không hề kém phần thú vị và Ha Noi Le Grand Hotel là nơi thích hợp dành riêng cho những ai đề cao sự riêng tư trong kỳ lưu trú.
	Dịch vụ tuyệt vời, cơ sở vật chất hoàn chỉnh và các tiện nghi khách sạn cung cấp sẽ khiến quý khách không thể phàn nàn trong suốt kỳ lưu trú tại Ha Noi Le Grand Hotel.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.
	Ha Noi Le Grand Hotel là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Với những tiện nghi sẵn có Ha Noi Le Grand Hotel thực sự là một nơi lưu trú hoàn hảo.',
    -- type
	'HOTEL',
    -- address
    '3 B9 Đầm Trấu, Bạch Đằng, Quận Hai Bà Trưng',
    -- city
    'Hà Nội',
    -- star_rating
    3,
    -- review_rating
    8.5,
    -- check_in_time
    '14:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	NULL,
    -- policy_text
    'Chỉ được phép hút thuốc trong khu vực chỉ định.
    Không được mang theo thú cưng.',
    -- manager_id
    3
),

(
	-- name
	'ZAZZ Urban Ho Chi Minh Hotel',
    -- floor
    10,
    -- description
	'Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại ZAZZ Urban Ho Chi Minh Hotel
	Bạn có phải là tín đồ mua sắm? Lưu trú tại ZAZZ Urban Ho Chi Minh Hotel chắc chắn sẽ thoả mãn bạn với hàng loạt các trung tâm mua sắm kề cận.
	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại ZAZZ Urban Ho Chi Minh Hotel, một khách sạn tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.
	Hãy sẵn sàng đón nhận trải nghiệm khó quên bằng dịch vụ độc đáo và hoàn hảo của khách sạn cùng các tiện nghi đầy đủ, đáp ứng mọi nhu cầu của quý khách.
	Trung tâm thể dục của khách sạn là một trong những tiện nghi không thể bỏ qua khi lưu trú tại đây.
	Hưởng thụ một ngày thư thái đầy thú vị tại hồ bơi dù quý khách đang du lịch một mình hay cùng người thân.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ ZAZZ Urban Ho Chi Minh Hotel chỉ dành riêng cho quý khách.
	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.
	ZAZZ Urban Ho Chi Minh Hotel là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Hãy sẵn sàng đón nhận những giây phút vô giá khó phai trong suốt kỳ nghỉ của quý khách tại ZAZZ Urban Ho Chi Minh Hotel.',
    -- type
	'HOTEL',
    -- address
    '28 Sư Vạn Hạnh, Quận 5',
    -- city
    'Hồ Chí Minh',
    -- star_rating
    4,
    -- review_rating
    8.7,
    -- check_in_time
    '14:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	'Miễn phí trẻ em dưới 6 tuổi ngủ chung giường với bố mẹ (Không có cũi trẻ em). Trẻ em từ 6 đến 11 tuổi ngủ chung giường với bố mẹ có thu phí 350.000 VNĐ net/phòng/đêm cho bữa sáng (250.000 VNĐ net/phòng/đêm không bao gồm bữa sáng). Phụ phí cho trẻ em sẽ được thanh toán trực tiếp cho khách sạn. • Trẻ em từ 12 tuổi trở lên được xem như người lớn và yêu cầu kê thêm giường phụ loại phù hợp (700.000 VNĐ net/phòng/đêm có ăn sáng; 600.000 VNĐ net/phòng/đêm không có ăn sáng). ', 
    -- policy_text
    'Bạn phải đóng tiền cọc VND 1,000,000 khi nhận phòng. Cơ sở lưu trú chấp nhận tiền mặt và thẻ ghi nợ.
    Độ tuổi tối thiểu để nhận phòng là 18 tuổi. Khách nhỏ tuổi phải có người lớn đi cùng khi nhận phòng.
    Cơ sở lưu trú sẽ thu VND 180,000/mỗi khách khi bạn đặt thêm bữa sáng bổ sung.
	Bữa sáng tại cơ sở lưu trú được phục vụ từ 06:30 đến 10:30.
	Cơ sở lưu trú cấm hút thuốc.
    Không được mang theo thú cưng.
    Tất cả khách lưu trú hoặc đến thăm đều bắt buộc phải xuất trình một trong các loại giấy tờ tùy thân hợp lệ, có dán ảnh và còn thời hạn tại quầy lễ tân để đăng ký. (Lưu ý: Bắt buộc cung cấp bản gốc và đầy đủ thông tin.) Đối với khách là công dân Việt Nam: - Căn cước công dân (CCCD) / Căn cước (CC) / VNeID Đối với khách nước ngoài: - Hộ chiếu còn hiệu lực (Passport) và Thị thực (Visa) hoặc Thẻ tạm trú (Temporary Residence Card) còn thời hạn Khách sạn có quyền từ chối cho khách nhận phòng nếu không xuất trình được giấy tờ tùy thân hợp lệ theo quy định.',
    -- manager_id
    4
),

(
	-- name
	'Nature Hotel',
    -- floor
    7,
    -- description
	'Nature Hotel - Le Hong Phong là lựa chọn sáng giá dành cho những ai đang tìm kiếm một trải nghiệm xa hoa đầy thú vị trong kỳ nghỉ của mình. Lưu trú tại đây cũng là cách để quý khách chiều chuộng bản thân với những dịch vụ xuất sắc nhất và khiến kỳ nghỉ của mình trở nên thật đáng nhớ.
	Trung tâm thể dục của khách sạn là một trong những tiện nghi không thể bỏ qua khi lưu trú tại đây.
	Nhận ưu đãi đặc biệt dành cho các liệu pháp spa tinh tuý nhất giúp thư giãn tinh thần và làm tươi trẻ cơ thể.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Nature Hotel - Le Hong Phong chỉ dành riêng cho quý khách.
	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.
	Nature Hotel - Le Hong Phong là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Với những tiện nghi sẵn có Nature Hotel - Le Hong Phong thực sự là một nơi lưu trú hoàn hảo.',
    -- type
	'HOTEL',
    -- address
    '15c Lê Hồng Phong, Phường 4',
    -- city
    'Đà Lạt',
    -- star_rating
    4,
    -- review_rating
    8.7,
    -- check_in_time
    '14:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	'Chính sách dành cho trẻ em - Trẻ sơ sinh 0 – dưới 6 tuổi: 1 trẻ được ở miễn phí, sử dụng giường hiện có. - Trẻ em từ 7 – dưới 12 tuổi sẽ ở chung giường với bố mẹ và phải trả thêm phụ phí 100.000 VND/trẻ/đêm tại khách sạn. - Khách từ 13 tuổi trở lên sẽ được tính như người lớn và phải trả thêm phụ phí 230.000 VND/trẻ/đêm tại khách sạn. Chính sách giường phụ: Nếu có giường phụ, có thể thêm 1 người lớn hoặc 2 trẻ em.',
    -- policy_text
    'Cơ sở lưu trú sẽ thu VND 80,000/mỗi khách khi bạn đặt thêm bữa sáng bổ sung.
    Có dịch vụ đưa đón sân bay với phí VND 350,000/người.
    Trẻ từ 0 - dưới 6 tuổi: ở miễn phí sử dụng giường có sẵn cùng bố mẹ. Tối đa 1 bé. 
	Trẻ từ 7- dưới 10 tuổi: ngủ chung giường với bố mẹ và tính phụ thu tại khách sạn VND 170,000/bé/đêm.
    Trẻ từ 10 tuổi trở lên: tính như người lớn, ngủ chung giường với bố mẹ và phụ thu tại khách sạn 230,000/bé/đêm.',
    -- manager_id
    5
),

(
	-- name
	'Draha Halong Hotel',
    -- floor
    5,
    -- description
	'Khi lưu trú tại khách sạn thì nội thất và kiến trúc hẳn là hai yếu tố quan trọng khiến quý khách mãn nhãn. Với thiết kế độc đáo, Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! mang đến không gian lưu trú làm hài lòng quý khách.
	Từ sự kiện doanh nghiệp đến họp mặt công ty, Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! cung cấp đầy đủ các dịch vụ và tiện nghi đáp ứng mọi nhu cầu của quý khách và đồng nghiệp.
	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal!, một khách sạn tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.
	Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal!
	Nếu dự định có một kỳ nghỉ dài, thì Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! chính là lựa chọn dành cho quý khách. Với đầy đủ tiện nghi với chất lượng dịch vụ tuyệt vời, Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! sẽ khiến quý khách cảm thấy thoải mái như đang ở nhà vậy.
	Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! là lựa chọn sáng giá dành cho những ai đang tìm kiếm một trải nghiệm xa hoa đầy thú vị trong kỳ nghỉ của mình. Lưu trú tại đây cũng là cách để quý khách chiều chuộng bản thân với những dịch vụ xuất sắc nhất và khiến kỳ nghỉ của mình trở nên thật đáng nhớ.
	Không phải mọi khách sạn đều cho phép mang thú cưng theo cùng, nhưng với chính sách đặc biệt của mình Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! luôn chào đón những người bạn đồng hành thân thiết của du khách. Khách sạn thân thiện với thú cưng này cho phép quý khách tận hưởng kỳ nghỉ mà không phải bận tâm lo lắng như khi bỏ lại chúng ở nhà.
	Du lịch một mình cũng không hề kém phần thú vị và Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! là nơi thích hợp dành riêng cho những ai đề cao sự riêng tư trong kỳ lưu trú.
	Hãy sẵn sàng đón nhận trải nghiệm khó quên bằng dịch vụ độc đáo và hoàn hảo của khách sạn cùng các tiện nghi đầy đủ, đáp ứng mọi nhu cầu của quý khách.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! chỉ dành riêng cho quý khách.
	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.
	Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal! là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Tận hưởng trải nghiệm lưu trú xa hoa đầy thú vị không đâu sánh bằng tại Draha Halong Hotel - Fly and Stay - Your Perfect Package Deal!.',
    -- type
	'HOTEL',
    -- address
    '21 Phú Gia, Phường Hồng Gai',
    -- city
    'Hạ Long',
    -- star_rating
    4,
    -- review_rating
    8.8,
    -- check_in_time
    '14:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	'Chào mừng quý khách đến với Khách sạn Draha Halong! Để đảm bảo quá trình nhận phòng diễn ra suôn sẻ, vui lòng làm theo các hướng dẫn sau: Giấy tờ cần thiết 1- Giấy tờ tùy thân hợp lệ do Chính phủ cấp: Vui lòng xuất trình giấy tờ tùy thân hợp lệ (hộ chiếu, chứng minh nhân dân) khi nhận phòng. 2- Xác nhận đặt phòng: Chúng tôi khuyến khích quý khách mang theo bản in hoặc bản điện tử xác nhận đặt phòng. Quy trình nhận phòng - Đăng ký: Vui lòng đến quầy lễ tân và xuất trình giấy tờ tùy thân hợp lệ và xác nhận đặt phòng. - Thanh toán: Có thể yêu cầu đặt cọc hoặc thanh toán trước, tùy thuộc vào điều khoản đặt phòng của quý khách. - Chìa khóa và Thông tin: Quý khách sẽ nhận được chìa khóa phòng và được giới thiệu sơ lược về các tiện nghi và dịch vụ của khách sạn. Lưu ý thêm - Đối với bất kỳ yêu cầu hoặc thắc mắc đặc biệt nào, vui lòng thông báo cho nhân viên lễ tân khi nhận phòng. - Chúng tôi khuyến khích quý khách thông báo trước thời gian dự kiến ​​đến để đảm bảo quá trình nhận phòng diễn ra suôn sẻ. Chúng tôi rất mong được chào đón quý khách và mang đến cho quý khách một kỳ nghỉ tuyệt vời tại Khách sạn Draha Halong!',
    -- policy_text
    'Độ tuổi tối thiểu để nhận phòng là 18 tuổi. Khách nhỏ tuổi phải có người lớn đi cùng khi nhận phòng.
    Bạn có thể nhận phòng sớm hơn giờ quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú để xác nhận thông tin.
	Bạn có thể yêu cầu trả phòng trễ hơn quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú khi có nhu cầu.
    Cơ sở lưu trú sẽ thu VND 150,000/mỗi khách khi bạn đặt thêm bữa sáng bổ sung.
    Bữa sáng tại cơ sở lưu trú được phục vụ từ 06:30 đến 10:00.
    Chỉ được phép hút thuốc trong khu vực chỉ định.
    Được mang theo thú cưng. Có áp dụng phụ phí.
    Có dịch vụ đưa đón sân bay với phí VND 800,000/người.',
    -- manager_id
    6
),

(
	-- name
	'Hotel Majestic Saigon',
    -- floor
    8,
    -- description
	'Dù quý khách muốn tổ chức một sự kiện hay các dịp kỷ niệm đặc biệt khác, Hotel Majestic Saigon là lựa chọn tuyệt vời cho quý khách với phòng chức năng rộng lớn, được trang bị đầy đủ để sẵn sàng đáp ứng mọi yêu cầu.
	Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại Hotel Majestic Saigon
	Hotel Majestic Saigon là lựa chọn sáng giá dành cho những ai đang tìm kiếm một trải nghiệm xa hoa đầy thú vị trong kỳ nghỉ của mình. Lưu trú tại đây cũng là cách để quý khách chiều chuộng bản thân với những dịch vụ xuất sắc nhất và khiến kỳ nghỉ của mình trở nên thật đáng nhớ.
	Từ sự kiện doanh nghiệp đến họp mặt công ty, Hotel Majestic Saigon cung cấp đầy đủ các dịch vụ và tiện nghi đáp ứng mọi nhu cầu của quý khách và đồng nghiệp.
	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Hotel Majestic Saigon , một khách sạn tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.
	Du lịch một mình cũng không hề kém phần thú vị và Hotel Majestic Saigon là nơi thích hợp dành riêng cho những ai đề cao sự riêng tư trong kỳ lưu trú.
	Dịch vụ thượng hạng song hành với hàng loạt tiện nghi phong phú sẽ đem đến cho quý khách trải nghiệm của một kỳ nghỉ viên mãn nhất.
	Trung tâm thể dục của khách sạn là một trong những tiện nghi không thể bỏ qua khi lưu trú tại đây.
	Hưởng thụ một ngày thư thái đầy thú vị tại hồ bơi dù quý khách đang du lịch một mình hay cùng người thân.
	Nhận ưu đãi đặc biệt dành cho các liệu pháp spa tinh tuý nhất giúp thư giãn tinh thần và làm tươi trẻ cơ thể.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Hotel Majestic Saigon chỉ dành riêng cho quý khách.
	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.
	Hotel Majestic Saigon là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Tận hưởng trải nghiệm lưu trú xa hoa đầy thú vị không đâu sánh bằng tại Hotel Majestic Saigon.',
    -- type
	'HOTEL',
    -- address
    '01 Đồng Khởi, Bến Nghé, Quận 1',
    -- city
    'Hồ Chí Minh',
    -- star_rating
    5,
    -- review_rating
    8.9,
    -- check_in_time
    '14:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	'Trẻ em dưới 6 tuổi ngủ chung giường với bố mẹ được miễn phí, trẻ em từ 6 đến 11 tuổi phải trả thêm 500.000 VND/trẻ/đêm (đã bao gồm bữa sáng). Trẻ em từ 12 tuổi trở lên được tính như người lớn.',
    -- policy_text
    'Không được mang theo thú cưng.
    Theo quy định của pháp luật, người nước ngoài không được ở chung phòng với công dân Việt Nam nếu không có giấy chứng nhận kết hôn làm bằng chứng. Nếu không có giấy chứng nhận kết hôn, khách sạn có thể từ chối đặt phòng hoặc yêu cầu đặt thêm một phòng khác.',
    -- manager_id
    7
),

(
	-- name
	'Melia Bavi Mountain Retreat',
    -- floor
    2,
    -- description
	'Không chỉ sở hữu vị trí giúp quý khách dễ dàng ghé thăm những địa điểm lý thú trong chuyến hành trình, Melia Bavi Mountain Retreat cũng sẽ mang đến cho quý khách trải nghiệm lưu trú mỹ mãn.
	Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại Melia Bavi Mountain Retreat
	Melia Bavi Mountain Retreat là lựa chọn sáng giá dành cho những ai đang tìm kiếm một trải nghiệm xa hoa đầy thú vị trong kỳ nghỉ của mình. Lưu trú tại đây cũng là cách để quý khách chiều chuộng bản thân với những dịch vụ xuất sắc nhất và khiến kỳ nghỉ của mình trở nên thật đáng nhớ.
	Một trong những đặc điểm chính của khách sạn này là các liệu pháp spa đa dạng. Hãy nâng niu bản thân bằng các liệu pháp thư giãn, phục hồi giúp quý khách tươi trẻ thân, tâm.
	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Melia Bavi Mountain Retreat, một khách sạn tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.
	Hãy tận hưởng trải nghiệm lưu trú có một không hai tại toà nhà mang đậm dấu ấn lịch sử của Melia Bavi Mountain Retreat, điều quý khách khó có thể tìm thấy tại bất kỳ đâu.
	Khách sạn này là nơi tốt nhất dành cho những ai mong muốn một nơi thanh bình, thư thái để ẩn mình khỏi đám đông ồn ã, xô bồ.
	Dịch vụ thượng hạng song hành với hàng loạt tiện nghi phong phú sẽ đem đến cho quý khách trải nghiệm của một kỳ nghỉ viên mãn nhất.
	Trung tâm thể dục của khách sạn là một trong những tiện nghi không thể bỏ qua khi lưu trú tại đây.
	Hưởng thụ một ngày thư thái đầy thú vị tại hồ bơi dù quý khách đang du lịch một mình hay cùng người thân.
	Nhận ưu đãi đặc biệt dành cho các liệu pháp spa tinh tuý nhất giúp thư giãn tinh thần và làm tươi trẻ cơ thể.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Melia Bavi Mountain Retreat chỉ dành riêng cho quý khách.
	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.
	Melia Bavi Mountain Retreat là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Tận hưởng trải nghiệm lưu trú xa hoa đầy thú vị không đâu sánh bằng tại Melia Bavi Mountain Retreat.',
    -- type
	'HOTEL',
    -- address
    'Vườn quốc gia Ba Vì, Huyện Ba Vì',
    -- city
    'Hà Nội',
    -- star_rating
    5,
    -- review_rating
    8.5,
    -- check_in_time
    '14:00',
    -- check_out_time
    '11:00',
    -- check_in_instructions
	'Xin lưu ý rằng trẻ em của quý khách có thể phải trả thêm phí khi nhận phòng tại khách sạn. Vui lòng gọi điện cho khách sạn trước ngày nhận phòng để biết thêm thông tin. Vui long luu y, tre em co the bi thu them phi khi nhan phong tai khach san. Vui long lien he khach san truoc khi nhan phong de biet them thong tin chi tiet.',
    -- policy_text
    'Bạn phải đóng tiền cọc 0 khi nhận phòng. Cơ sở lưu trú chấp nhận tiền mặt, thẻ ghi nợ hoặc thẻ tín dụng.
    Độ tuổi tối thiểu để nhận phòng là 18 tuổi. Khách nhỏ tuổi phải có người lớn đi cùng khi nhận phòng.
    Bạn có thể yêu cầu trả phòng trễ hơn quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú khi có nhu cầu.
    Bạn phải đóng thuế du lịch trị giá VND 60,000 cho mỗi khách khi nhận phòng.
	Cơ sở lưu trú cấm hút thuốc.
	Không được mang theo thú cưng.
	Vui lòng lưu ý rằng trẻ em của quý khách có thể phải trả phí khi nhận phòng tại khách sạn. Vui lòng gọi điện cho khách sạn trước ngày nhận phòng để biết thêm thông tin. Vui lòng lưu ý rằng quý khách sẽ phải mua vé vào cửa Vườn quốc gia Ba Vì cho khách và xe. Vui lòng liên hệ với chỗ nghỉ để biết thêm chi tiết qua địa chỉ info@meliabavimountain.com',
    -- manager_id
    8
),

(
	-- name
	'Duyen Ha Resort Cam Ranh',
    -- floor
    19,
    -- description
	'Không chỉ sở hữu vị trí giúp quý khách dễ dàng ghé thăm những địa điểm lý thú trong chuyến hành trình, Duyen Ha Resort Cam Ranh cũng sẽ mang đến cho quý khách trải nghiệm lưu trú mỹ mãn.
	Dù quý khách muốn tổ chức một sự kiện hay các dịp kỷ niệm đặc biệt khác, Duyen Ha Resort Cam Ranh là lựa chọn tuyệt vời cho quý khách với phòng chức năng rộng lớn, được trang bị đầy đủ để sẵn sàng đáp ứng mọi yêu cầu.
	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Duyen Ha Resort Cam Ranh, một nơi nghỉ tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.
	Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại Duyen Ha Resort Cam Ranh
	Nếu dự định có một kỳ nghỉ dài, thì Duyen Ha Resort Cam Ranh chính là lựa chọn dành cho quý khách. Với đầy đủ tiện nghi với chất lượng dịch vụ tuyệt vời, Duyen Ha Resort Cam Ranh sẽ khiến quý khách cảm thấy thoải mái như đang ở nhà vậy.
	Duyen Ha Resort Cam Ranh là lựa chọn sáng giá dành cho những ai đang tìm kiếm một trải nghiệm xa hoa đầy thú vị trong kỳ nghỉ của mình. Lưu trú tại đây cũng là cách để quý khách chiều chuộng bản thân với những dịch vụ xuất sắc nhất và khiến kỳ nghỉ của mình trở nên thật đáng nhớ.
	Không phải mọi khách sạn đều cho phép mang thú cưng theo cùng, nhưng với chính sách đặc biệt của mình Duyen Ha Resort Cam Ranh luôn chào đón những người bạn đồng hành thân thiết của du khách. Khách sạn thân thiện với thú cưng này cho phép quý khách tận hưởng kỳ nghỉ mà không phải bận tâm lo lắng như khi bỏ lại chúng ở nhà.
	Khách sạn này là nơi tốt nhất dành cho những ai mong muốn một nơi thanh bình, thư thái để ẩn mình khỏi đám đông ồn ã, xô bồ.
	Một trong những đặc điểm chính của khách sạn này là các liệu pháp spa đa dạng. Hãy nâng niu bản thân bằng các liệu pháp thư giãn, phục hồi giúp quý khách tươi trẻ thân, tâm.
	Dịch vụ thượng hạng song hành với hàng loạt tiện nghi phong phú sẽ đem đến cho quý khách trải nghiệm của một kỳ nghỉ viên mãn nhất.
	Trung tâm thể dục của nơi nghỉ là một trong những tiện nghi không thể bỏ qua khi lưu trú tại đây.
	Hưởng thụ một ngày thư thái đầy thú vị tại hồ bơi dù quý khách đang du lịch một mình hay cùng người thân.
	Nhận ưu đãi đặc biệt dành cho các liệu pháp spa tinh tuý nhất giúp thư giãn tinh thần và làm tươi trẻ cơ thể.
	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.
	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Duyen Ha Resort Cam Ranh chỉ dành riêng cho quý khách.
	Sóng WiFi phủ khắp các khu vực chung của nơi nghỉ cho phép quý khách luôn kết nối với gia đình và bè bạn.
	Duyen Ha Resort Cam Ranh là nơi nghỉ sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.
	Tận hưởng trải nghiệm lưu trú xa hoa đầy thú vị không đâu sánh bằng tại Duyen Ha Resort Cam Ranh.',
    -- type
	'RESORT',
    -- address
    'D9B, Huyện Cam Lâm',
    -- city
    'Nha Trang',
    -- star_rating
    5,
    -- review_rating
    8.8,
    -- check_in_time
    '15:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	'Quý khách có thể được yêu cầu xuất trình giấy tờ tùy thân hợp lệ do chính phủ cấp khi nhận phòng, cùng với thẻ tín dụng hoặc tiền mặt để thanh toán tiền đặt cọc và các chi phí phát sinh. Yêu cầu đặc biệt có thể tùy thuộc vào tình trạng phòng trống của khách sạn tại thời điểm nhận phòng và có thể phát sinh thêm phí. Khách sạn không đảm bảo đáp ứng được yêu cầu đặc biệt. Trẻ em dưới 4 tuổi được ở miễn phí nếu sử dụng giường hiện có. Trẻ em từ 4 đến dưới 12 tuổi (sử dụng giường hiện có) sẽ phải trả thêm phí khi nhận phòng. Trẻ em từ 12 tuổi trở lên được tính là người lớn và phải sử dụng giường phụ. Phí giường phụ tùy thuộc vào loại phòng quý khách chọn.',
    -- policy_text
    'Bạn phải đóng tiền cọc VND 2,000,000 khi nhận phòng. Cơ sở lưu trú chấp nhận tiền mặt, thẻ ghi nợ hoặc thẻ tín dụng.
    Bạn có thể nhận phòng sớm hơn giờ quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú để xác nhận thông tin.
	Bạn có thể yêu cầu trả phòng trễ hơn quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú khi có nhu cầu.
    Cơ sở lưu trú sẽ thu VND 3,000,000/mỗi khách khi bạn đặt thêm bữa sáng bổ sung.
    Bữa sáng tại cơ sở lưu trú được phục vụ từ 06:00 đến 10:00.
    Chỉ được phép hút thuốc trong khu vực chỉ định.
    Được mang theo thú cưng.
    Có dịch vụ đưa đón sân bay với phí VND 300,000/người.
	Quý khách có thể được yêu cầu xuất trình giấy tờ tùy thân hợp lệ do chính phủ cấp khi nhận phòng, cùng với thẻ tín dụng hoặc tiền mặt để thanh toán tiền đặt cọc và các chi phí phát sinh.
	Yêu cầu đặc biệt có thể tùy thuộc vào tình trạng phòng trống của khách sạn tại thời điểm nhận phòng và có thể phát sinh thêm phí. Khách sạn không đảm bảo đáp ứng được yêu cầu đặc biệt.
	Giá phòng ngày 31 tháng 12 năm 2019 đã bao gồm bữa tối gala.
	Trẻ em dưới 6 tuổi được ở miễn phí nếu sử dụng giường hiện có.
	Trẻ em từ 12 tuổi trở lên được tính là người lớn và phải sử dụng giường phụ. Phí giường phụ tùy thuộc vào loại phòng quý khách chọn, phụ phí sẽ được thanh toán khi nhận phòng.',
    -- manager_id
    9
),

(
	-- name
	'Sandy Beach Non Nuoc Resort',
    -- floor
    4,
    -- description
	'Dù quý khách muốn tổ chức một sự kiện hay các dịp kỷ niệm đặc biệt khác, Sandy Beach Non Nuoc Resort là lựa chọn tuyệt vời cho quý khách với phòng chức năng rộng lớn, được trang bị đầy đủ để sẵn sàng đáp ứng mọi yêu cầu.

	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Sandy Beach Non Nuoc Resort, một nơi nghỉ tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.

	Khách sạn này là nơi tốt nhất dành cho những ai mong muốn một nơi thanh bình, thư thái để ẩn mình khỏi đám đông ồn ã, xô bồ.

	Hãy sẵn sàng đón nhận trải nghiệm khó quên bằng dịch vụ độc đáo và hoàn hảo của nơi nghỉ cùng các tiện nghi đầy đủ, đáp ứng mọi nhu cầu của quý khách.

	Trung tâm thể dục của nơi nghỉ là một trong những tiện nghi không thể bỏ qua khi lưu trú tại đây.

	Hưởng thụ một ngày thư thái đầy thú vị tại hồ bơi dù quý khách đang du lịch một mình hay cùng người thân.

	Nhận ưu đãi đặc biệt dành cho các liệu pháp spa tinh tuý nhất giúp thư giãn tinh thần và làm tươi trẻ cơ thể.

	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.

	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Sandy Beach Non Nuoc Resort chỉ dành riêng cho quý khách.

	Sóng WiFi phủ khắp các khu vực chung của nơi nghỉ cho phép quý khách luôn kết nối với gia đình và bè bạn.

	Sandy Beach Non Nuoc Resort là nơi nghỉ sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.

	Tận hưởng trải nghiệm lưu trú xa hoa đầy thú vị không đâu sánh bằng tại Sandy Beach Non Nuoc Resort.',
    -- type
	'RESORT',
    -- address
    '21 Trường Sa, Phường Hòa Hải',
    -- city
    'Đà Nẵng',
    -- star_rating
    4,
    -- review_rating
    8.2,
    -- check_in_time
    '15:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	NULL,
    -- policy_text
    'Bạn có thể nhận phòng sớm hơn giờ quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú để xác nhận thông tin.
    Cơ sở lưu trú sẽ thu VND 300,000/mỗi khách khi bạn đặt thêm bữa sáng bổ sung.
	Bữa sáng tại cơ sở lưu trú được phục vụ từ 06:30 đến 10:00.
	Có dịch vụ đưa đón sân bay với phí VND 480,000/người.
	Phụ phí cho trẻ em:- Trẻ em dưới 6 tuổi: MIỄN PHÍ.
    Trẻ em từ 6 - 11 tuổi: 200.000 VND/đêm/người (không bao gồm giường phụ).
    Trẻ em từ 12 tuổi trở lên được tính như người lớn, bắt buộc phải có giường phụ với giá 500.000 VND/đêm/người.',
    -- manager_id
    10
),

(
	-- name
	'Harmony Homestay - Hanoi Homestay in Old Quarter',
    -- floor
    8,
    -- description
	'Dịch vụ tuyệt vời, cơ sở vật chất hoàn chỉnh và các tiện nghi nơi nghỉ cung cấp sẽ khiến quý khách không thể phàn nàn trong suốt kỳ lưu trú tại Harmony Homestay - Hanoi Homestay in Old Quarter.

	Với những tiện nghi sẵn có Harmony Homestay - Hanoi Homestay in Old Quarter thực sự là một nơi lưu trú hoàn hảo.',
    -- type
	'HOMESTAY',
    -- address
    '36 Phát Lộc, Lý Thái Tổ, Quận Hoàn Kiếm',
    -- city
    'Hà Nội',
    -- star_rating
    3,
    -- review_rating
    NULL,
    -- check_in_time
    '14:00',
    -- check_out_time
    '11:00',
    -- check_in_instructions
	NULL,
    -- policy_text
    NULL,
    -- manager_id
	11
),

(
	-- name
	'Romantique Hotel De Hanoi',
    -- floor
    9,
    -- description
	'Khi lưu trú tại khách sạn thì nội thất và kiến trúc hẳn là hai yếu tố quan trọng khiến quý khách mãn nhãn. Với thiết kế độc đáo, Romantique Hotel De Hanoi mang đến không gian lưu trú làm hài lòng quý khách.

	Từ sự kiện doanh nghiệp đến họp mặt công ty, Romantique Hotel De Hanoi cung cấp đầy đủ các dịch vụ và tiện nghi đáp ứng mọi nhu cầu của quý khách và đồng nghiệp.

	Hãy tận hưởng thời gian vui vẻ cùng cả gia đình với hàng loạt tiện nghi giải trí tại Romantique Hotel De Hanoi, một khách sạn tuyệt vời phù hợp cho mọi kỳ nghỉ bên người thân.

	Khách sạn này là lựa chọn hoàn hảo cho các kỳ nghỉ mát lãng mạn hay tuần trăng mật của các cặp đôi. Quý khách hãy tận hưởng những đêm đáng nhớ nhất cùng người thương của mình tại Romantique Hotel De Hanoi

	Nếu dự định có một kỳ nghỉ dài, thì Romantique Hotel De Hanoi chính là lựa chọn dành cho quý khách. Với đầy đủ tiện nghi với chất lượng dịch vụ tuyệt vời, Romantique Hotel De Hanoi sẽ khiến quý khách cảm thấy thoải mái như đang ở nhà vậy.

	Hãy sẵn sàng đón nhận trải nghiệm khó quên bằng dịch vụ độc đáo và hoàn hảo của khách sạn cùng các tiện nghi đầy đủ, đáp ứng mọi nhu cầu của quý khách.

	Quầy tiếp tân 24 giờ luôn sẵn sàng phục vụ quý khách từ thủ tục nhận phòng đến trả phòng hay bất kỳ yêu cầu nào. Nếu cần giúp đỡ xin hãy liên hệ đội ngũ tiếp tân, chúng tôi luôn sẵn sàng hỗ trợ quý khách.

	Tận hưởng những món ăn yêu thích với phong cách ẩm thực đặc biệt từ Romantique Hotel De Hanoi chỉ dành riêng cho quý khách.

	Sóng WiFi phủ khắp các khu vực chung của khách sạn cho phép quý khách luôn kết nối với gia đình và bè bạn.

	Romantique Hotel De Hanoi là khách sạn sở hữu đầy đủ tiện nghi và dịch vụ xuất sắc theo nhận định của hầu hết khách lưu trú.

	Hãy sẵn sàng đón nhận những giây phút vô giá khó phai trong suốt kỳ nghỉ của quý khách tại Romantique Hotel De Hanoi.',
    -- type
	'HOTEL',
    -- address
    '35 - 37 Bát Sứ, Hàng Bồ, Quận Hoàn Kiếm',
    -- city
    'Hà Nội',
    -- star_rating
    4,
    -- review_rating
    8.7,
    -- check_in_time
    '14:00',
    -- check_out_time
    '12:00',
    -- check_in_instructions
	'Vui lòng lưu ý rằng trẻ em của quý khách có thể phải trả thêm phí khi nhận phòng tại khách sạn. Vui lòng gọi điện cho khách sạn trước ngày nhận phòng để biết thêm thông tin chi tiết.',
    -- policy_text
    'Khi nhận phòng, bạn cần cung cấp CMND/CCCD. Các giấy tờ cần thiết có thể ở dạng bản mềm.
    Bạn có thể nhận phòng sớm hơn giờ quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú để xác nhận thông tin.
    Bạn có thể yêu cầu trả phòng trễ hơn quy định của cơ sở lưu trú và có áp dụng phụ phí. Vui lòng liên hệ với cơ sở lưu trú khi có nhu cầu.
    Cơ sở lưu trú sẽ thu VND 230,000/mỗi khách khi bạn đặt thêm bữa sáng bổ sung.
    Bữa sáng tại cơ sở lưu trú được phục vụ từ 06:30 đến 09:30.
	Cơ sở lưu trú cấm hút thuốc.
    Không được mang theo thú cưng.',
    -- manager_id
    12
);

/* =========================
   IMAGES
   ========================= */
CREATE TABLE images (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    owner_type ENUM('HOTEL', 'ROOM_TYPE') NOT NULL,
    owner_id BIGINT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,

    -- Generated column dùng để enforce unique primary image
    primary_owner_id BIGINT
        GENERATED ALWAYS AS (
            CASE
                WHEN is_primary = TRUE THEN owner_id
                ELSE NULL
            END
        ) STORED,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Unique: mỗi owner_type + owner_id chỉ có 1 primary image
    UNIQUE KEY ux_primary_image (owner_type, primary_owner_id)
);

INSERT INTO images (owner_type, owner_id, image_url, is_primary) VALUES
-- Hotel 1
('HOTEL',1,'hotel1_1',TRUE),
('HOTEL',1,'hotel1_2',FALSE),
('HOTEL',1,'hotel1_3',FALSE),
('HOTEL',1,'hotel1_4',FALSE),
('HOTEL',1,'hotel1_5',FALSE),

-- Hotel 2
('HOTEL',2,'hotel2_1',TRUE),
('HOTEL',2,'hotel2_2',FALSE),
('HOTEL',2,'hotel2_3',FALSE),
('HOTEL',2,'hotel2_4',FALSE),
('HOTEL',2,'hotel2_5',FALSE),

-- Hotel 3
('HOTEL',3,'hotel3_1',TRUE),
('HOTEL',3,'hotel3_2',FALSE),
('HOTEL',3,'hotel3_3',FALSE),
('HOTEL',3,'hotel3_4',FALSE),
('HOTEL',3,'hotel3_5',FALSE),

-- Hotel 4
('HOTEL',4,'hotel4_1',TRUE),
('HOTEL',4,'hotel4_2',FALSE),
('HOTEL',4,'hotel4_3',FALSE),
('HOTEL',4,'hotel4_4',FALSE),
('HOTEL',4,'hotel4_5',FALSE),

-- Hotel 5
('HOTEL',5,'hotel5_1',TRUE),
('HOTEL',5,'hotel5_2',FALSE),
('HOTEL',5,'hotel5_3',FALSE),
('HOTEL',5,'hotel5_4',FALSE),
('HOTEL',5,'hotel5_5',FALSE),

-- Hotel 6
('HOTEL',6,'hotel6_1',TRUE),
('HOTEL',6,'hotel6_2',FALSE),
('HOTEL',6,'hotel6_3',FALSE),
('HOTEL',6,'hotel6_4',FALSE),
('HOTEL',6,'hotel6_5',FALSE),

-- Hotel 7
('HOTEL',7,'hotel7_1',TRUE),
('HOTEL',7,'hotel7_2',FALSE),
('HOTEL',7,'hotel7_3',FALSE),
('HOTEL',7,'hotel7_4',FALSE),
('HOTEL',7,'hotel7_5',FALSE),

-- Hotel 8
('HOTEL',8,'hotel8_1',TRUE),
('HOTEL',8,'hotel8_2',FALSE),
('HOTEL',8,'hotel8_3',FALSE),
('HOTEL',8,'hotel8_4',FALSE),
('HOTEL',8,'hotel8_5',FALSE),

-- Hotel 9
('HOTEL',9,'hotel9_1',TRUE),
('HOTEL',9,'hotel9_2',FALSE),
('HOTEL',9,'hotel9_3',FALSE),
('HOTEL',9,'hotel9_4',FALSE),
('HOTEL',9,'hotel9_5',FALSE),

-- Hotel 10
('HOTEL',10,'hotel10_1',TRUE),
('HOTEL',10,'hotel10_2',FALSE),
('HOTEL',10,'hotel10_3',FALSE),
('HOTEL',10,'hotel10_4',FALSE),
('HOTEL',10,'hotel10_5',FALSE),

-- HOTEL 1 (1–4)
('ROOM_TYPE',1,'hotel1_standard1',TRUE),
('ROOM_TYPE',1,'hotel1_standard2',FALSE),
('ROOM_TYPE',1,'hotel1_standard3',FALSE),
('ROOM_TYPE',2,'hotel1_superior1',TRUE),
('ROOM_TYPE',2,'hotel1_superior2',FALSE),
('ROOM_TYPE',2,'hotel1_superior3',FALSE),
('ROOM_TYPE',3,'hotel1_deluxe1',TRUE),
('ROOM_TYPE',3,'hotel1_deluxe2',FALSE),
('ROOM_TYPE',3,'hotel1_deluxe3',FALSE),
('ROOM_TYPE',4,'hotel1_suite1',TRUE),
('ROOM_TYPE',4,'hotel1_suite2',FALSE),
('ROOM_TYPE',4,'hotel1_suite3',FALSE),

-- HOTEL 2 (5–6)
('ROOM_TYPE',5,'hotel2_standard1',TRUE),
('ROOM_TYPE',5,'hotel2_standard2',FALSE),
('ROOM_TYPE',5,'hotel2_standard3',FALSE),
('ROOM_TYPE',6,'hotel2_superior1',TRUE),
('ROOM_TYPE',6,'hotel2_superior2',FALSE),
('ROOM_TYPE',6,'hotel2_superior3',FALSE),

-- HOTEL 3 (7-8)
('ROOM_TYPE',7,'hotel3_standard1',TRUE),
('ROOM_TYPE',7,'hotel3_standard2',FALSE),
('ROOM_TYPE',7,'hotel3_standard3',FALSE),
('ROOM_TYPE',8,'hotel3_superior1',TRUE),
('ROOM_TYPE',8,'hotel3_superior2',FALSE),
('ROOM_TYPE',8,'hotel3_superior3',FALSE),

-- HOTEL 4 (9-13)
('ROOM_TYPE',9,'hotel4_standard1',TRUE),
('ROOM_TYPE',9,'hotel4_standard2',FALSE),
('ROOM_TYPE',9,'hotel4_standard3',FALSE),
('ROOM_TYPE',10,'hotel4_superior1',TRUE),
('ROOM_TYPE',10,'hotel4_superior2',FALSE),
('ROOM_TYPE',10,'hotel4_superior3',FALSE),
('ROOM_TYPE',11,'hotel4_deluxe1',TRUE),
('ROOM_TYPE',11,'hotel4_deluxe2',FALSE),
('ROOM_TYPE',11,'hotel4_deluxe3',FALSE),
('ROOM_TYPE',12,'hotel4_suite1',TRUE),
('ROOM_TYPE',12,'hotel4_suite2',FALSE),
('ROOM_TYPE',12,'hotel4_suite3',FALSE),
('ROOM_TYPE',13,'hotel4_family1',TRUE),
('ROOM_TYPE',13,'hotel4_family2',FALSE),
('ROOM_TYPE',13,'hotel4_family3',FALSE),

-- HOTEL 5 (14–16)
('ROOM_TYPE',14,'hotel5_superior1',TRUE),
('ROOM_TYPE',14,'hotel5_superior2',FALSE),
('ROOM_TYPE',14,'hotel5_superior3',FALSE),
('ROOM_TYPE',15,'hotel5_deluxe1',TRUE),
('ROOM_TYPE',15,'hotel5_deluxe2',FALSE),
('ROOM_TYPE',15,'hotel5_deluxe3',FALSE),
('ROOM_TYPE',16,'hotel5_suite1',TRUE),
('ROOM_TYPE',16,'hotel5_suite2',FALSE),
('ROOM_TYPE',16,'hotel5_suite3',FALSE),

-- HOTEL 6 (17–18)
('ROOM_TYPE',17,'hotel6_deluxe1',TRUE),
('ROOM_TYPE',17,'hotel6_deluxe2',FALSE),
('ROOM_TYPE',17,'hotel6_deluxe3',FALSE),
('ROOM_TYPE',18,'hotel6_suite1',TRUE),
('ROOM_TYPE',18,'hotel6_suite2',FALSE),
('ROOM_TYPE',18,'hotel6_suite3',FALSE),

-- HOTEL 7 (19–22)
('ROOM_TYPE',19,'hotel7_deluxe1',TRUE),
('ROOM_TYPE',19,'hotel7_deluxe2',FALSE),
('ROOM_TYPE',19,'hotel7_deluxe3',FALSE),
('ROOM_TYPE',20,'hotel7_suite1',TRUE),
('ROOM_TYPE',20,'hotel7_suite2',FALSE),
('ROOM_TYPE',20,'hotel7_suite3',FALSE),
('ROOM_TYPE',21,'hotel7_villa_garden1',TRUE),
('ROOM_TYPE',21,'hotel7_villa_garden2',FALSE),
('ROOM_TYPE',21,'hotel7_villa_garden3',FALSE),
('ROOM_TYPE',22,'hotel7_villa_pool1',TRUE),
('ROOM_TYPE',22,'hotel7_villa_pool2',FALSE),
('ROOM_TYPE',22,'hotel7_villa_pool3',FALSE),

-- HOTEL 8 (23-27)
('ROOM_TYPE',23,'hotel8_superior1',TRUE),
('ROOM_TYPE',23,'hotel8_superior2',FALSE),
('ROOM_TYPE',23,'hotel8_superior3',FALSE),
('ROOM_TYPE',24,'hotel8_deluxe1',TRUE),
('ROOM_TYPE',24,'hotel8_deluxe2',FALSE),
('ROOM_TYPE',24,'hotel8_deluxe3',FALSE),
('ROOM_TYPE',25,'hotel8_suite1',TRUE),
('ROOM_TYPE',25,'hotel8_suite2',FALSE),
('ROOM_TYPE',25,'hotel8_suite3',FALSE),
('ROOM_TYPE',26,'hotel8_family1',TRUE),
('ROOM_TYPE',26,'hotel8_family2',FALSE),
('ROOM_TYPE',26,'hotel8_family3',FALSE),
('ROOM_TYPE',27,'hotel8_villa1',TRUE),
('ROOM_TYPE',27,'hotel8_villa2',FALSE),
('ROOM_TYPE',27,'hotel8_villa3',FALSE),

-- HOTEL 9 (28)
('ROOM_TYPE',28,'hotel9_standard1',TRUE),
('ROOM_TYPE',28,'hotel9_standard2',FALSE),
('ROOM_TYPE',28,'hotel9_standard3',FALSE),

-- HOTEL 10 (29-31)
('ROOM_TYPE',29,'hotel10_deluxe1',TRUE),
('ROOM_TYPE',29,'hotel10_deluxe2',FALSE),
('ROOM_TYPE',29,'hotel10_deluxe3',FALSE),
('ROOM_TYPE',30,'hotel10_suite1',TRUE),
('ROOM_TYPE',30,'hotel10_suite2',FALSE),
('ROOM_TYPE',30,'hotel10_suite3',FALSE),
('ROOM_TYPE',31,'hotel10_family1',TRUE),
('ROOM_TYPE',31,'hotel10_family2',FALSE),
('ROOM_TYPE',31,'hotel10_family3',FALSE); 

/* =========================
   ROOM TYPES
   ========================= */
CREATE TABLE room_types (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    hotel_id BIGINT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    max_adults INT NOT NULL,
    max_children INT DEFAULT 0,
    base_price DECIMAL(12,2) NOT NULL,
    area_m2 INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_room_type_hotel
        FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

INSERT INTO room_types (hotel_id, name, description, max_adults, max_children, base_price, area_m2) VALUES
-- Hotel 1 (1-4)
(1,'Standard','Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản. Phòng không có cửa sổ.',2,1,362572,18),
(1,'Superior','Phòng nâng cấp với không gian rộng hơn.',2,1,387000,20),
(1,'Deluxe','Phòng cao cấp, view đẹp, nội thất hiện đại.',2,1,443571,25),
(1,'Suite','Phòng suite sang trọng, phòng khách riêng.',2,1,548228,30),

-- Hotel 2 (5-6)
(2,'Standard','Phòng tiêu chuẩn gần biển. Không hút thuốc',2,0,1359714,18),
(2,'Superior','Phòng có ban công, view biển. Rộng 20 m2, phòng thông minh, tiện dụng, riêng tư với giường cực kỳ thoải mái, nhiều loại gối mềm và cứng không gây dị ứng, bộ khăn trải giường cao cấp cùng với các tiện nghi Zazz độc đáo. Phòng có sẵn giường cỡ King hoặc giường đôi.',2,1,1509208,20),

-- Hotel 3 (7-8)
(3,'Standard','Phòng tiêu chuẩn trung tâm phố cổ.',2,0,602579,17),
(3,'Superior','Phòng rộng hơn, tiện nghi nâng cấp.',2,1,1350649,20),

-- Hotel 4 (9-13)
(4,'Standard','Phòng Standard 18 m² có cửa sổ là nơi nghỉ ngơi có máy lạnh với giường đôi lớn, phòng tắm riêng với vòi sen và nhìn ra sân trong. Các tiện nghi chính bao gồm TV màn hình phẳng, minibar, két an toàn và Wi-fi miễn phí để có một kỳ nghỉ tiện lợi.',2,1,597817,18),
(4,'Superior','Phòng Superior King, ban công nhìn ra núi. Thư giãn trong Phòng Superior King với ban công và tầm nhìn ra núi. Nơi nghỉ dưỡng rộng 21 m² có máy lạnh này cung cấp giường đôi lớn, phòng tắm riêng đầy đủ tiện nghi và các tiện nghi hiện đại như TV màn hình phẳng và Wifi miễn phí. Điểm nổi bật là ban công riêng của bạn, hoàn hảo để ngắm nhìn khung cảnh núi non tuyệt đẹp.',2,1,689503,21),
(4,'Deluxe','Phòng Deluxe sang trọng, ban công nhìn ra núi. Phù hợp cho bạn bè hoặc gia đình, Phòng Twin sang trọng với ban công và tầm nhìn ra núi có diện tích 23 m² với sự thoải mái có điều hòa. Phòng bao gồm hai giường đơn, phòng tắm riêng và các tiện nghi hiện đại như TV màn hình phẳng và Wi-fi miễn phí. Bước ra ban công riêng của bạn để thưởng thức phong cảnh núi non tuyệt đẹp.',2,1,689503,23),
(4,'Suite','Studio Suite Junior, Bồn tắm ngoài trời và Ban công nhìn ra thành phố. Thư giãn và trẻ hóa trong Studio Suite Junior với Bồn tắm, Ban công & View núi. Rộng 33 m², suite có máy lạnh này cung cấp một giường đôi lớn, phòng tắm riêng với bồn tắm thư giãn và các tiện nghi hiện đại như TV màn hình phẳng và Wifi miễn phí. Bước ra ban công hoặc sân hiên riêng của bạn để ngắm nhìn khung cảnh núi non ngoạn mục, làm cho kỳ nghỉ của bạn thực sự đáng nhớ.',2,1,1089000,27),
(4,'Family','Studio Suite Gia đình Ba người, Ban công nhìn ra núi. Hoàn hảo cho các gia đình, Studio Suite Gia đình Ba người rộng 27 m² với ban công và tầm nhìn ra núi mang đến sự thoải mái với máy lạnh. Suite này bao gồm một phòng ngủ riêng với 01 giường đơn và 01 giường đôi lớn, phòng tắm riêng với vòi sen và máy sấy tóc, và TV màn hình phẳng với các kênh truyền hình cáp. Khách có thể tận hưởng ban công riêng nhìn ra khung cảnh núi non hùng vĩ, cùng với cách âm và minibar.',3,1,1149172,33),

-- Hotel 5 (14-16)
(5,'Superior','Phòng yên tĩnh, gần thiên nhiên.',2,1,2888963,35),
(5,'Deluxe','Phòng rộng, view đồi.',2,1,3509610,47),
(5,'Suite','Suite nghỉ dưỡng dài ngày.',2,2,5207904,60),

-- Hotel 6 (17-18)
(6,'Deluxe',
'Bữa sáng cao cấp hàng ngày tại Nhà hàng Senses
Đồ uống chào mừng miễn phí khi nhận phòng
Bộ tiện nghi trà và cà phê miễn phí
2 chai nước khoáng miễn phí mỗi phòng mỗi đêm
Miễn phí sử dụng Hồ bơi vô cực ngoài trời 4 mùa
Miễn phí sử dụng Trung tâm thể dục, Câu lạc bộ trẻ em và Khu vui chơi trẻ em
Miễn phí tham quan tàn tích Pháp (1 lần tham quan mỗi phòng mỗi đêm từ 8:00 sáng đến 10:30 sáng và từ 14:00 chiều đến 16:00 chiều, cứ sau 30 phút)
Miễn phí sử dụng xe đạp 01 giờ cho mỗi khách (tùy thuộc vào tình trạng thực tế)
Dịch vụ khác:
Tiện nghi chào mừng
Thông tin du lịch, đặt bàn nhà hàng và bất kỳ hỗ trợ nào khác
Internet trong phòng và trong các khu nghỉ dưỡng khác nhau
Thực đơn gối độc quyền theo yêu cầu
Quyền lợi không bao gồm:
Vé vào Vườn quốc gia Ba Vì',
2,0,3582411,49),
(6,'Suite','Bữa sáng cao cấp hàng ngày tại Nhà hàng Senses  Đồ uống chào mừng miễn phí khi nhận phòng Tiện nghi trà và cà phê miễn phí  2 chai nước khoáng miễn phí mỗi phòng mỗi đêm  Miễn phí sử dụng Hồ bơi vô cực ngoài trời 4 mùa  Miễn phí sử dụng Trung tâm thể dục, Câu lạc bộ trẻ em và Khu vui chơi trẻ em  Tham quan khu di tích Pháp miễn phí (1 lần tham quan mỗi phòng mỗi đêm từ 8:00 sáng đến 10:30 sáng và từ 14:00 chiều đến 16:00 chiều, 30 phút một lần) Miễn phí sử dụng xe đạp 01 giờ cho mỗi khách (tùy thuộc vào tình trạng thực tế)  Dịch vụ khác:  Tiện nghi chào mừng  Thông tin du lịch, đặt bàn nhà hàng và bất kỳ hỗ trợ nào khác  Internet trong phòng và trong các khu vực nghỉ dưỡng khác nhau  Thực đơn gối độc quyền theo yêu cầu  Quyền lợi không bao gồm:  Vé vào Vườn quốc gia Ba Vì.',2,0,2600000,60),

-- Hotel 7 (19-22)
(7,'Deluxe','Bạn sẽ yêu thích phong cách phòng này với tất cả các tiện nghi và dịch vụ bạn mong đợi từ một kỳ nghỉ 5 sao',2,0,1949360,34),
(7,'Suite','Hoàn hảo cho các cặp đôi lãng mạn thích không gian rộng rãi hơn với khu vườn cảnh quan.',2,0,2524860,43),
(7,'Villa garden','Biệt thự của chúng tôi tạo ra kỳ nghỉ riêng tư và sang trọng cho các cặp đôi hưởng tuần trăng mật và gia đình có con nhỏ',2,0,2100000,106),
(7,'Villa pool','Tận hưởng với hồ bơi riêng, phòng tắm bán ngoài trời, rất lý tưởng cho kỳ trăng mật hoặc một kỳ nghỉ lãng mạn.',2,0,2100000,106),

-- Hotel 8 (23-27)
(8,'Superior','Phòng cơ bản',2,1,766359,32),
(8,'Deluxe','Nằm trong tòa nhà mới hướng biển của khu nghỉ dưỡng, những phòng rộng 46 mét vuông này có ban công có nội thất, nơi bạn có thể ngắm nhìn khung cảnh biển tuyệt vời. Các phòng này có thể chứa các cặp đôi và gia đình với tùy chọn giường cỡ king hoặc hai giường đôi, đồng thời có phòng tắm với vòi sen. Truy cập Wi-Fi miễn phí.',2,0,1287379,46),
(8,'Suite','Được thiết kế với tông màu dịu nhẹ và điểm nhấn bằng gỗ sáng màu, những bungalow rộng rãi này (44 mét vuông) bao gồm một phòng ngủ với giường cỡ King hoặc hai giường đôi và phòng tắm có bồn tắm và vòi sen. Wi-Fi truy cập miễn phí.',2,1,1331771,44),
(8,'Family','Với ban công mở ra khu vườn nhiệt đới, những biệt thự rộng rãi (92 mét vuông) này tạo nên một nơi nghỉ ngơi thoải mái cho các cặp đôi và là nơi lý tưởng cho các gia đình. Mỗi biệt thự có một phòng ngủ chính rộng rãi, một phòng khách thoáng mát, một phòng tắm có bồn tắm và vòi sen, và dễ dàng tiếp cận khu vực hồ bơi. Truy cập Wi-Fi miễn phí.',4,0,2841112,93),
(8,'Villa','Mỗi biệt thự có khu vực sinh hoạt rộng rãi (92 mét vuông), được bài trí theo phong cách êm dịu với điểm nhấn là gỗ sáng màu. Biển Đông và Bãi biển Non Nước tạo nên phông nền hấp dẫn cho sân hiên có nội thất của bạn và mỗi biệt thự có thể chứa các cặp đôi hoặc gia đình. Có phòng tắm với bồn tắm và vòi sen, và bạn cũng sẽ được tận hưởng Wi-Fi miễn phí.',4,3,3196250,93),

-- Hotel 9 (28)
(9,'Standard','Phòng tiêu chuẩn.',2,0,443012,11),

-- Hotel 10 (29-31)
(10,'Deluxe','Phòng rộng, thoải mái.',2,0,1036364,26),
(10,'Suite','Suite nghỉ dưỡng.',2,0,1554345,35),
(10,'Family','Phòng gia đình nghỉ dưỡng.',3,0,2117143,45);

/* =========================
   ROOMS (physical rooms)
   ========================= */
CREATE TABLE rooms (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    hotel_id BIGINT NOT NULL,
    room_type_id BIGINT NOT NULL,
    room_number VARCHAR(20),
    floor INT,
    `status` VARCHAR(30) DEFAULT 'AVAILABLE',
    CONSTRAINT fk_room_hotel
        FOREIGN KEY (hotel_id) REFERENCES hotels(id),
    CONSTRAINT fk_room_type
        FOREIGN KEY (room_type_id) REFERENCES room_types(id)
);

INSERT INTO rooms (hotel_id, room_type_id, room_number, floor) VALUES
/* ================= HOTEL 1 (7 tầng) ================= */
/* Types: 1-4 */
(1,1,'101',1),(1,1,'102',1),(1,1,'201',2),(1,1,'202',2),
(1,1,'301',3),(1,1,'302',3),(1,1,'401',4),(1,1,'402',4),
(1,1,'501',5),(1,1,'502',5),(1,1,'601',6),(1,1,'602',6),
(1,1,'701',7),(1,1,'702',7),

(1,2,'103',1),(1,2,'203',2),(1,2,'303',3),(1,2,'403',4),
(1,2,'503',5),(1,2,'603',6),(1,2,'703',7),

(1,3,'104',1),(1,3,'204',2),(1,3,'304',3),
(1,3,'404',4),(1,3,'504',5),(1,3,'604',6),

(1,4,'105',1),(1,4,'205',2),(1,4,'305',3),(1,4,'405',4),


/* ================= HOTEL 2 (10 tầng) ================= */
/* Types: 5-6 */
(2,5,'101',1),(2,5,'201',2),(2,5,'301',3),(2,5,'401',4),
(2,5,'501',5),(2,5,'601',6),(2,5,'701',7),(2,5,'801',8),
(2,5,'901',9),(2,5,'1001',10),
(2,5,'102',1),(2,5,'202',2),(2,5,'302',3),(2,5,'402',4),
(2,5,'502',5),(2,5,'602',6),(2,5,'702',7),(2,5,'802',8),
(2,5,'902',9),(2,5,'1002',10),

(2,6,'103',1),(2,6,'203',2),(2,6,'303',3),(2,6,'403',4),
(2,6,'503',5),(2,6,'603',6),(2,6,'703',7),(2,6,'803',8),
(2,6,'903',9),(2,6,'1003',10),


/* ================= HOTEL 3 (7 tầng) ================= */
/* Types: 7-8 */
(3,7,'101',1),(3,7,'201',2),(3,7,'301',3),(3,7,'401',4),
(3,7,'501',5),(3,7,'601',6),(3,7,'701',7),

(3,8,'102',1),(3,8,'202',2),(3,8,'302',3),(3,8,'402',4),
(3,8,'502',5),(3,8,'602',6),


/* ================= HOTEL 4 (5 tầng) ================= */
/* Types: 9-13 */
(4,9,'101',1),(4,9,'102',1),(4,9,'201',2),(4,9,'202',2),
(4,9,'301',3),(4,9,'302',3),(4,9,'401',4),(4,9,'402',4),

(4,10,'103',1),(4,10,'203',2),(4,10,'303',3),(4,10,'403',4),
(4,10,'503',5),

(4,11,'104',1),(4,11,'204',2),(4,11,'304',3),(4,11,'404',4),

(4,12,'105',1),(4,12,'205',2),(4,12,'305',3),

(4,13,'106',1),(4,13,'206',2),(4,13,'306',3),


/* ================= HOTEL 5 (8 tầng) ================= */
/* Types: 14-16 */
(5,14,'101',1),(5,14,'201',2),(5,14,'301',3),(5,14,'401',4),
(5,14,'501',5),(5,14,'601',6),(5,14,'701',7),(5,14,'801',8),

(5,15,'102',1),(5,15,'202',2),(5,15,'302',3),(5,15,'402',4),
(5,15,'502',5),(5,15,'602',6),

(5,16,'103',1),(5,16,'203',2),(5,16,'303',3),(5,16,'403',4),


/* ================= HOTEL 6 (2 tầng) ================= */
/* Types: 17-18 */
(6,17,'101',1),(6,17,'102',1),(6,17,'103',1),(6,17,'104',1),
(6,17,'201',2),(6,17,'202',2),(6,17,'203',2),(6,17,'204',2),

(6,18,'105',1),(6,18,'205',2),(6,18,'106',1),(6,18,'206',2),


/* ================= HOTEL 7 (19 tầng) ================= */
/* Types: 19-22 */
(7,19,'101',1),(7,19,'201',2),(7,19,'301',3),(7,19,'401',4),
(7,19,'501',5),(7,19,'601',6),(7,19,'701',7),(7,19,'801',8),
(7,19,'901',9),(7,19,'1001',10),(7,19,'1101',11),
(7,19,'1201',12),(7,19,'1301',13),(7,19,'1401',14),
(7,19,'1501',15),

(7,20,'102',1),(7,20,'202',2),(7,20,'302',3),(7,20,'402',4),
(7,20,'502',5),(7,20,'602',6),(7,20,'702',7),(7,20,'802',8),

(7,21,'103',1),(7,21,'203',2),(7,21,'303',3),(7,21,'403',4),

(7,22,'104',1),(7,22,'204',2),(7,22,'304',3),(7,22,'404',4),


/* ================= HOTEL 8 (4 tầng) ================= */
/* Types: 23-27 */
(8,23,'101',1),(8,23,'201',2),(8,23,'301',3),(8,23,'401',4),

(8,24,'102',1),(8,24,'202',2),(8,24,'302',3),

(8,25,'103',1),(8,25,'203',2),

(8,26,'104',1),(8,26,'204',2),

(8,27,'105',1),(8,27,'205',2),


/* ================= HOTEL 9 (8 tầng) ================= */
/* Type: 28 */
(9,28,'101',1),(9,28,'201',2),(9,28,'301',3),(9,28,'401',4),
(9,28,'501',5),(9,28,'601',6),(9,28,'701',7),(9,28,'801',8),


/* ================= HOTEL 10 (9 tầng) ================= */
/* Types: 29-31 */
(10,29,'101',1),(10,29,'201',2),(10,29,'301',3),(10,29,'401',4),
(10,29,'501',5),(10,29,'601',6),(10,29,'701',7),(10,29,'801',8),

(10,30,'102',1),(10,30,'202',2),(10,30,'302',3),(10,30,'402',4),

(10,31,'103',1),(10,31,'203',2),(10,31,'303',3);

/* =========================
   AMENITIES (expandable)
   ========================= */
CREATE TABLE amenities (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    `code` VARCHAR(50) UNIQUE NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    icon VARCHAR(100),
    category ENUM('ROOM_FEATURE', 'FREE_SERVICE', 'EXTRA_SERVICE') NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO amenities (`code`, `name`, icon, category, is_active) VALUES
/* ================= ROOM FEATURES ================= */
('BED_SINGLE', 'Giường đơn', 'bed-single.svg', 'ROOM_FEATURE', TRUE),
('BED_DOUBLE', 'Giường đôi', 'bed-double.svg', 'ROOM_FEATURE', TRUE),
('BED_KING', 'Giường King Size', 'bed-king.svg', 'ROOM_FEATURE', TRUE),
('AIR_CONDITIONER', 'Điều hòa', 'air-conditioner.svg', 'ROOM_FEATURE', TRUE),
('TELEVISION', 'TV màn hình phẳng', 'tv.svg', 'ROOM_FEATURE', TRUE),
('MINI_BAR', 'Minibar', 'minibar.svg', 'ROOM_FEATURE', TRUE),
('BALCONY', 'Ban công riêng', 'balcony.svg', 'ROOM_FEATURE', TRUE),
('SEA_VIEW', 'Hướng biển', 'sea-view.svg', 'ROOM_FEATURE', TRUE),
('MOUNTAIN_VIEW', 'Hướng núi', 'mountain-view.svg', 'ROOM_FEATURE', TRUE),
('BATHTUB', 'Bồn tắm', 'bathtub.svg', 'ROOM_FEATURE', TRUE),
('SHOWER', 'Phòng tắm đứng', 'shower.svg', 'ROOM_FEATURE', TRUE),
('WORK_DESK', 'Bàn làm việc', 'desk.svg', 'ROOM_FEATURE', TRUE),
('WARDROBE', 'Tủ quần áo', 'wardrobe.svg', 'ROOM_FEATURE', TRUE),
('SAFE_BOX', 'Két an toàn', 'safe-box.svg', 'ROOM_FEATURE', TRUE),
('HAIR_DRYER', 'Máy sấy tóc', 'hair-dryer.svg', 'ROOM_FEATURE', TRUE),

/* ================= FREE SERVICES ================= */
('FREE_WIFI', 'WiFi miễn phí', 'wifi.svg', 'FREE_SERVICE', TRUE),
('FREE_PARKING', 'Bãi đỗ xe miễn phí', 'parking.svg', 'FREE_SERVICE', TRUE),
('FREE_BREAKFAST', 'Bữa sáng miễn phí', 'breakfast.svg', 'FREE_SERVICE', TRUE),
('SWIMMING_POOL', 'Hồ bơi', 'pool.svg', 'FREE_SERVICE', TRUE),
('GYM', 'Phòng gym', 'gym.svg', 'FREE_SERVICE', TRUE),
('RECEPTION_24H', 'Lễ tân 24/7', 'reception.svg', 'FREE_SERVICE', TRUE),
('DAILY_HOUSEKEEPING', 'Dọn phòng hằng ngày', 'housekeeping.svg', 'FREE_SERVICE', TRUE),
('LUGGAGE_STORAGE', 'Giữ hành lý', 'luggage.svg', 'FREE_SERVICE', TRUE),
('ELEVATOR', 'Thang máy', 'elevator.svg', 'FREE_SERVICE', TRUE),
('AIRPORT_SHUTTLE_FREE', 'Đưa đón sân bay miễn phí', 'airport-shuttle.svg', 'FREE_SERVICE', TRUE),

/* ================= EXTRA SERVICES ================= */
('EXTRA_BREAKFAST', 'Thêm suất ăn sáng', 'extra-breakfast.svg', 'EXTRA_SERVICE', TRUE),
('SPA_SERVICE', 'Dịch vụ spa', 'spa.svg', 'EXTRA_SERVICE', TRUE),
('LAUNDRY_SERVICE', 'Giặt ủi', 'laundry.svg', 'EXTRA_SERVICE', TRUE),
('AIRPORT_SHUTTLE_PAID', 'Đưa đón sân bay (tính phí)', 'airport-shuttle-paid.svg', 'EXTRA_SERVICE', TRUE),
('CAR_RENTAL', 'Thuê xe', 'car-rental.svg', 'EXTRA_SERVICE', TRUE),
('BABY_COT', 'Nôi em bé', 'baby-cot.svg', 'EXTRA_SERVICE', TRUE),
('EXTRA_BED', 'Giường phụ', 'extra-bed.svg', 'EXTRA_SERVICE', TRUE),
('GOLF_SERVICE', 'Chơi golf', 'golf.svg', 'EXTRA_SERVICE', TRUE),
('PRIVATE_DINNER', 'Tiệc tối riêng', 'private-dinner.svg', 'EXTRA_SERVICE', TRUE),
('ROOM_DECORATION', 'Trang trí phòng', 'room-decoration.svg', 'EXTRA_SERVICE', TRUE);

/* =========================
   PRICE UNITS
   ========================= */
CREATE TABLE price_units (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL,     -- PER_PERSON, PER_DAY, PER_NIGHT...
    name VARCHAR(100) NOT NULL,           -- Theo người, Theo ngày...
    description VARCHAR(255)
);

INSERT INTO price_units (code, name, description) VALUES
('PER_PERSON', 'Theo người', 'Tính theo mỗi người'),
('PER_DAY', 'Theo ngày', 'Tính theo số ngày'),
('PER_NIGHT', 'Theo đêm', 'Tính theo số đêm'),
('PER_USE', 'Theo lượt', 'Tính theo mỗi lần sử dụng'),
('PER_ROOM', 'Theo phòng', 'Tính theo phòng'),
('PER_HOUR', 'Theo giờ', 'Tính theo số giờ');

/* =========================
   HOTEL EXTRA SERVICES
   ========================= */
CREATE TABLE hotel_extra_services (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    hotel_id BIGINT NOT NULL,
    amenity_id BIGINT NOT NULL,
    base_price DECIMAL(12,2) NOT NULL,
    unit_id BIGINT NOT NULL,     -- FK sang price_units

    CONSTRAINT fk_hes_hotel
        FOREIGN KEY (hotel_id) REFERENCES hotels(id),

    CONSTRAINT fk_hes_amenity
        FOREIGN KEY (amenity_id) REFERENCES amenities(id),

    CONSTRAINT fk_hes_unit
        FOREIGN KEY (unit_id) REFERENCES price_units(id),

    UNIQUE KEY ux_hotel_amenity (hotel_id, amenity_id)
);

INSERT INTO hotel_extra_services (hotel_id, amenity_id, base_price, unit_id) VALUES
/* ================= HOTEL 1 (3★) ================= */
(1,26,120000,1),
(1,27,450000,4),
(1,28,80000,4),
(1,29,250000,4),
(1,30,900000,2),
(1,31,150000,3),
(1,32,250000,3),
(1,35,300000,5),

/* ================= HOTEL 2 (4★) ================= */
(2,26,150000,1),
(2,27,650000,4),
(2,28,100000,4),
(2,29,300000,4),
(2,30,1200000,2),
(2,31,200000,3),
(2,32,350000,3),
(2,35,500000,5),

/* ================= HOTEL 3 (4★) ================= */
(3,26,140000,1),
(3,27,600000,4),
(3,28,90000,4),
(3,29,280000,4),
(3,30,1100000,2),
(3,31,180000,3),
(3,32,320000,3),
(3,35,450000,5),

/* ================= HOTEL 4 (4★) ================= */
(4,26,150000,1),
(4,27,700000,4),
(4,28,100000,4),
(4,29,300000,4),
(4,30,1300000,2),
(4,31,200000,3),
(4,32,350000,3),
(4,35,550000,5),

/* ================= HOTEL 5 (5★) ================= */
(5,26,200000,1),
(5,27,1200000,4),
(5,28,150000,4),
(5,29,450000,4),
(5,30,2000000,2),
(5,31,300000,3),
(5,32,500000,3),
(5,33,2500000,4),
(5,34,3000000,5),
(5,35,900000,5),

/* ================= HOTEL 6 (5★) ================= */
(6,26,220000,1),
(6,27,1300000,4),
(6,28,160000,4),
(6,29,500000,4),
(6,30,2200000,2),
(6,31,320000,3),
(6,32,550000,3),
(6,33,2800000,4),
(6,34,3500000,5),
(6,35,1000000,5),

/* ================= HOTEL 7 (5★) ================= */
(7,26,250000,1),
(7,27,1500000,4),
(7,28,180000,4),
(7,29,600000,4),
(7,30,2500000,2),
(7,31,350000,3),
(7,32,600000,3),
(7,33,3000000,4),
(7,34,4000000,5),
(7,35,1200000,5),

/* ================= HOTEL 8 (4★) ================= */
(8,26,160000,1),
(8,27,750000,4),
(8,28,110000,4),
(8,29,320000,4),
(8,30,1400000,2),
(8,31,220000,3),
(8,32,370000,3),
(8,35,600000,5),

/* ================= HOTEL 9 (3★) ================= */
(9,26,110000,1),
(9,27,400000,4),
(9,28,70000,4),
(9,29,230000,4),
(9,30,850000,2),
(9,31,130000,3),
(9,32,220000,3),
(9,35,250000,5),

/* ================= HOTEL 10 (4★) ================= */
(10,26,150000,1),
(10,27,700000,4),
(10,28,100000,4),
(10,29,300000,4),
(10,30,1350000,2),
(10,31,200000,3),
(10,32,350000,3),
(10,35,550000,5);

/* =========================
   ROOM TYPE AMENITIES
   ========================= */
CREATE TABLE room_type_amenities (
    room_type_id BIGINT NOT NULL,
    amenity_id BIGINT NOT NULL,
    PRIMARY KEY (room_type_id, amenity_id),
    CONSTRAINT fk_rta_room_type
        FOREIGN KEY (room_type_id) REFERENCES room_types(id),
    CONSTRAINT fk_rta_amenity
        FOREIGN KEY (amenity_id) REFERENCES amenities(id)
);

INSERT INTO room_type_amenities (room_type_id, amenity_id) VALUES
/* ================= (STANDARD) ================= */
/* 1,5,7,9,23,28 */
(1,2),(1,4),(1,5),(1,11),(1,13),(1,15),
(5,2),(5,4),(5,5),(5,11),(5,13),(5,15),
(7,2),(7,4),(7,5),(7,11),(7,13),(7,15),
(9,2),(9,4),(9,5),(9,11),(9,13),(9,15),
(23,2),(23,4),(23,5),(23,11),(23,13),(23,15),
(28,2),(28,4),(28,5),(28,11),(28,13),(28,15),

/* ================= SUPERIOR ================= */
/* 2,6,8,10,14 */
(2,2),(2,4),(2,5),(2,6),(2,11),(2,12),(2,13),(2,15),
(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,11),(6,12),(6,13),(6,15),
(8,2),(8,4),(8,5),(8,6),(8,11),(8,12),(8,13),(8,15),
(10,3),(10,4),(10,5),(10,6),(10,7),(10,9),(10,11),(10,12),(10,13),(10,15),
(14,3),(14,4),(14,5),(14,6),(14,7),(14,9),(14,11),(14,12),(14,13),(14,15),

/* ================= DELUXE ================= */
/* 3,11,15,17,19,24,29 */
(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,10),(3,11),(3,12),(3,13),(3,15),
(11,2),(11,4),(11,5),(11,6),(11,7),(11,9),(11,11),(11,12),(11,13),(11,15),
(15,3),(15,4),(15,5),(15,6),(15,7),(15,9),(15,10),(15,11),(15,12),(15,13),(15,15),
(17,3),(17,4),(17,5),(17,6),(17,7),(17,10),(17,11),(17,12),(17,13),(17,15),
(19,3),(19,4),(19,5),(19,6),(19,7),(19,10),(19,11),(19,12),(19,13),(19,15),
(24,3),(24,4),(24,5),(24,6),(24,7),(24,8),(24,10),(24,11),(24,12),(24,13),(24,15),
(29,3),(29,4),(29,5),(29,6),(29,7),(29,11),(29,12),(29,13),(29,15),

/* ================= SUITE ================= */
/* 4,12,16,18,20,25,30 */
(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,10),(4,11),(4,12),(4,13),(4,14),(4,15),
(12,3),(12,4),(12,5),(12,6),(12,7),(12,9),(12,10),(12,11),(12,12),(12,13),(12,14),(12,15),
(16,3),(16,4),(16,5),(16,6),(16,7),(16,9),(16,10),(16,11),(16,12),(16,13),(16,14),(16,15),
(18,3),(18,4),(18,5),(18,6),(18,7),(18,10),(18,11),(18,12),(18,13),(18,14),(18,15),
(20,3),(20,4),(20,5),(20,6),(20,7),(20,10),(20,11),(20,12),(20,13),(20,14),(20,15),
(25,3),(25,4),(25,5),(25,6),(25,7),(25,10),(25,11),(25,12),(25,13),(25,14),(25,15),
(30,3),(30,4),(30,5),(30,6),(30,7),(30,10),(30,11),(30,12),(30,13),(30,14),(30,15),

/* ================= FAMILY ================= */
/* 13,26,31 */
(13,1),(13,2),(13,4),(13,5),(13,7),(13,9),(13,11),(13,13),(13,15),
(26,1),(26,2),(26,4),(26,5),(26,7),(26,10),(26,11),(26,13),(26,15),
(31,1),(31,2),(31,4),(31,5),(31,7),(31,11),(31,13),(31,15),

/* ================= VILLA ================= */
/* 21,22,27 */
(21,3),(21,4),(21,5),(21,6),(21,7),(21,10),(21,11),(21,12),(21,13),(21,14),(21,15),
(22,3),(22,4),(22,5),(22,6),(22,7),(22,10),(22,11),(22,12),(22,13),(22,14),(22,15),
(27,3),(27,4),(27,5),(27,6),(27,7),(27,8),(27,10),(27,11),(27,12),(27,13),(27,14),(27,15);

/* =========================
   HOTEL_AMENITIES
   ========================= */
CREATE TABLE hotel_amenities (
    hotel_id BIGINT NOT NULL,
    amenity_id BIGINT NOT NULL,
    PRIMARY KEY (hotel_id, amenity_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(id)
);

INSERT INTO hotel_amenities (hotel_id, amenity_id) VALUES
/* ================= HOTEL 1 (3★) ================= */
(1,16),(1,17),(1,21),(1,22),(1,23),

/* ================= HOTEL 2 (4★) ================= */
(2,16),(2,17),(2,19),(2,20),(2,21),(2,22),(2,23),(2,24),

/* ================= HOTEL 3 (4★ - trung tâm, không parking) ================= */
(3,16),(3,19),(3,20),(3,21),(3,22),(3,23),(3,24),

/* ================= HOTEL 4 (4★) ================= */
(4,16),(4,17),(4,19),(4,20),(4,21),(4,22),(4,23),(4,24),

/* ================= HOTEL 5 (5★) ================= */
(5,16),(5,17),(5,18),(5,19),(5,20),(5,21),(5,22),(5,23),(5,24),(5,25),

/* ================= HOTEL 6 (5★) ================= */
(6,16),(6,17),(6,18),(6,19),(6,20),(6,21),(6,22),(6,23),(6,24),(6,25),

/* ================= HOTEL 7 (5★) ================= */
(7,16),(7,17),(7,18),(7,19),(7,20),(7,21),(7,22),(7,23),(7,24),(7,25),

/* ================= HOTEL 8 (4★) ================= */
(8,16),(8,17),(8,19),(8,20),(8,21),(8,22),(8,23),(8,24),

/* ================= HOTEL 9 (3★ - trung tâm, không parking) ================= */
(9,16),(9,21),(9,22),(9,23),

/* ================= HOTEL 10 (4★) ================= */
(10,16),(10,17),(10,19),(10,20),(10,21),(10,22),(10,23),(10,24);

/* =========================
   BOOKINGS
   ========================= */
CREATE TABLE bookings (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    booking_code VARCHAR(50) UNIQUE NOT NULL,
    user_id BIGINT NOT NULL,
    hotel_id BIGINT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(12,2),
	status ENUM(
			'PENDING',
			'CONFIRMED',
			'CANCELLED',
			'CHECKED_IN',
			'CHECKED_OUT'
		) DEFAULT 'PENDING',
    expired_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_booking_hotel
        FOREIGN KEY (hotel_id) REFERENCES hotels(id)
);

/* =========================
   BOOKING ROOMS
   ========================= */
CREATE TABLE booking_rooms (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    booking_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    price_per_night DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_br_booking
        FOREIGN KEY (booking_id) REFERENCES bookings(id),
    CONSTRAINT fk_br_room
        FOREIGN KEY (room_id) REFERENCES rooms(id)
);

/* =========================
   BOOKING ROOM SERVICES
   ========================= */
CREATE TABLE booking_room_services (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    booking_room_id BIGINT NOT NULL,
    amenity_id BIGINT NOT NULL,

    unit_id BIGINT NOT NULL,          -- snapshot unit
    unit_price DECIMAL(12,2) NOT NULL, -- snapshot giá tại thời điểm đặt
    quantity INT NOT NULL DEFAULT 1,

    total_price DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_brs_booking_room
        FOREIGN KEY (booking_room_id) REFERENCES booking_rooms(id),

    CONSTRAINT fk_brs_amenity
        FOREIGN KEY (amenity_id) REFERENCES amenities(id),

    CONSTRAINT fk_brs_unit
        FOREIGN KEY (unit_id) REFERENCES price_units(id)
);

/* =========================
   PROMOTIONS
   ========================= */
CREATE TABLE promotions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255),
    discount_type ENUM('PERCENT', 'FIXED'),
    discount_value DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO promotions (name, discount_type, discount_value, start_date, end_date, is_active) VALUES
('Ưu đãi Tết Dương Lịch 2026', 'PERCENT', 15.00, '2026-01-01', '2026-01-15', TRUE),

('Khuyến mãi Tết Nguyên Đán 2026', 'PERCENT', 20.00, '2026-02-01', '2026-02-20', TRUE),

('Lì Xì Đầu Năm', 'FIXED', 300000.00, '2026-02-01', '2026-02-28', TRUE),

('Chào Xuân 2026', 'PERCENT', 12.00, '2026-03-01', '2026-03-31', TRUE),

('Ưu đãi Giỗ Tổ Hùng Vương', 'PERCENT', 10.00, '2026-04-01', '2026-04-15', TRUE),

('Khuyến mãi 30/4 - 1/5', 'PERCENT', 18.00, '2026-04-25', '2026-05-05', TRUE),

('Mùa Du Lịch Hè Sớm', 'PERCENT', 15.00, '2026-05-15', '2026-06-15', TRUE),

('Combo Nghỉ Dưỡng Gia Đình', 'FIXED', 500000.00, '2026-06-01', '2026-06-30', TRUE),

('Siêu Sale Mùa Hè 2026', 'PERCENT', 25.00, '2026-07-01', '2026-07-31', TRUE),

('Ưu đãi Quốc Khánh 2/9', 'PERCENT', 20.00, '2026-08-25', '2026-09-05', TRUE),

('Khuyến mãi Mùa Thấp Điểm', 'PERCENT', 12.00, '2026-09-10', '2026-09-30', TRUE),

('Giảm Giá Phòng Suite Cao Cấp', 'FIXED', 800000.00, '2026-07-15', '2026-09-15', TRUE),

('Ưu đãi 20/10', 'PERCENT', 15.00, '2026-10-15', '2026-10-25', TRUE),

('Black Friday 2026', 'PERCENT', 35.00, '2026-11-20', '2026-11-30', TRUE),

('Cyber Monday 2026', 'PERCENT', 30.00, '2026-11-30', '2026-12-05', TRUE),

('Giáng Sinh 2026', 'PERCENT', 22.00, '2026-12-20', '2026-12-26', TRUE),

('Đón Năm Mới 2027', 'PERCENT', 25.00, '2026-12-27', '2026-12-31', TRUE);

/* =========================
   ROOM TYPE PROMOTIONS
   ========================= */
CREATE TABLE room_type_promotions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_type_id BIGINT NOT NULL,
    promotion_id BIGINT NOT NULL,

    CONSTRAINT fk_rtp_room_type
        FOREIGN KEY (room_type_id) REFERENCES room_types(id),

    CONSTRAINT fk_rtp_promotion
        FOREIGN KEY (promotion_id) REFERENCES promotions(id),

    UNIQUE (room_type_id, promotion_id)
);

INSERT INTO room_type_promotions (room_type_id, promotion_id) VALUES
/* ===== TẾT DƯƠNG LỊCH (1) – ALL ===== */
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),
(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),
(17,1),(18,1),(19,1),(20,1),(23,1),(24,1),(25,1),
(28,1),(29,1),(30,1),(31,1),

/* ===== TẾT NGUYÊN ĐÁN (2) – ALL TRỪ VILLA ===== */
(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),
(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),
(17,2),(18,2),(19,2),(20,2),(23,2),(24,2),(25,2),
(28,2),(29,2),(30,2),(31,2),

/* ===== LÌ XÌ (3) – STANDARD + SUPERIOR ===== */
(1,3),(2,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),
(14,3),(23,3),(28,3),

/* ===== CHÀO XUÂN (4) – STANDARD + DELUXE ===== */
(1,4),(3,4),(5,4),(7,4),(9,4),(11,4),(15,4),
(17,4),(19,4),(24,4),(29,4),

/* ===== 30/4 - 1/5 (6) – ALL TRỪ SUITE ===== */
(1,6),(2,6),(3,6),(5,6),(6,6),(7,6),(8,6),
(9,6),(10,6),(11,6),(14,6),(15,6),(17,6),
(19,6),(23,6),(24,6),(29,6),(31,6),

/* ===== COMBO GIA ĐÌNH (8) – FAMILY ===== */
(13,8),(26,8),(31,8),

/* ===== SIÊU SALE HÈ (9) – ALL ===== */
(1,9),(2,9),(3,9),(4,9),(5,9),(6,9),(7,9),(8,9),
(9,9),(10,9),(11,9),(12,9),(13,9),(14,9),(15,9),(16,9),
(17,9),(18,9),(19,9),(20,9),(21,9),(22,9),(23,9),(24,9),
(25,9),(26,9),(27,9),(28,9),(29,9),(30,9),(31,9),

/* ===== QUỐC KHÁNH 2/9 (10) ===== */
(1,10),(2,10),(3,10),(4,10),(5,10),(6,10),(7,10),
(8,10),(9,10),(10,10),(11,10),(12,10),(13,10),
(23,10),(24,10),(25,10),(29,10),(30,10),(31,10),

/* ===== MÙA THẤP ĐIỂM (11) – STANDARD + DELUXE ===== */
(1,11),(3,11),(5,11),(7,11),(9,11),(11,11),
(15,11),(17,11),(19,11),(24,11),(29,11),

/* ===== GIẢM SUITE CAO CẤP (12) – SUITE ONLY ===== */
(4,12),(12,12),(16,12),(18,12),(20,12),(25,12),(30,12),

/* ===== BLACK FRIDAY (14) – ALL ===== */
(1,14),(2,14),(3,14),(4,14),(5,14),(6,14),(7,14),(8,14),
(9,14),(10,14),(11,14),(12,14),(13,14),(14,14),(15,14),
(16,14),(17,14),(18,14),(19,14),(20,14),(21,14),(22,14),
(23,14),(24,14),(25,14),(26,14),(27,14),(28,14),
(29,14),(30,14),(31,14),

/* ===== CYBER MONDAY (15) – ALL ===== */
(1,15),(2,15),(3,15),(4,15),(5,15),(6,15),(7,15),(8,15),
(9,15),(10,15),(11,15),(12,15),(13,15),(14,15),(15,15),
(16,15),(17,15),(18,15),(19,15),(20,15),(21,15),(22,15),
(23,15),(24,15),(25,15),(26,15),(27,15),(28,15),
(29,15),(30,15),(31,15),

/* ===== GIÁNG SINH (16) ===== */
(1,16),(2,16),(3,16),(4,16),(5,16),(6,16),(7,16),
(8,16),(9,16),(10,16),(11,16),(12,16),
(23,16),(24,16),(25,16),(29,16),(30,16),

/* ===== ĐÓN NĂM MỚI (17) – ALL ===== */
(1,17),(2,17),(3,17),(4,17),(5,17),(6,17),(7,17),(8,17),
(9,17),(10,17),(11,17),(12,17),(13,17),(14,17),(15,17),
(16,17),(17,17),(18,17),(19,17),(20,17),(21,17),(22,17),
(23,17),(24,17),(25,17),(26,17),(27,17),(28,17),
(29,17),(30,17),(31,17);

/* =========================
   AMENITY PROMOTIONS
   ========================= */
CREATE TABLE amenity_promotions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    amenity_id BIGINT NOT NULL,
    promotion_id BIGINT NOT NULL,

    CONSTRAINT fk_ap_amenity
        FOREIGN KEY (amenity_id) REFERENCES amenities(id),

    CONSTRAINT fk_ap_promotion
        FOREIGN KEY (promotion_id) REFERENCES promotions(id),

    UNIQUE (amenity_id, promotion_id)
);

INSERT INTO amenity_promotions (amenity_id, promotion_id) VALUES
/* ===== TẾT DƯƠNG LỊCH ===== */
(26, 1),
(27, 1),

/* ===== TẾT NGUYÊN ĐÁN ===== */
(26, 2),
(28, 2),
(29, 2),

/* ===== LÌ XÌ ĐẦU NĂM ===== */
(30, 3),
(31, 3),

/* ===== CHÀO XUÂN ===== */
(26, 4),
(32, 4),

/* ===== GIỖ TỔ ===== */
(27, 5),
(33, 5),

/* ===== 30/4 - 1/5 ===== */
(28, 6),
(29, 6),
(34, 6),

/* ===== MÙA HÈ SỚM ===== */
(26, 7),
(30, 7),
(35, 7),

/* ===== COMBO GIA ĐÌNH ===== */
(31, 8),
(32, 8),

/* ===== SIÊU SALE HÈ ===== */
(26, 9),
(27, 9),
(28, 9),
(29, 9),
(30, 9),

/* ===== QUỐC KHÁNH 2/9 ===== */
(33, 10),
(34, 10),

/* ===== MÙA THẤP ĐIỂM ===== */
(32, 11),
(35, 11),

/* ===== SUITE CAO CẤP ===== */
(30, 12),
(31, 12),

/* ===== 20/10 ===== */
(26, 13),
(31, 13),

/* ===== BLACK FRIDAY ===== */
(26, 14),
(27, 14),
(28, 14),
(29, 14),
(30, 14),
(31, 14),
(32, 14),
(33, 14),
(34, 14),
(35, 14),

/* ===== CYBER MONDAY ===== */
(26, 15),
(27, 15),
(28, 15),

/* ===== GIÁNG SINH ===== */
(34, 16),
(35, 16),

/* ===== ĐÓN NĂM MỚI ===== */
(26, 17),
(29, 17),
(35, 17);

/* =========================
   REVIEWS
   ========================= */
CREATE TABLE reviews (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    hotel_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    rating INT NOT NULL,
	image_url VARCHAR(500),
    `comment` TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_hotel
        FOREIGN KEY (hotel_id) REFERENCES hotels(id),
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT unique_review UNIQUE (hotel_id, user_id)
);

/* =========================
   INDEXES (search optimization)
   ========================= */
CREATE INDEX idx_hotel_city ON hotels(city);
CREATE INDEX idx_booking_date ON bookings(check_in_date, check_out_date);
