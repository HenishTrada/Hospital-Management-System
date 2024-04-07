-- Active: 1682005467425@@127.0.0.1@3306@hospital_db
CREATE PROCEDURE GetPatientAppointments(
    IN p_email VARCHAR(50)
)
BEGIN
    SELECT Appointment.id, Appointment.date, Appointment.starttime, Appointment.endtime, Appointment.status
    FROM Appointment
    INNER JOIN PatientsAttendAppointments ON Appointment.id = PatientsAttendAppointments.appt
    WHERE PatientsAttendAppointments.patient = p_email AND Appointment.date >= CURDATE()
    ORDER BY Appointment.date ASC, Appointment.starttime ASC;
END;

CREATE PROCEDURE GetDoctorAppointments(
    IN d_email VARCHAR(50)
)
BEGIN
    SELECT Appointment.id, Appointment.date, Appointment.starttime, Appointment.endtime, Appointment.status
    FROM Appointment
    INNER JOIN Diagnose ON Appointment.id = Diagnose.appt
    WHERE Diagnose.doctor = d_email AND Appointment.date >= CURDATE()
    ORDER BY Appointment.date ASC, Appointment.starttime ASC;
END

-- to see all the patoents

DELIMITER //

CREATE PROCEDURE GetDoctorPatients(IN p_email VARCHAR(50))
BEGIN
    SELECT Patient.email, Patient.name, Patient.gender, Patient.address
    FROM Patient
    INNER JOIN Diagnose ON Patient.email = Diagnose.patient
    WHERE Diagnose.doctor = p_email
    GROUP BY Patient.email;
END//

DELIMITER ;


--medical history of  a patient
DELIMITER //

CREATE PROCEDURE GetPatientHistory(IN p_email VARCHAR(50))
BEGIN
    SELECT MedicalHistory.id, MedicalHistory.date, MedicalHistory.conditions, MedicalHistory.surgeries, MedicalHistory.medication
    FROM MedicalHistory
    INNER JOIN PatientsFillHistory ON MedicalHistory.id = PatientsFillHistory.history
    WHERE PatientsFillHistory.patient = p_email
    ORDER BY MedicalHistory.date DESC;
END//

DELIMITER ;

--This procedure retrieves the schedules of a specific doctor

DELIMITER //

CREATE PROCEDURE GetDoctorSchedules(IN p_email VARCHAR(50))
BEGIN
    SELECT Schedule.id, Schedule.day, Schedule.starttime, Schedule.endtime, Schedule.breaktime
    FROM Schedule
    INNER JOIN DocsHaveSchedules ON Schedule.id = DocsHaveSchedules.sched
    WHERE DocsHaveSchedules.doctor = p_email;
END//

DELIMITER ;


