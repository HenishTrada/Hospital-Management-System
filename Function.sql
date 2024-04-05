-- Function to reset PASSWORD

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION resetPassword(
  oldPassword varchar(30), 
  newPassword varchar(30), 
  userEmail varchar(50)
) RETURNS varchar(50)
BEGIN
  DECLARE currentPassword varchar(30);
  SELECT password INTO currentPassword FROM Patient WHERE email = userEmail;
  IF oldPassword = currentPassword THEN
    UPDATE Patient SET password = newPassword WHERE email = userEmail;
    RETURN 'Password successfully reset.';
  ELSE
    RETURN 'Error: Old password does not match.';
  END IF;
END$$
DELIMITER ;

-- Function to change name

DELIMITER $$
CREATE FUNCTION changeName(
  newName varchar(50), 
  userEmail varchar(50),
    oldPassword varchar(30)
) RETURNS varchar(50)
BEGIN
  DECLARE currentPassword varchar(30);
  SELECT password INTO currentPassword FROM Patient WHERE email = userEmail;
  IF oldPassword = currentPassword THEN
    UPDATE Patient SET name = newName WHERE email = userEmail;
    RETURN 'Name successfully changed.';
  ELSE
    RETURN 'Error: Password does not match.';
  END IF;
END$$
DELIMITER ;