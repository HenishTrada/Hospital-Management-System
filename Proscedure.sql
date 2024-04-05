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
