## 📌 Objective
Clean and analyze a stress dataset to uncover patterns in employee well-being and recommend targeted health interventions.

## 🛠️ Tools
- SQL 
- Data Cleaning & Feature Engineering
- Data Analysis 
---

## 📂 Steps Taken

### 1. Data Cleaning
- Renamed confusing column names
- Updated gender labels (`M` → `Male`, `F` → `Female`)
- Fixed typos (e.g., “Stomach Age” → “Stomach Ache”)
- Removed duplicates and null entries
- Replaced missing stress scores with dataset average

### 2. Feature Engineering
- Created `Full Name` from First and Last Names
- Calculated `Age` and grouped it into age brackets
- Categorized stress duration into 3 groups (0–3, 4–6, >6 months)

---

## 📊 Key Insights

- **Severity Levels**: 40% moderate, 40% mild, 20% severe stress
- **Heart Rate Trends**: Small monthly shifts (lowest in March, highest in June)
- **Emotional Symptoms**: Anxiety & depression are most common; anger causes highest heart rate
- **Physical Symptoms**: Fatigue & back pain most common; stomach ache causes the highest heart rate
- **Stress Duration**: Severity increases with stress duration
- **High-Risk Group**: High heart rate + poor sleep mostly tied to financial, work, and family stress

---

## ✅ Recommendations

- Provide targeted support for employees with moderate/severe stress
- Monitor and address monthly heart rate fluctuations
- Focus mental health programs on anxiety, depression, and anger
- Improve work ergonomics to reduce fatigue and back pain
- Tailor wellness efforts to stress duration and source
- Prioritize high-risk individuals with poor sleep and high stress markers

---

## 📌 Conclusion
This analysis reveals strong links between emotional/physical symptoms and heart rate. Stress severity grows over time. With data-driven insights, HR teams can build focused wellness programs that truly improve employee well-being.
