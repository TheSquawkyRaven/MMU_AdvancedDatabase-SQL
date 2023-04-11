INSERT INTO CLIENT 
VALUES('C1001', 'Sunlight Tadika', 'Nina Choo', NULL, NULL);

INSERT INTO CLIENT 
VALUES('C1002', 'MMU', 'Sabri Yusoff', NULL, 'sabri@mmu.edu.my');

INSERT INTO EVENTMANAGER
VALUES('1008900', 'Edine Young', '012-9876543', 'young@event.com.my', 'F');
INSERT INTO EVENTMANAGER
VALUES('1007890', 'Hafiz Hasim', '013-1234567', 'hafiz@event.com.my', 'M');
INSERT INTO EVENTMANAGER
VALUES('1008989', 'Marina Sasha', '011-5656897', 'sasha@event.com.my', 'F');

INSERT INTO EQUIPMENT 
VALUES('10000', 'Sound Systems', 1500.50);
INSERT INTO EQUIPMENT
VALUES('10001', 'Camera', 500.00),
('10002', 'White Canopy', 250.00),
('10003', 'Gold Canopy', 300.00),
('10004', 'Encolsed Canopy', 400.00);

INSERT INTO EVENT 
VALUES('E001', 'Birthday Party Kids', 'Outdoor', 'Family'),
('E002', 'Birthday Party Adult', 'Outdoor', 'Family'),
('E003', 'Birthday Party Kids', 'Indoor', 'Family'),
('E004', 'Birthday Party Adult', 'Indoor', 'Family'),
('E005', 'Corporate Dinner', 'Indoor', 'Adults'),
('E006', 'Wedding Reception', 'Indoor', 'Family'),
('E007', 'Exhibition', 'Indoor', 'Public'),
('E008', 'Family Day', 'Outdoor', 'Public');

ALTER TABLE CLIENT
DROP COLUMN CLIENT_PHONE;

CREATE TABLE CONTACT(
Client_ID CHAR(5) NOT NULL,
Client_Phone VARCHAR(12)
);

ALTER TABLE CONTACT ADD CONSTRAINT Client_ID
FOREIGN KEY (Client_ID)
REFERENCES CLIENT(Client_ID);


REORG TABLE DB2ADMIN.CONTACT;

SELECT REORG_PENDING FROM SYSIBMADM.ADMINTABINFO where TABSCHEMA='DB2ADMIN' and tabname='CONTACT';
call sysproc.admin_cmd('reorg table DB2ADMIN.ENGAGEMENT');



DROP TABLE CONTACT;

INSERT INTO CONTACT 
VALUES('C1001', '011-2525253'),
('C1001', '09-83125555'),
('C1002', '012-9875858');


ALTER TABLE EQUIPMENT_USE 
ADD COLUMN START_DAY DATE;
ALTER TABLE EQUIPMENT_USE 
ADD COLUMN END_DAY DATE;




INSERT INTO EQUIPMENT_USE 
VALUES('G0001', '10000', '2015-08-31', '2015-08-31'),
('G0001', '10003', '2015-08-30', '2015-08-31'),
('G0002', '10000', '2015-09-15', '2015-09-16'),
('G0002', '10002', '2015-09-15', '2015-09-16');

ALTER TABLE ENGAGEMENT 
ALTER COLUMN EVENT_TIME
SET DATA TYPE INT;

INSERT INTO ENGAGEMENT
VALUES('G0001', '2015-06-20', 10, '2015-08-31', 3, 100, 'Hilton KL', '1008900', 'E001', 'C1001', 2500, 0),
('G0909', '2015-06-25', 20, '2015-07-17', 4, 200, 'MMU Grand Hall', '1007890', 'E005', 'C1002', 4500, 0),
('G0002', '2015-07-01', 8, '2015-09-16', 4, 500, 'MMU Melaka', '1007890', 'E008', 'C1002', 6500, 0),
('G0003', '2015-06-30', 9, '2015-12-30', 3, 100, 'Sunlight Tadika', '1008989', 'E008', 'C1001', 3500, 0);

SELECT * FROM CLIENT;
SELECT * FROM EQUIPMENT;
SELECT * FROM EVENTMANAGER;
SELECT * FROM EVENT;
SELECT * FROM EQUIPMENT_USE;
SELECT * FROM ENGAGEMENT;



/* 2 */
SELECT * FROM EVENT
WHERE EVENT_TYPE = 'Outdoor';
SELECT CONTACT_PERSON FROM CLIENT;

SELECT STAFF_NAME FROM EVENTMANAGER E
JOIN ENGAGEMENT G ON E.STAFF_ID = G.STAFF_ID
GROUP BY STAFF_NAME
HAVING COUNT(G.ENGAGEMENT_ID) > 1;

SELECT DESCRIPTION, CLIENT_NAME, EVENT_TYPE, EVENT_DATE, EVENT_TIME, LOCATION, STAFF_NAME
FROM ENGAGEMENT G
JOIN CLIENT C ON C.CLIENT_ID = G.CLIENT_ID
JOIN EVENT E ON E.EVENT_ID = G.EVENT_ID
JOIN EVENTMANAGER M ON M.STAFF_ID = G.STAFF_ID;

SELECT VARCHAR_FORMAT(DATE('2000-' || MONTH(ENGAGEMENT_DATE) || '-01'), 'Month') AS month_name, COUNT(ENGAGEMENT_ID)
FROM ENGAGEMENT
WHERE YEAR(ENGAGEMENT_DATE) = '2015'
GROUP BY VARCHAR_FORMAT(DATE('2000-' || MONTH(ENGAGEMENT_DATE) || '-01'), 'Month');



