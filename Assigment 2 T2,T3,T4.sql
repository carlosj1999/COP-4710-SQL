-- Task 3
SELECT e.ENumber, CONCAT(e.FName, ' ', COALESCE(e.MName, ''), ' ', e.LName) AS Employee_Name, COUNT(c.CNumber) AS NumContracts
FROM employee e
LEFT JOIN contract c ON e.ENumber = c.Executed_By AND e.EStatus = 'Active'
GROUP BY e.ENumber, Employee_Name;

SELECT e.number, c.CNumber
from employee e on contract c
where c on e = c.Executed_By and e.EStatus = 'Active'

-- Task 4
DELIMITER $$
CREATE TRIGGER update_contract_balance
BEFORE INSERT ON contract
FOR EACH ROW
BEGIN
    SET NEW.Balance = NEW.Rental_Price + COALESCE(NEW.Extra_Charge, 0) - COALESCE(NEW.Paid, 0);
END$$
DELIMITER ;

-- Task 5
DELIMITER $$
CREATE TRIGGER check_manager_job_title
BEFORE UPDATE ON office
FOR EACH ROW
BEGIN
    DECLARE manager_job_title VARCHAR(20);
    
    SELECT Job_Title INTO manager_job_title
    FROM employee
    WHERE ENumber = NEW.OManager;
    
    IF manager_job_title <> 'Office Manager' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The employee does not have the required qualifications to be a manager.';
    END IF;
END$$
DELIMITER ;