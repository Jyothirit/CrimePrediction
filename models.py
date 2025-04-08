from django.db import models

# Create your models here.

class Login(models.Model):
    login_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=255, null=False)
    password = models.CharField(max_length=255, null=False)
    user_type = models.CharField(max_length=50, null=False)
    status = models.CharField(max_length=50, null=False)

    class Meta:
        db_table = 'tbl_login'

class UserInfo(models.Model):
    user_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255, null=False)
    phone_number = models.CharField(max_length=20, null=False)
    email_id = models.EmailField(max_length=254, null=False)
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    dob=models.DateField(null=True, blank=True)
    address=models.TextField(null=True, blank=True)
    latitude = models.DecimalField(max_digits=18, decimal_places=15, blank=True, null=True)
    longitude = models.DecimalField(max_digits=18, decimal_places=15, blank=True, null=True)
    class Meta:
        db_table = 'tbl_user'
class Category(models.Model):
    category_id=models.AutoField(primary_key=True)
    category=models.CharField(max_length=50)
    class Meta:
        db_table='tbl_category'
class State(models.Model):
    state_id=models.AutoField(primary_key=True)
    state=models.CharField(max_length=50)
    class Meta:
        db_table='tbl_state'

class District(models.Model):
    district_id=models.AutoField(primary_key=True)
    state=models.ForeignKey(State, on_delete=models.CASCADE)
    district=models.CharField(max_length=50)
    class Meta:
        db_table='tbl_district'

class PoliceStation(models.Model):
    police_station_id=models.AutoField(primary_key=True)
    login=models.ForeignKey(Login, on_delete=models.CASCADE)
    district= models.ForeignKey(District, on_delete=models.CASCADE)
    place=models.CharField(max_length=50, null=True)
    address=models.TextField(blank=True, null=True)
    phone_number=models.BigIntegerField(null=True)
    mail_id=models.CharField(max_length=50)
    latitude = models.DecimalField(max_digits=18, decimal_places=15, blank=True, null=True)
    longitude = models.DecimalField(max_digits=18, decimal_places=15, blank=True, null=True)

    class Meta:
        db_table='tbl_police_station'
class Crime(models.Model):
    crime_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(UserInfo, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    district = models.ForeignKey(District, on_delete=models.CASCADE, related_name='user_district')
    police_station = models.ForeignKey(PoliceStation, on_delete=models.CASCADE, null=True, blank=True)
    place = models.CharField(max_length=255)
    subject = models.CharField(max_length=255)
    complaint_text = models.TextField()
    crime_datetime = models.DateTimeField()
    supporting_document = models.FileField(null=True, blank=True)
    status = models.CharField(max_length=50, default='Pending')  # Example: Pending, Reviewed, Resolved
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'tbl_crime'

class Feedback(models.Model):
    feedback_id=models.AutoField(primary_key=True)
    feedback=models.CharField(max_length=150)
    user=models.ForeignKey(UserInfo, on_delete=models.CASCADE, null=True)
    reply=models.CharField(max_length=50, null=True)
    class Meta:
        db_table='tbl_feedback'

class CrimeRecord(models.Model):
    crime_record_id = models.AutoField(primary_key=True)
    crime=models.ForeignKey(Crime, on_delete=models.CASCADE, null=True)
    crimetime = models.DateTimeField(blank=True, null=True)
    latitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    crime_type = models.CharField(max_length=50, blank=True, null=True)
    severity = models.CharField(max_length=20, blank=True, null=True)
    police_station_jurisdiction = models.CharField(max_length=100, blank=True, null=True)
    weather = models.CharField(max_length=50, blank=True, null=True)
    population_density = models.IntegerField(blank=True, null=True)
    proximity_to_landmark = models.IntegerField(blank=True, null=True)
    time_of_day = models.CharField(max_length=20, blank=True, null=True)
    day_of_week = models.CharField(max_length=20, blank=True, null=True)
    holiday = models.CharField(max_length=20,blank=True, null=True)
    recurring_crime_location = models.CharField(max_length=30,blank=True, null=True)
    victim_age_group = models.CharField(max_length=20, blank=True, null=True)
    suspect_age_group = models.CharField(max_length=20, blank=True, null=True)
    weapon_involved = models.CharField(max_length=30,blank=True, null=True)
    arrest_made = models.CharField(max_length=30,blank=True, null=True)
    criminal_record_found = models.CharField(max_length=30,blank=True, null=True)
    number_of_victims = models.IntegerField(blank=True, null=True)
    emergency_response_time = models.IntegerField(blank=True, null=True)
    crime_recorded_by_cctv = models.CharField(max_length=30,blank=True, null=True)
    witnesses_present = models.IntegerField(blank=True, null=True)
    area_type = models.CharField(max_length=50, blank=True, null=True)
    economic_status_of_area = models.CharField(max_length=50, blank=True, null=True)
    traffic_density = models.CharField(max_length=50, blank=True, null=True)
    nearby_facilities = models.CharField(max_length=100, blank=True, null=True)
    reporting_time = models.IntegerField(blank=True, null=True)
    
    class Meta:
        db_table = "tbl_crime_record"
class CrimeHotSpot(models.Model):
    crim_hotspot_id=models.AutoField(primary_key=True)
    latitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(UserInfo, on_delete=models.CASCADE)
   
    class Meta:
        db_table='tbl_crime_hot_spot'
class CrimeHotSpotPolice(models.Model):
    crim_hotspot_id=models.AutoField(primary_key=True)
    latitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    police_station = models.ForeignKey(PoliceStation, on_delete=models.CASCADE)
   
    class Meta:
        db_table='tbl_crime_hot_spot_police'
class CrimePrediction(models.Model):
    prediction_id=models.AutoField(primary_key=True)
    latitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(UserInfo, on_delete=models.CASCADE)
    predicted_crime_type=models.CharField(max_length=100, blank=True, null=True)
    class Meta:
        db_table='tbl_prediction'
class CrimePredictionPolice(models.Model):
    prediction_id=models.AutoField(primary_key=True)
    latitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    longitude = models.DecimalField(max_digits=12, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    police_station = models.ForeignKey(PoliceStation, on_delete=models.CASCADE)
    predicted_crime_type=models.CharField(max_length=100, blank=True, null=True)
    class Meta:
        db_table='tbl_prediction_police'
class CrimeUpdates(models.Model):
    crime_updates_id = models.AutoField(primary_key=True)
    crime = models.ForeignKey(Crime, on_delete=models.CASCADE)
    crime_updates=models.TextField(null=True, blank=True)
    police_station= models.ForeignKey(PoliceStation, on_delete=models.CASCADE, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    class Meta:
        db_table = 'tbl_crime_updates'
class Culprit(models.Model):
    culprit_id = models.AutoField(primary_key=True)
    culprit_name = models.CharField(max_length=255)
    culprit_gender = models.CharField(max_length=10, choices=[('Male', 'Male'), ('Female', 'Female'), ('Other', 'Other')])
    culprit_dob = models.DateField()
    culprit_address = models.TextField()
    culprit_phone = models.CharField(max_length=15)
    crime = models.ForeignKey(Crime, on_delete=models.CASCADE)

    class Meta:
        db_table = "tbl_culprit"

