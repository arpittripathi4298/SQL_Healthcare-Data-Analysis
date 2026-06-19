use HealthData
select * from patients;
select* from diagnoses;
select * from labs;
select * from outcomes;

-- Retrieve Detailed Patient Lab History
select p.PatientID,p.Name, d.DiagnosisName, o.OutcomeName, l.TestName, l.Result, l.NormalRange
from patients p
join diagnoses d on p.DiagnosisID = d.DiagnosisID
join outcomes o on p.OutcomeID = o.OutcomeID
join labs l on p.PatientID = l.PatientID
order  by p.PatientID, l.TestName;

-- Average Lab Results By Diagnosis
select d.DiagnosisName, l.TestName, avg(l.Result) as AverageResult
from patients p
join diagnoses d on p.DiagnosisID = d.DiagnosisID
join labs l on p.PatientID = l.PatientID
group by d.DiagnosisName, l.TestName;

-- Count of Abnormal Lab Result
select p.patientID, p.Name, count(*) as AbnormalCount
from patients p
join labs l on p.patientID = l.patientID
where (l.TestName ='Blood Sugar' and l.Result > 120) or
(l.TestName = 'Cholestrol' and l.Result > 200) or
(l.TestName = 'Hemoglobin' and l.Result < 13)
group by p.patientID, p.Name
order by AbnormalCount desc;

-- Diagnoses with Highest Treatment Costs
select d.DiagnosisName, sum(p.TreatmentCost) as TotalCost
from patients p
join diagnoses d on p.DiagnosisID = d.DiagnosisID
group by d.DiagnosisName
order by TotalCost desc;

-- Patients at Risk by age and gender
select p.PatientID, p.Name, p.Age, d.DiagnosisName, o.OutcomeName
from  patients p
join diagnoses d on p.DiagnosisID = d.DiagnosisID
join outcomes o on p.outcomeID = o.OutcomeID 
where p.Age > 65 and o.outcomeName != 'Recovered';

-- Lab Trends over Time Specific Patient
select l.TestName, l.Result, p.AdmissionDate
from labs l 
join patients p on l.patientID = p.patientID 
where p.PatientID in (2,4,6,8,10,12)
order by p.admissionDate;

-- Distribution of Outcomes by Diagnosis
select d.DiagnosisName, o.OutcomeName, count(*) as OutcomeCount
from patients p
join diagnoses d on p.DiagnosisID = d.DiagnosisID 
join outcomes o on p.OutcomeID = o.OutcomeID 
group by d.DiagnosisName, o.OutcomeName
order by d.DiagnosisName, o.OutcomeName desc;