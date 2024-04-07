-- trigger to delete all corresponding PatientsAttendAppointments when a patient is deleted
CREATE TRIGGER trigger_DeletePatient
AFTER DELETE ON Patient
FOR EACH ROW
BEGIN
    DELETE FROM PatientsAttendAppointments WHERE patient = OLD.email;
END;

-- trigger to delete all corresponding Diagnose when an appointment is deleted
CREATE TRIGGER trigger_DeleteAppointment
AFTER DELETE ON Appointment
FOR EACH ROW
BEGIN
    DELETE FROM Diagnose WHERE appt = OLD.id;
END;

-- trigger to delete all corresponding DocsHaveSchedules when a doctor is deleted
CREATE TRIGGER trigger_DeleteDoctor
AFTER DELETE ON Doctor
FOR EACH ROW
BEGIN
    DELETE FROM DocsHaveSchedules WHERE doctor = OLD.email;
END;

-- trigger to delete all corresponding DoctorViewsHistory when a doctor is deleted
CREATE TRIGGER trigger_DeleteDoctor2
AFTER DELETE ON Doctor
FOR EACH ROW
BEGIN
    DELETE FROM DoctorViewsHistory WHERE doctor = OLD.email;
END;

CREATE TRIGGER check_patient_email_format
BEFORE INSERT ON Patient
FOR EACH ROW
BEGIN
  IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Invalid email format';
  END IF;
END;

CREATE TRIGGER check_doctor_email_format
BEFORE INSERT ON Doctor
FOR EACH ROW
BEGIN
  IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Invalid email format';
  END IF;
END;