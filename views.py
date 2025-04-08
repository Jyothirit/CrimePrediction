from email.message import EmailMessage
import math
import os
import smtplib
import ssl
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render
from django.conf import settings
from django.shortcuts import render,redirect
from django.shortcuts import redirect, render
from django.contrib import messages
from django.contrib.auth import authenticate
from django.contrib.auth import logout
from datetime import *
from django.utils.html import format_html
import pandas as pd
from sklearn.discriminant_analysis import StandardScaler


from crimeapp.models import *
from django.contrib.auth.models import User
from django.core.files.storage import FileSystemStorage
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import seaborn as sns
from scipy.spatial.distance import euclidean
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

import joblib
from sklearn.preprocessing import StandardScaler, label_binarize
from sklearn.metrics import classification_report, accuracy_score,confusion_matrix, roc_curve, auc
from imblearn.over_sampling import SMOTE
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.feature_selection import SelectKBest, f_classif
from sklearn.model_selection import GridSearchCV
from sklearn.svm import SVC



FIXED_FILENAME = "Detection/crime_data.csv"
# Create your views here.
def index(request):
    today = date.today()
    return render(request,'index.html',{'today':today})
def user_login(request):
     return render(request,'login.html')
def user_registration(request):
     today = date.today()
     return render(request,'user_registration.html',{'today':today})
# def user_registration(request):
  
#     return render(request,'user_registration.html',{'today':today})
def admin_logout(request):
    logout(request)
    request.session.delete()
    return redirect('user_login')
def user_logout(request):
    logout(request)
    request.session.delete()
    return redirect('user_login')
def user_action(request):
   
    username=request.POST.get("username")
    username_exists = Login.objects.filter(username=username).exists() or User.objects.filter(username=username).exists()
    data = {
    'username_exists': username_exists,
    'error': "Username Already Exists" if username_exists else ""
    }
    if(data["username_exists"]==False):
        tbl1=Login()
        username=request.POST.get("username")
        tbl1.username=request.POST.get("username")
        password=request.POST.get("password")
        tbl1.password=password
        tbl1.user_type="User"
        tbl1.status="Approved"
        tbl1.save()
        obj=Login.objects.get(username=username,password=password)

        u=UserInfo()

        u.login_id = obj.login_id
        u.name=request.POST.get("Name")
        u.phone_number =request.POST.get("phone")
        u.email_id=request.POST.get("Email")
        u.dob=request.POST.get("dob")
        u.address=request.POST.get("address")
        u.latitude = request.POST.get("latitude")
        u.longitude = request.POST.get("longitude")
        u.save()
        messages.add_message(request, messages.INFO, 'Registered successfully.')
        return redirect('user_registration')
    else:
        messages.add_message(request, messages.INFO, 'User name is already Exist. Sorry Registration Failed.')
        return redirect('user_registration')
def login_action(request):
    u=request.POST.get("username")
    p=request.POST.get("password")
    obj=authenticate(username=u,password=p)
    if obj is not None:
        if obj.is_superuser == 1:
            request.session['aname'] = u
            request.session['slogid'] = obj.id
            return redirect('admin_home')
        else:
          messages.add_message(request, messages.INFO, 'Invalid User.')
          return redirect('user_login')
    else:
        newp=p
        try:
            obj1=Login.objects.get(username=u,password=newp)

            if obj1.user_type=="User":
                if(obj1.status=="Approved"):
                    request.session['uname'] = u
                    request.session['slogid'] = obj1.login_id
                    return redirect('user_home')
                elif(obj1.status=="Not Approved"):
                  messages.add_message(request, messages.INFO, 'Waiting For Approval.')
                  return redirect('user_login')
                else:
                  messages.add_message(request, messages.INFO, 'Invalid User.')
                  return redirect('user_login')
            elif obj1.user_type=="Police Station":
                if(obj1.status=="Approved"):
                    request.session['pname'] = u
                    request.session['slogid'] = obj1.login_id
                    return redirect('police_home')
                elif(obj1.status=="Not Approved"):
                  messages.add_message(request, messages.INFO, 'Waiting For Approval.')
                  return redirect('user_login')
                else:
                  messages.add_message(request, messages.INFO, 'Invalid User.')
                  return redirect('user_login')
            else:
                 messages.add_message(request, messages.INFO, 'Invalid User.')
                 return redirect('user_login')
        except Login.DoesNotExist:
         messages.add_message(request, messages.INFO, 'Invalid User.')
         return redirect('user_login') 
def admin_home(request):
    if 'aname' in request.session:
       
        return render(request, 'Master/index.html')
    
    else:
      return redirect('user_login')
def user_home(request):
    if 'uname' in request.session:
       
        return render(request, 'User/index.html')
    
    else:
      return redirect('user_login')
def police_home(request):
    if 'pname' in request.session:
        data=get_police(request.session['slogid'])
        return render(request, 'Police/index.html',{'pdata':data})
    
    else:
      return redirect('user_login')    
def save_category(request):
    if 'aname' in request.session:
        
        tbl=Category()
        tbl.category=request.POST.get("category")
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('add_category')
    else:
        return redirect('login')
def add_category(request):
 if 'aname' in request.session:
    data=Category.objects.all()
    return render(request,'Master/category.html',{'data':data})
 else:
      return redirect('login')
def edit_category(request,id):
 if 'aname' in request.session:
    data=Category.objects.get(category_id=id)
    return render(request,'Master/edit_category.html',{'data':data})
 else:
      return redirect('login')
def shop_category_list(request):
 if 'aname' in request.session:
    data=Category.objects.all()
    return render(request,'Shop/category.html',{'data':data})
 else:
      return redirect('login')

def update_category(request,id):
 if 'aname' in request.session:
    tbl=Category.objects.get(category_id=id)
    tbl.category=request.POST.get("category")
    tbl.save()
    messages.add_message(request, messages.INFO, 'Updated successfully.')
    return redirect('add_category')
 else:
      return redirect('login')
def delete_category(request,id):
 if 'aname' in request.session:
    tbl=Category.objects.get(category_id=id)
    tbl.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('add_category')
 else:
      return redirect('login')
           
      
def users_list(request):
    if 'aname' in request.session:
     data=UserInfo.objects.all()
     return render(request,'Master/users_list.html',{'data':data})
    else:
      return redirect('user_login')
    
def add_police_station(request):
    if 'aname' in request.session:
            data=State.objects.all()
            return render(request, 'Master/add_police_station.html',{'data':data})
    else:
        return redirect('user_login')
    
def save_station(request):
    if 'aname' in request.session:
        username=request.POST.get("username")
        data = {
        'username_exists':      Login.objects.filter(username=username).exists(),
            'error':"Username Already Exist"
        }
        if(data["username_exists"]==False):
            username=request.POST.get("username")
            password=request.POST.get("password")
            tbl1=Login()
            tbl1.username=username
            tbl1.password=password
            tbl1.user_type="Police Station"
            tbl1.status="Approved"
            tbl1.save()
        
            obj=Login.objects.get(username=username,password=password)

            tbl=PoliceStation()
            tbl.login_id = obj.login_id

            tbl.district_id=request.POST.get("district")
            tbl.place=request.POST.get("place")
            tbl.address=request.POST.get("address")
            tbl.phone_number=request.POST.get("phone")
            tbl.mail_id=request.POST.get("mail_id")
            tbl.longitude=request.POST.get("longitude")
            tbl.latitude=request.POST.get("latitude")
            tbl.save()
            messages.add_message(request, messages.INFO, 'Added successfully.')
            return redirect('add_police_station')
        else:
            messages.add_message(request, messages.INFO, 'User name is already Exist. Sorry Registration Failed.')
            return redirect('add_police_station')
    else:
        return redirect('user_login')
def display_district(request):
    state_id = request.GET.get("state_id")
    try:

        dist = District.objects.filter(state_id = state_id)
    except Exception:
        data=[]
        data['error_message'] = 'error'
        return JsonResponse(data)
    return JsonResponse(list(dist.values('district_id', 'district')), safe = False)

def list_police_station(request):
    if 'aname' in request.session:
            data=PoliceStation.objects.all()
            return render(request, 'Master/list_police_station.html',{'data':data})
    else:
        return redirect('user_login')
def edit_police_station(request,id):
    if 'aname' in request.session:
            data=PoliceStation.objects.get(police_station_id=id)
            return render(request, 'Master/edit_police_station.html',{'data':data})
    else:
        return redirect('user_login')
def update_police_station(request,id):
    if 'aname' in request.session:

       


        tbl=PoliceStation.objects.get(police_station_id=id)
    
        tbl.place=request.POST.get("place")
        tbl.address=request.POST.get("address")
        tbl.phone_number=request.POST.get("phone")
        tbl.mail_id=request.POST.get("mail_id")
        tbl.save()
        messages.add_message(request, messages.INFO, 'Updated successfully.')
        return redirect('list_police_station')
    else:
        return redirect('user_login')
def delete_police_station(request,id):
 if 'aname' in request.session:
        police_station =PoliceStation.objects.get(police_station_id=id)
        login = police_station.login
        police_station.delete()              
        login.delete()
        messages.add_message(request, messages.INFO, 'Deleted successfully.')
        return redirect('list_police_station')
 else:
      return redirect('login')

def add_complaints(request):
    if 'uname' in request.session:
            crime = Category.objects.all() 
            state = State.objects.all() 
            current_datetime = datetime.now()
            context = {'crime_types': crime,'state':state,'current_datetime': current_datetime}
            return render(request, 'User/add_complaints.html',context)
    else:
        return redirect('user_login')
def submit_complaint(request):
    if 'uname' in request.session:
                        
                user=get_user(request.session['slogid'])
                category_id = request.POST.get('crimeType')
                district_id = request.POST.get('district')
                police_station_id = request.POST.get('police_station')
                place = request.POST.get('place')
                subject = request.POST.get('subject')
                complaint_text = request.POST.get('complaintText')
                crime_datetime = request.POST.get('crimeDatetime')
           

                # Fetch related objects
                category = Category.objects.get(category_id=category_id)
                district = District.objects.get(district_id=district_id)
                police_station = PoliceStation.objects.filter(police_station_id=police_station_id).first()

                document=request.FILES['document']

                split_tup = os.path.splitext(document.name)
                file_extension = split_tup[1]
                # folder path
                dir_path = settings.MEDIA_ROOT
                count = 0
                # Iterate directory
                for path in os.listdir(dir_path):
                # check if current path is a file
                    if os.path.isfile(os.path.join(dir_path, path)):
                        count += 1
                filecount=count+1
                filename=str(filecount)+file_extension
                obj=FileSystemStorage()
                file=obj.save(filename,document)
                url1=obj.url(file)
                # Save the complaint
                complaint = Crime.objects.create(
                    user=user,
                    category=category,
                    district=district,
                    police_station=police_station,
                    place=place,
                    subject=subject,
                    complaint_text=complaint_text,
                    crime_datetime=crime_datetime,
                    supporting_document=url1,
                    
                )
                
                # Redirect or send a success response
                messages.add_message(request, messages.INFO, 'Added successfully.')
                return redirect('add_complaints')
    else:
        return redirect('user_login')
def display_police_station(request):
    district_id = request.GET.get("district_id")
    try:

        dist = PoliceStation.objects.filter(district_id = district_id)
    except Exception:
        data=[]
        data['error_message'] = 'error'
        return JsonResponse(data)
    return JsonResponse(list(dist.values('police_station_id', 'place')), safe = False)
def view_complaints(request):
    if 'uname' in request.session:
            user=get_user(request.session['slogid'])
            crime=Crime.objects.filter(user=user)
            context = {'crime': crime,}
            return render(request, 'User/view_complaints.html',context)
    else:
        return redirect('user_login')
def crime_more(request,id):
    if 'uname' in request.session:
     
            crime=Crime.objects.get(pk=id)
            culprit=Culprit.objects.filter(crime_id=id)
            updates=CrimeUpdates.objects.filter(crime_id=id)
            context = {'crime': crime,'culprit':culprit,'updates':updates}
            return render(request, 'User/crime_more.html',context)
    else:
        return redirect('user_login')
    

# ------------- Feedback ------------------------------------------


def feedback(request):
    if 'uname' in request.session:
        user=get_user(request.session['slogid'])
        data1 = Feedback.objects.filter(user=user)
        return render(request,'User/feedback.html',{'data1':data1})
    else:
       return redirect('user_login')
def save_feedback(request):
    if 'uname' in request.session:
        tbl=Feedback()
    
        tbl.user=UserInfo.objects.get(user_id=get_user(request.session['slogid']).user_id)
        # tbl.feedback_subject=request.POST.get("subject")
        tbl.feedback=request.POST.get("feedback")
        tbl.save()
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('feedback')
    else:
       return redirect('user_login')

def delete_feedback(request,id):
    if 'pname' in request.session:
        tbl=Feedback.objects.get(feedback_id=id)
        tbl.delete()
        messages.add_message(request, messages.INFO, 'Deleted successfully.')
        return redirect('feedback')
    else:
       return redirect('user_login')
    
def view_feedback(request):
    if 'aname' in request.session:
        
        data= Feedback.objects.filter(reply__isnull=True)
        return render(request,'Master/view_feedback.html',{'data':data})
    else:
       return redirect('user_login')
def feedback_replied_list(request):
    if 'aname' in request.session:
        data= Feedback.objects.filter(reply__isnull=False)
        return render(request,'Master/replied_feedback.html',{'data':data})
    else:
       return redirect('user_login')
def adm_reply_feedback(request,id):
    if 'aname' in request.session:

        return render(request,'Master/reply_feedback.html',{'id':id})
    else:
       return redirect('user_login')
def add_reply_feedback(request,id):
    tbl=Feedback.objects.get(feedback_id=id)
    tbl.reply=request.POST.get("reply")
    tbl.save()
    return redirect('feedback_replied_list')

def profile(request):
    if 'uname' in request.session:
        data=get_user(request.session['slogid'])
       
        return render(request,'User/profile.html',{'data':data})
    else:
       return redirect('user_login')
    # ----------------End Feedback -------------------------------------------------


    # --------Admin Crime ---------
    
def adm_crime_list(request):
    if 'aname' in request.session:
           
            crime=Crime.objects.all()
            context = {'crime': crime,}
            return render(request, 'Master/view_crime.html',context)
    else:
        return redirect('user_login')
def adm_crime_more(request,id):
    if 'aname' in request.session:
     
            crime=Crime.objects.get(pk=id)
            culprit=Culprit.objects.filter(crime_id=id)
            updates=CrimeUpdates.objects.filter(crime_id=id)
            context = {'crime': crime,'culprit':culprit,'updates':updates}
            return render(request, 'Master/crime_more.html',context)
    else:
        return redirect('user_login')
     # --------Admin Crime ---------
def plc_crime_list(request):
    if 'pname' in request.session:
           
            plc=get_police(request.session['slogid'])
            crime=Crime.objects.filter(police_station_id=plc.police_station_id).select_related('police_station')
            context = {'crime': crime,}
            return render(request, 'Police/view_crime.html',context)
    else:
        return redirect('user_login')
def plc_crime_more(request,id):
    if 'pname' in request.session:
     
            crime=Crime.objects.get(pk=id)
            crime_report=CrimeRecord.objects.filter(crime_id=id)
            context = {'crime': crime,'crime_report':crime_report}
            return render(request, 'Police/crime_more.html',context)
    else:
        return redirect('user_login')
def plc_final_report(request,id):
    if 'pname' in request.session:
     
            data=Crime.objects.get(pk=id)
            crime = Category.objects.all() 
          
            current_datetime = datetime.now()
            context = {'crime_types': crime,'current_datetime': current_datetime,'data': data}
          
            return render(request, 'Police/plc_final_report.html',context)
    else:
        return redirect('user_login')    
def save_final_report(request,id):
    if 'pname' in request.session:
        data=Crime.objects.get(pk=id)
        crime_id = id
        crimetime = request.POST.get("crimetime")  # Assuming format 'YYYY-MM-DD HH:MM:SS'
        if crimetime:
            crime_datetime =  datetime.strptime(crimetime, "%Y-%m-%dT%H:%M")

            # Extract day of the week (Monday, Tuesday, etc.)
            day_of_week = crime_datetime.strftime("%A")

            # Extract time of day (Morning or Evening)
            hour = crime_datetime.hour
            if 5 <= hour < 12:
                time_of_day = "Morning"
            elif 12 <= hour < 17:
                time_of_day = "Afternoon"
            elif 17 <= hour < 21:
                time_of_day = "Evening"
            else:
                time_of_day = "Night"
        police_station_jurisdiction=data.place
        crime_type = request.POST.get("crimeType")
        severity = request.POST.get("severity")
        weather = request.POST.get("weather")

        population_density = request.POST.get("populationDensity")
        proximity_landmark = request.POST.get("proximityLandmark")
        
        holiday = request.POST.get("holiday")
        recurring_location = request.POST.get("recurringLocation")
        victim_age_group = request.POST.get("victimAgeGroup")
        suspect_age_group = request.POST.get("suspectAgeGroup")
        weapon = request.POST.get("weapon")
        arrest_made = request.POST.get("arrestMade")
        criminal_record = request.POST.get("criminalRecord")
        num_victims = request.POST.get("numVictims")
        response_time = request.POST.get("responseTime")
        cctv = request.POST.get("cctv")
        witnesses = request.POST.get("witnesses")
        area_type = request.POST.get("areaType")
        economic_status = request.POST.get("economicStatus")
        traffic_density = request.POST.get("trafficDensity")
        nearby_facilities = request.POST.get("nearbyFacilities")
        reporting_time = request.POST.get("reportingTime")
        latitude = request.POST.get("latitude")
        longitude = request.POST.get("longitude")

        # Fetch the existing crime record if applicable
        crime_report = CrimeRecord()

        # Update and save the report
        crime_report.crime_id = crime_id
        crime_report.crime_type = crime_type
        crime_report.severity = severity
        crime_report.crimetime = crimetime
        crime_report.weather = weather
        crime_report.population_density = population_density
        crime_report.proximity_to_landmark = proximity_landmark
        crime_report.time_of_day = time_of_day
        crime_report.day_of_week = day_of_week
        crime_report.holiday = holiday
        crime_report.police_station_jurisdiction = police_station_jurisdiction
        crime_report.recurring_crime_location = recurring_location
        crime_report.victim_age_group = victim_age_group
        crime_report.suspect_age_group = suspect_age_group
        crime_report.weapon_involved = weapon
        crime_report.arrest_made = arrest_made
        crime_report.criminal_record_found = criminal_record
        crime_report.number_of_victims = num_victims
        crime_report.emergency_response_time = response_time
        crime_report.crime_recorded_by_cctv = cctv
        crime_report.witnesses_present = witnesses
        crime_report.area_type = area_type
        crime_report.economic_status_of_area = economic_status
        crime_report.traffic_density = traffic_density
        crime_report.nearby_facilities = nearby_facilities
        crime_report.reporting_time = reporting_time
        crime_report.latitude = latitude
        crime_report.longitude = longitude

        crime_report.save()

      
        # Redirect or send a success response
        messages.add_message(request, messages.INFO, 'Report saved successfully.')
        return redirect('plc_crime_list')
    else:
        return redirect('user_login')    


# def upload_csv_view(request):
#     if request.method == 'POST':
#         try:
#             # Get the uploaded file from the request
#             csv_file = request.FILES.get('file')

#             # Validate file type
#             if not csv_file or not csv_file.name.endswith('.csv'):
#                 messages.error(request, "Please upload a valid CSV file.")
#                 return redirect('upload-csv')

#             # Define the file path using the fixed file name
#             media_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)

#             # Required columns in the new dataset
#             required_columns = [
#                 'Crime ID', 'Date & Time', 'Latitude', 'Longitude', 'Crime Type', 'Severity', 
#                 'Police Station Jurisdiction', 'Weather', 'Population Density', 'Proximity to Landmark (meters)', 
#                 'Time of Day', 'Day of the Week', 'Holiday/Non-Holiday', 'Recurring Crime Location', 
#                 'Victim Age Group', 'Suspect Age Group', 'Weapon Involved', 'Arrest Made', 
#                 'Criminal Record Found', 'Number of Victims', 'Emergency Response Time (minutes)', 
#                 'Crime Recorded by CCTV', 'Witnesses Present', 'Area Type', 'Economic Status of Area', 
#                 'Traffic Density', 'Nearby Facilities', 'Reporting Time (minutes)'
#             ]

#             # Read the uploaded CSV file using Pandas
#             new_data = pd.read_csv(csv_file)

#             # Validate CSV structure
#             if not all(col in new_data.columns for col in required_columns):
#                 messages.error(request, "CSV is missing required columns.")
#                 return redirect('upload-csv')

#             # Check if the file already exists to append data
#             if os.path.exists(media_path):
#                 existing_data = pd.read_csv(media_path)
#                 combined_data = pd.concat([existing_data, new_data], ignore_index=True)
#                 combined_data.to_csv(media_path, index=False)
#                 messages.success(request, "New data appended to existing file.")
#             else:
#                 new_data.to_csv(media_path, index=False)
#                 messages.success(request, "New file uploaded successfully.")

#             # Display a preview (limit to first 10 rows)
#             data_preview = new_data.head(10).to_dict(orient='records')

#             return render(request, 'Master/upload_csv.html', {'data_preview': data_preview, 'csv_path': media_path})

#         except Exception as e:
#             messages.error(request, f"An error occurred: {str(e)}")
#             return redirect('upload-csv')

#     return render(request, 'Master/upload_csv.html')

def upload_csv_view(request):
    if request.method == 'POST':
        try:
            csv_file = request.FILES.get('file')

            if not csv_file or not csv_file.name.endswith('.csv'):
                messages.error(request, "Please upload a valid CSV file.")
                return redirect('upload-csv')

            media_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)

            required_columns = [
                'Crime ID', 'Date & Time', 'Latitude', 'Longitude', 'Crime Type', 'Severity',
                'Police Station Jurisdiction', 'Weather', 'Population Density', 'Proximity to Landmark (meters)',
                'Time of Day', 'Day of the Week', 'Holiday/Non-Holiday', 'Recurring Crime Location',
                'Victim Age Group', 'Suspect Age Group', 'Weapon Involved', 'Arrest Made',
                'Criminal Record Found', 'Number of Victims', 'Emergency Response Time (minutes)',
                'Crime Recorded by CCTV', 'Witnesses Present', 'Area Type', 'Economic Status of Area',
                'Traffic Density', 'Nearby Facilities', 'Reporting Time (minutes)'
            ]

            new_data = pd.read_csv(csv_file)

            if not all(col in new_data.columns for col in required_columns):
                messages.error(request, "CSV is missing required columns.")
                return redirect('upload-csv')

            if os.path.exists(media_path):
                existing_data = pd.read_csv(media_path)
                combined_data = pd.concat([existing_data, new_data], ignore_index=True)
                combined_data.to_csv(media_path, index=False)
                messages.success(request, "New data appended to existing crime data file.")
            else:
                new_data.to_csv(media_path, index=False)
                messages.success(request, "Crime data file uploaded successfully.")

            prediction_columns = [
                'Crime Type', 'Severity', 'Latitude', 'Longitude', 'Weather',
                'Population Density', 'Area Type', 'Economic Status of Area',
                'Traffic Density'
            ]

            crime_prediction_dataset = new_data[prediction_columns].copy()

            # Mapping categorical values to numerical values
            mappings = {
                  'Crime Type': {
        'Kidnapping': 1, 
        'Homicide': 2, 
        'Robbery': 3, 
        'Burglary': 4, 
        'Vandalism': 5, 
        'Assault': 6,
        'Other': 7  # Optionally, you can add a default category if any other type is present
    },
                'Severity': {'Low': 1, 'Moderate': 2, 'High': 3},
                'Weather': {'Sunny': 1, 'Cloudy': 2, 'Rainy': 3, 'Foggy': 4},
                'Area Type': {'Urban': 1, 'Suburban': 2, 'Rural': 3},
                'Economic Status of Area': {'Low': 1, 'Medium': 2, 'High': 3},
                'Traffic Density': {'Low': 1, 'Medium': 2, 'High': 3}
            }

            for column, mapping in mappings.items():
                  crime_prediction_dataset[column] = crime_prediction_dataset[column].apply(lambda x: mapping.get(x, 5 if column == 'Crime Type' else 1))

            crime_prediction_path = os.path.join(settings.MEDIA_ROOT, "Detection/crime_prediction_dataset.csv")

            if os.path.exists(crime_prediction_path):
                existing_prediction_data = pd.read_csv(crime_prediction_path)
                combined_prediction_data = pd.concat([existing_prediction_data, crime_prediction_dataset], ignore_index=True)
                combined_prediction_data.to_csv(crime_prediction_path, index=False)
                messages.success(request, "New data appended to crime prediction dataset.")
            else:
                crime_prediction_dataset.to_csv(crime_prediction_path, index=False)
                messages.success(request, "Crime prediction dataset created successfully.")

            data_preview = crime_prediction_dataset.head(10).to_dict(orient='records')

            return render(request, 'Master/upload_csv.html', {'data_preview': data_preview, 'csv_path': crime_prediction_path})

        except Exception as e:
            messages.error(request, f"An error occurred: {str(e)}")
            return redirect('upload-csv')

    return render(request, 'Master/upload_csv.html')



def detect_hotspots(request):
    csv_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)

 # Check if file exists
    if not os.path.exists(csv_path):
        return render(request, "hotspot_detection.html", {"hotspot_map": None, "hotspots": None})

    try:
        crime_data = pd.read_csv(csv_path)
    except Exception as e:
        return render(request, "hotspot_detection.html", {"error": f"Error loading CSV: {str(e)}"})

    # Ensure required columns exist
    required_columns = {"Latitude", "Longitude"}
    if not required_columns.issubset(crime_data.columns):
        return render(request, "hotspot_detection.html", {"error": "Invalid CSV format"})

    # Remove invalid lat/lon values (out of range)
    crime_data = crime_data[(crime_data["Latitude"].between(-90, 90)) & (crime_data["Longitude"].between(-180, 180))]

    # Extract relevant data
    locations = crime_data[['Latitude', 'Longitude']].dropna().copy()

    if locations.shape[0] < 5:
        return render(request, "hotspot_detection.html", {"error": "Not enough data for clustering."})

    # Apply K-Means Clustering
    kmeans = KMeans(n_clusters=5, random_state=42, n_init=10)
    locations['Cluster'] = kmeans.fit_predict(locations)

    # Get cluster centers
    cluster_centers = kmeans.cluster_centers_

    # Find nearest actual data points to each cluster center
    def find_nearest_location(center, locations_df):
        return locations_df.iloc[np.argmin(locations_df.apply(lambda row: euclidean(center, [row['Latitude'], row['Longitude']]), axis=1))]

    hotspots = []
    for i, center in enumerate(cluster_centers):
        nearest_point = find_nearest_location(center, locations)
        hotspots.append({
            "cluster_id": i,
            "latitude": round(nearest_point["Latitude"], 6),
            "longitude": round(nearest_point["Longitude"], 6),
            "density": locations[locations["Cluster"] == i].shape[0]
        })

    # Generate a heatmap visualization
    plt.figure(figsize=(8, 6))
    sns.scatterplot(x=locations["Longitude"], y=locations["Latitude"], hue=locations["Cluster"], palette="Set1", s=50)
    plt.title("Crime Hotspot Clusters")
    plt.xlabel("Longitude")
    plt.ylabel("Latitude")
    plt.legend(title="Cluster")

    # Save the generated map
    hotspot_map_path = os.path.join(settings.MEDIA_ROOT, "Detection/hotspot_map.png")
    plt.savefig(hotspot_map_path, format="png", bbox_inches="tight")
    plt.close()

    return render(request, "Master/hotspot_detection.html", {
        "hotspot_map": "hotspot_map.png",
        "hotspots": hotspots
    })

def google_map_view_spot(request, latitude, longitude):
    if 'aname' in request.session:
     
            context = {'latitude': latitude,'longitude': longitude,}
            return render(request, 'Master/google_map_view_spot.html',context)
    else:
        return redirect('user_login')
def u_google_map_view_spot(request, latitude, longitude):
    if 'uname' in request.session:
     
            context = {'latitude': latitude,'longitude': longitude,}
            return render(request, 'User/google_map_view_spot.html',context)
    else:
        return redirect('user_login')
       
    
def view_hotspot_warning(request):
    if 'uname' in request.session:
        data=get_user(request.session['slogid'])
        hotspots = CrimeHotSpot.objects.filter(user_id=data.user_id)  
        return render(request, 'User/hostspot_warning.html', {'hotspots': hotspots})
           
            
    else:
        return redirect('user_login')
def send_warning(request, latitude, longitude):
    
    # Ensure the user is logged in (adjust session check as per your auth logic)
    if 'aname' not in request.session:
        return redirect('user_login')
    
    # Convert latitude and longitude parameters to floats
    try:
        target_lat = float(latitude)
        target_lon = float(longitude)
    except (TypeError, ValueError):
        messages.error(request, "Invalid coordinates provided.")
        return redirect('some_error_page')  # or wherever you want to redirect on error

    # Define the warning message for users
    user_subject = "Warning: Nearby Hotspot Alert"
    user_html_message = format_html(
        """
        <div style="font-family: sans-serif; line-height: 1.5;">
            <h2>Hotspot Warning</h2>
            <p>You are within a 5 km perimeter of a hotspot area.</p>
            <p>Please take the necessary precautions.</p>
        </div>
        """
    )

    # Define the warning message for police stations
    police_subject = "Crime Alert Notification"
    police_html_message = format_html(
        """
        <div style="font-family: sans-serif; line-height: 1.5;">
            <h2>Crime Alert</h2>
            <p>A hotspot has been identified within 30 km of your station.</p>
            <p>Please monitor the area and take necessary actions.For  More information Login to the Website</p>
        </div>
        """
    )
    
    # Approximate conversion: 1 degree latitude ~ 111 km.
    lat_diff = 5 / 111.0  
    lon_diff = 5 / (111.0 * math.cos(math.radians(target_lat)))
    
    # Query users whose stored coordinates are not null and within the bounding box.
    nearby_users = UserInfo.objects.all()
    
    # Further filter using the precise Haversine formula
    user_recipients = []
    for user in nearby_users:
        try:
            user_lat = float(user.latitude)
            user_lon = float(user.longitude)
        except (TypeError, ValueError):
            continue  # Skip users with invalid coordinate values

        distance = haversine(target_lat, target_lon, user_lat, user_lon)
        if distance <= 5:
            user_recipients.append(user.email_id)
            obj = CrimeHotSpot()
            obj.longitude = longitude
            obj.latitude = latitude
            obj.user_id = user.user_id
            obj.save()

    # Find Police Stations Within 30 km
    police_recipients = []
    nearby_police_stations = PoliceStation.objects.all()

    for station in nearby_police_stations:
        try:
            station_lat = float(station.latitude)
            station_lon = float(station.longitude)
        except (TypeError, ValueError):
            continue  # Skip invalid coordinates

        police_distance = haversine(target_lat, target_lon, station_lat, station_lon)
        if police_distance <= 30:
            police_recipients.append(station.mail_id)
            obj = CrimeHotSpotPolice()
            obj.longitude = longitude
            obj.latitude = latitude
            obj.police_station_id = station.police_station_id
            obj.save()

    # Send emails separately for users and police
    if user_recipients:
        send_mail(user_recipients, user_html_message, user_subject)
        messages.success(request, "Warning emails have been sent to nearby users.")
    
    if police_recipients:
        send_mail(police_recipients, police_html_message, police_subject)
        messages.success(request, "Crime alert emails have been sent to nearby police stations.")

    if not (user_recipients or police_recipients):
        messages.info(request, "No users or police stations found within the specified range.")

    return render(request, 'Master/hostspot_message_success.html')


def send_mail(erc, msg, sub,cc_list=None):
    company_name="Crime Reporting Site"
    email_sender = settings.EMAIL_HOST_USER
    email_password = settings.EMAIL_HOST_PASSWORD
    email_receiver = erc
    subject = sub

    em = EmailMessage()
    em['From'] = f"{company_name} <{email_sender}>"
    em['To'] = email_receiver
    em['Subject'] = subject
    if cc_list:
        em['Cc'] = ', '.join(cc_list)
    em.set_content(msg, subtype='html')

    context = ssl.create_default_context()

    try:
        with smtplib.SMTP_SSL(settings.EMAIL_HOST, settings.EMAIL_PORT, context=context) as smtp:
            smtp.login(email_sender, email_password)
            smtp.sendmail(email_sender, email_receiver, em.as_string())
        return "Email sent successfully."
    except smtplib.SMTPException as e:
        return f"Can't send to your registered mail ID. Some error occurred: {str(e)}"

def haversine(lat1, lon1, lat2, lon2):
    """
    Calculate the distance (in km) between two points on the Earth specified in decimal degrees.
    """
    # Convert decimal degrees to radians
    lat1, lon1, lat2, lon2 = map(math.radians, [lat1, lon1, lat2, lon2])
    # Differences
    dlon = lon2 - lon1 
    dlat = lat2 - lat1 
    # Haversine formula
    a = math.sin(dlat/2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon/2)**2
    c = 2 * math.asin(math.sqrt(a)) 
    r = 6371  # Radius of Earth in kilometers
    return c * r
def display_crimes(request, latitude, longitude):
    if 'uname' in request.session:
             # Load dataset from CSV (change path accordingly)
        latitude = float(latitude)
        longitude = float(longitude)
        csv_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)
        df = pd.read_csv(csv_path)
        
# Rename columns: Replace spaces with underscores
        df.columns = df.columns.str.replace(' ', '_')
        df.columns = df.columns.str.replace('&', '_')
        df.columns = df.columns.str.replace('(minutes)', '')
        # Convert latitude & longitude columns to float
        df['Latitude'] = pd.to_numeric(df['Latitude'], errors='coerce')
        df['Longitude'] = pd.to_numeric(df['Longitude'], errors='coerce')

        # Drop rows where conversion failed (NaN values)
        df = df.dropna(subset=['Latitude', 'Longitude'])

     

        # Convert latitude & longitude columns to float
        df['Latitude'] = pd.to_numeric(df['Latitude'], errors='coerce')
        df['Longitude'] = pd.to_numeric(df['Longitude'], errors='coerce')

        # Drop rows where conversion failed (NaN values)
        df = df.dropna(subset=['Latitude', 'Longitude'])

        # Compute distances & filter crimes within 5km radius
        df['Distance'] = df.apply(lambda row: haversine(latitude, longitude, row['Latitude'], row['Longitude']), axis=1)
        nearby_crimes = df[df['Distance'] <= 5]  # Crimes within 5km

        # Convert DataFrame to list of dictionaries for template
        crimes_list = nearby_crimes.to_dict(orient='records')

        return render(request, 'User/display_crimes.html', {'crimes': crimes_list})
            
    else:
        return redirect('user_login')



def train_model_crime(request):
    if 'aname' not in request.session:
        return redirect('user_login')

    csv_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)

    if not os.path.exists(csv_path):
        messages.error(request, "No dataset file exists.")
        return render(request, 'User/success_train_msg.html')

    try:
        df = pd.read_csv(csv_path)
    except Exception as e:
        messages.error(request, f"Error reading file: {str(e)}")
        return render(request, 'User/success_train_msg.html')

    required_columns = ["Date & Time", "Cluster", "Weather", "Population Density", "Time of Day", 
                        "Day of the Week", "Holiday/Non-Holiday", "Economic Status of Area"]
    
    missing_cols = [col for col in required_columns if col not in df.columns]
    if missing_cols:
        messages.error(request, f"Missing required columns: {', '.join(missing_cols)}")
        return render(request, 'Master/success_train_msg.html')

    # Convert Date & Time to separate features
    df["Date & Time"] = pd.to_datetime(df["Date & Time"], errors='coerce')
    df["Year"] = df["Date & Time"].dt.year
    df["Month"] = df["Date & Time"].dt.month
    df["Day"] = df["Date & Time"].dt.day
    df["Hour"] = df["Date & Time"].dt.hour
    df["Minute"] = df["Date & Time"].dt.minute
    df["Weekday"] = df["Date & Time"].dt.weekday
    df.drop(columns=["Date & Time"], inplace=True)

    # Convert categorical features to numeric using one-hot encoding
    categorical_columns = ["Weather", "Time of Day", "Day of the Week", "Holiday/Non-Holiday", "Economic Status of Area"]
    df = pd.get_dummies(df, columns=categorical_columns, drop_first=True)

    # Ensure numeric data only
    df = df.select_dtypes(include=['number'])

    if "Cluster" not in df.columns:
        messages.error(request, "No numeric columns left for training.")
        return render(request, 'Master/success_train_msg.html')

    X = df.drop(columns=["Cluster"])
    y = df["Cluster"]

    X.fillna(X.median(numeric_only=True), inplace=True)

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    try:
        model = RandomForestClassifier(n_estimators=100, random_state=42)
        model.fit(X_train, y_train)
        
        # Make predictions
        y_pred = model.predict(X_test)

        # Calculate accuracy
        accuracy = accuracy_score(y_test, y_pred)

        # Generate classification report
        class_report = classification_report(y_test, y_pred, output_dict=True)

    except Exception as e:
        messages.error(request, f"Error training model: {str(e)}")
        return render(request, 'Master/success_train_msg.html')

    # Save model
    model_dir = os.path.join(settings.MEDIA_ROOT, "Detection")
    os.makedirs(model_dir, exist_ok=True)
    joblib.dump(model, os.path.join(model_dir, "crime_hotspot_model.pkl"))
    for label, metrics in class_report.items():
        if isinstance(metrics, dict):  
            metrics['f1_score'] = metrics.pop('f1-score', None)  # Avoid KeyError
    context = {
        "accuracy": accuracy,
        "classification_report": class_report
    }

    messages.success(request, "Model training complete and saved successfully!")
    return render(request, 'Master/success_train_msg.html', context)


def prediction_crime(request):
    if 'aname' in request.session:
       
        return render(request, 'Master/prediction_crime.html')
           
            
    else:
        return redirect('user_login')    

# def predict_crime(request):
#     if 'aname' in request.session:
#         context = {}
#         try:
#                 # Retrieve form inputs
#                 datetime_input = request.POST.get("datetime")
#                 population_density = float(request.POST.get("populationDensity"))
#                 weather = request.POST.get("weather")
#                 time_of_day = request.POST.get("timeOfDay")
#                 day_of_week = request.POST.get("dayOfWeek")
#                 holiday = request.POST.get("holiday")
#                 economic_status = request.POST.get("economicStatus")

#                 # Convert datetime into features
#                 dt = pd.to_datetime(datetime_input)
#                 data = {
#                     "Population Density": [population_density],
#                     "Year": [dt.year],
#                     "Month": [dt.month],
#                     "Day": [dt.day],
#                     "Hour": [dt.hour],
#                     "Minute": [dt.minute],
#                     "Weekday_Num": [dt.weekday()]
#                 }
#                 df_pred = pd.DataFrame(data)

#                 # Manually add one-hot dummy columns as used during training.
#                 # (These dummy variables must match exactly the columns created during training.)
#                 # For Weather (Assume baseline is "Cloudy")
#                 weather_dummies = {"Weather_Foggy": 0, "Weather_Rainy": 0, "Weather_Sunny": 0}
#                 if weather != "Cloudy":
#                     key = f"Weather_{weather}"
#                     if key in weather_dummies:
#                         weather_dummies[key] = 1

#                 # For Time of Day (Assume baseline is "Morning")
#                 tod_dummies = {"Time of Day_Afternoon": 0, "Time of Day_Evening": 0, "Time of Day_Night": 0}
#                 if time_of_day != "Morning":
#                     key = f"Time of Day_{time_of_day}"
#                     if key in tod_dummies:
#                         tod_dummies[key] = 1

#                 # For Day of the Week (Assume baseline is "Wednesday")
#                 dow_dummies = {"Day of the Week_Monday": 0, "Day of the Week_Tuesday": 0, 
#                             "Day of the Week_Thursday": 0, "Day of the Week_Friday": 0, 
#                             "Day of the Week_Saturday": 0, "Day of the Week_Sunday": 0}
#                 if day_of_week != "Wednesday":
#                     key = f"Day of the Week_{day_of_week}"
#                     if key in dow_dummies:
#                         dow_dummies[key] = 1

#                 # For Holiday/Non-Holiday (Assume baseline is "Non-Holiday")
#                 holiday_dummies = {"Holiday/Non-Holiday_Holiday": 0}
#                 if holiday == "Holiday":
#                     holiday_dummies["Holiday/Non-Holiday_Holiday"] = 1

#                 # For Economic Status (Assume baseline is "Low")
#                 econ_dummies = {"Economic Status of Area_Medium": 0, "Economic Status of Area_High": 0}
#                 if economic_status != "Low":
#                     key = f"Economic Status of Area_{economic_status}"
#                     if key in econ_dummies:
#                         econ_dummies[key] = 1

#                 # Combine dummy columns into the prediction DataFrame
#                 for dummy in [weather_dummies, tod_dummies, dow_dummies, holiday_dummies, econ_dummies]:
#                     for key, value in dummy.items():
#                         df_pred[key] = value

#                 # (Optional) Ensure the order of columns matches the training set.
#                 # If you saved a list of feature names during training, load and reorder accordingly.

#                 # Load the saved Random Forest model
#                 model_path = os.path.join(settings.MEDIA_ROOT, "Detection", "crime_hotspot_model.pkl")
#                 if not os.path.exists(model_path):
#                     messages.error(request, "Trained model not found.")
#                     return render(request, "Master/predict_crime_result.html")
#                 model = joblib.load(model_path)

#                 # Make prediction
#                 prediction = model.predict(df_pred)[0]

#                 context = {"prediction": prediction}
#                 return render(request, "Master/predict_crime_result.html", context)
#         except Exception as e:
#                 messages.error(request, f"Error during prediction: {str(e)}")
#                 return render(request, "Master/predict_crime_result.html")
          
#     else:
#         return redirect('user_login')




# def train_and_predict_model(request):
#     try:
#         # Load dataset
#         data = pd.read_csv('media/Detection/crime_prediction_dataset.csv')

#         # Separate features and target
#         X = data.drop(columns=['Crime Type'])  
#         y = data['Crime Type']

#         # Identify categorical and numerical columns
#         categorical_cols = ['Weather', 'Area Type', 'Economic Status of Area']  
#         numerical_cols = ['Latitude', 'Longitude', 'Severity']

#         # One-hot encode categorical features
#         preprocessor = ColumnTransformer(
#             transformers=[
#                 ('num', StandardScaler(), numerical_cols),
#                 ('cat', OneHotEncoder(handle_unknown='ignore'), categorical_cols)
#             ]
#         )

#         X = preprocessor.fit_transform(X)

#         # Feature Selection
#         selector = SelectKBest(f_classif, k=10)  
#         X = selector.fit_transform(X, y)

#         # Handle class imbalance using SMOTE
#         smote = SMOTE(random_state=42)
#         X, y = smote.fit_resample(X, y)

#         # Split dataset
#         X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

#         # Train Random Forest model
#         model = RandomForestClassifier(n_estimators=100, random_state=42)
#         model.fit(X_train, y_train)
#         y_pred = model.predict(X_test)

#         # Compute metrics
#         accuracy = accuracy_score(y_test, y_pred)
#         class_report = classification_report(y_test, y_pred, output_dict=True)
#         cm = confusion_matrix(y_test, y_pred)

#         # Save model
#         joblib.dump(model, 'media/Detection/rf_model.pkl')
#         joblib.dump(preprocessor, 'media/Detection/preprocessor.pkl')

#         # **🔹 Save Confusion Matrix Image**
#         cm_img_path = "media/Detection/confusion_matrix.png"
#         plt.figure(figsize=(6, 6))
#         sns.heatmap(cm, annot=True, fmt="d", cmap="Blues", xticklabels=set(y_test), yticklabels=set(y_test))
#         plt.xlabel("Predicted Label")
#         plt.ylabel("True Label")
#         plt.title("Confusion Matrix")
#         plt.savefig(cm_img_path)
#         plt.close()

#         # **🔹 Save ROC Curve Image**
#         roc_img_path = "media/Detection/roc_curve.png"
#         y_test_bin = label_binarize(y_test, classes=list(set(y_test)))
#         n_classes = y_test_bin.shape[1]

#         plt.figure(figsize=(6, 6))
#         for i in range(n_classes):
#             fpr, tpr, _ = roc_curve(y_test_bin[:, i], y_pred == i)
#             roc_auc = auc(fpr, tpr)
#             plt.plot(fpr, tpr, label=f'Class {i} (AUC = {roc_auc:.2f})')

#         plt.plot([0, 1], [0, 1], linestyle='--', color='gray')
#         plt.xlabel("False Positive Rate")
#         plt.ylabel("True Positive Rate")
#         plt.title("ROC Curve")
#         plt.legend()
#         plt.savefig(roc_img_path)
#         plt.close()

#         # Process classification report
#         class_report_data = [
#             {
#                 "Class": label, 
#                 "Precision": round(metrics["precision"], 2), 
#                 "Recall": round(metrics["recall"], 2),
#                 "F1_score": round(metrics["f1-score"], 2), 
#                 "Support": int(metrics["support"])
#             }
#             for label, metrics in class_report.items() if isinstance(metrics, dict)
#         ]

#         # Return results
#         return render(request, 'Master/model_prediction.html', {
#             "accuracy": round(accuracy * 100, 2),
#             "classification_report": class_report_data,
#             "confusion_matrix_img": "confusion_matrix.png",
#             "roc_curve_img": "roc_curve.png"
#         })

#     except Exception as e:
#         return JsonResponse({"error": str(e)})
def train_and_predict_model(request):
    try:
        # Load dataset
        data = pd.read_csv('media/Detection/crime_prediction_dataset.csv')

        # Separate features and target
        X = data.drop(columns=['Crime Type'])  
        y = data['Crime Type']

        # Identify categorical and numerical columns
        categorical_cols = ['Weather', 'Area Type', 'Economic Status of Area']  
        numerical_cols = ['Latitude', 'Longitude', 'Severity']

        # One-hot encode categorical features
        preprocessor = ColumnTransformer(
            transformers=[
                ('num', StandardScaler(), numerical_cols),
                ('cat', OneHotEncoder(handle_unknown='ignore'), categorical_cols)
            ]
        )

        X = preprocessor.fit_transform(X)

        # Feature Selection
        selector = SelectKBest(f_classif, k=10)  
        X = selector.fit_transform(X, y)

        # Handle class imbalance using SMOTE
        smote = SMOTE(random_state=42)
        X, y = smote.fit_resample(X, y)

        # Split dataset
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        # Train Random Forest model
        model = RandomForestClassifier(n_estimators=100, random_state=42)
        model.fit(X_train, y_train)
        y_pred = model.predict(X_test)

        # Compute metrics
        accuracy = accuracy_score(y_test, y_pred)
        class_report = classification_report(y_test, y_pred, output_dict=True)
        cm = confusion_matrix(y_test, y_pred)

        # Save model
        joblib.dump(model, 'media/Detection/rf_model.pkl')
        joblib.dump(preprocessor, 'media/Detection/preprocessor.pkl')

        # **🔹 Save Confusion Matrix Image**
        cm_img_path = "media/Detection/confusion_matrix.png"
        plt.figure(figsize=(6, 6))
        sns.heatmap(cm, annot=True, fmt="d", cmap="Blues", xticklabels=set(y_test), yticklabels=set(y_test))
        plt.xlabel("Predicted Label")
        plt.ylabel("True Label")
        plt.title("Confusion Matrix")
        plt.savefig(cm_img_path)
        plt.close()

        # **🔹 Save ROC Curve Image**
        roc_img_path = "media/Detection/roc_curve.png"
        y_test_bin = label_binarize(y_test, classes=list(set(y_test)))
        n_classes = y_test_bin.shape[1]

        plt.figure(figsize=(6, 6))
        for i in range(n_classes):
            fpr, tpr, _ = roc_curve(y_test_bin[:, i], y_pred == i)
            roc_auc = auc(fpr, tpr)
            plt.plot(fpr, tpr, label=f'Class {i} (AUC = {roc_auc:.2f})')

        plt.plot([0, 1], [0, 1], linestyle='--', color='gray')
        plt.xlabel("False Positive Rate")
        plt.ylabel("True Positive Rate")
        plt.title("ROC Curve")
        plt.legend()
        plt.savefig(roc_img_path)
        plt.close()

        # Process classification report
        class_report_data = [
            {
                "Class": label,
                "Precision": round(metrics["precision"], 2),
                "Recall": round(metrics["recall"], 2),
                "F1_score": round(metrics["f1-score"], 2),
                "Support": int(metrics["support"])
            }
            for label, metrics in class_report.items() if isinstance(metrics, dict)
        ]

        # Render results
        return render(request, 'Master/model_prediction.html', {
            "accuracy": round(accuracy * 100, 2),
            "classification_report": class_report_data,
            "confusion_matrix_img": cm_img_path,
            "roc_curve_img": roc_img_path
        })

    except Exception as e:
        return JsonResponse({"error": str(e)})


def train_and_predict_svm_model(request):
    try:
        # Load dataset
        data = pd.read_csv('media/Detection/crime_prediction_dataset.csv')

        # Separate features and target
        X = data.drop(columns=['Crime Type'])  
        y = data['Crime Type']

        # Identify categorical and numerical columns
        categorical_cols = ['Weather', 'Area Type', 'Economic Status of Area']  
        numerical_cols = ['Latitude', 'Longitude', 'Severity']

        # One-hot encode categorical features
        preprocessor = ColumnTransformer(
            transformers=[
                ('num', StandardScaler(), numerical_cols),
                ('cat', OneHotEncoder(handle_unknown='ignore'), categorical_cols)
            ]
        )

        X = preprocessor.fit_transform(X)

        # Feature Selection
        selector = SelectKBest(f_classif, k=10)  
        X = selector.fit_transform(X, y)

        # Handle class imbalance using SMOTE
        smote = SMOTE(random_state=42)
        X, y = smote.fit_resample(X, y)

        # Split dataset
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        # Train SVM model
        model = SVC(kernel='rbf', probability=True, random_state=42)
        model.fit(X_train, y_train)
        y_pred = model.predict(X_test)
        y_pred_proba = model.predict_proba(X_test)

        # Compute metrics
        accuracy = accuracy_score(y_test, y_pred)
        class_report = classification_report(y_test, y_pred, output_dict=True)
        cm = confusion_matrix(y_test, y_pred)

        # Save model
        joblib.dump(model, 'media/Detection/svm_model.pkl')
        joblib.dump(preprocessor, 'media/Detection/svm_preprocessor.pkl')

        # **🔹 Save Confusion Matrix Image**
        cm_img_path = "media/Detection/svm_confusion_matrix.png"
        plt.figure(figsize=(6, 6))
        sns.heatmap(cm, annot=True, fmt="d", cmap="Blues", xticklabels=set(y_test), yticklabels=set(y_test))
        plt.xlabel("Predicted Label")
        plt.ylabel("True Label")
        plt.title("Confusion Matrix")
        plt.savefig(cm_img_path)
        plt.close()

        # **🔹 Save ROC Curve Image**
        roc_img_path = "media/Detection/svm_roc_curve.png"
        y_test_bin = label_binarize(y_test, classes=list(set(y_test)))
        n_classes = y_test_bin.shape[1]

        plt.figure(figsize=(6, 6))
        for i in range(n_classes):
            fpr, tpr, _ = roc_curve(y_test_bin[:, i], y_pred_proba[:, i])
            roc_auc = auc(fpr, tpr)
            plt.plot(fpr, tpr, label=f'Class {i} (AUC = {roc_auc:.2f})')

        plt.plot([0, 1], [0, 1], linestyle='--', color='gray')
        plt.xlabel("False Positive Rate")
        plt.ylabel("True Positive Rate")
        plt.title("ROC Curve")
        plt.legend()
        plt.savefig(roc_img_path)
        plt.close()

        # Process classification report
        class_report_data = [
            {
                "Class": label, 
                "Precision": round(metrics["precision"], 2), 
                "Recall": round(metrics["recall"], 2),
                "F1_score": round(metrics["f1-score"], 2), 
                "Support": int(metrics["support"])
            }
            for label, metrics in class_report.items() if isinstance(metrics, dict)
        ]

        # Return results
        return render(request, 'Master/svm_model_prediction.html', {
            "accuracy": round(accuracy * 100, 2),
            "classification_report": class_report_data,
            "svm_confusion_matrix_img": "svm_confusion_matrix.png",
            "svm_roc_img": "svm_roc_curve.png"
        })

    except Exception as e:
        return JsonResponse({"error": str(e)})

def predict_crime(request):
    if request.method == 'POST':
        try:
            # Get selected algorithm
            algorithm = request.POST.get('algorithm')

            # Determine model paths based on selected algorithm
            if algorithm == 'SVM':
                model_path = 'media/Detection/svm_model.pkl'
                preprocessor_path = 'media/Detection/svm_preprocessor.pkl'
            else:  # Default to Random Forest if not SVM
                model_path = 'media/Detection/rf_model.pkl'
                preprocessor_path = 'media/Detection/preprocessor.pkl'

           

            # Load trained model and preprocessor
            model = joblib.load(model_path)
            preprocessor = joblib.load(preprocessor_path)

            # Collect user input
            severity = int(request.POST.get('severity'))
            latitude = float(request.POST.get('latitude'))
            longitude = float(request.POST.get('longitude'))
            weather = request.POST.get('weather')
            population_density = int(request.POST.get('populationDensity'))
            area_type = request.POST.get('areaType')
            economic_status = request.POST.get('economicStatus')
            traffic_density = int(request.POST.get('trafficDensity'))

            # Create DataFrame with all input features
            input_data = pd.DataFrame([{
                'Severity': severity,
                'Latitude': latitude,
                'Longitude': longitude,
                'Weather': weather,
                'Population Density': population_density,
                'Area Type': area_type,
                'Economic Status of Area': economic_status,
                'Traffic Density': traffic_density
            }])

            # Apply preprocessing transformation
            input_data_transformed = preprocessor.transform(input_data)

            # Ensure only required features are passed to the model
            expected_features = model.n_features_in_
            input_data_transformed = input_data_transformed[:, :expected_features]

            # Make prediction
            prediction = model.predict(input_data_transformed)
            predicted_crime_type = prediction[0]

            # Mapping for labels
            mappings = {
                'Crime Type': {1: 'Kidnapping', 2: 'Homicide', 3: 'Robbery', 4: 'Burglary', 
                               5: 'Vandalism', 6: 'Assault', 7: 'Other'},
                'Severity': {1: 'Low', 2: 'Moderate', 3: 'High'},
                'Weather': {'1': 'Sunny', '2': 'Cloudy', '3': 'Rainy', '4': 'Foggy'},
                'Area Type': {'1': 'Urban', '2': 'Suburban', '3': 'Rural'},
                'Economic Status of Area': {'1': 'Low', '2': 'Medium', '3': 'High'},
                'Traffic Density': {1: 'Low', 2: 'Medium', 3: 'High'} 
            }

            # Convert predicted crime type
            crime_type_label = mappings['Crime Type'].get(predicted_crime_type, 'Unknown')
            severity_label = mappings['Severity'].get(severity, 'Unknown')
            weather_label = mappings['Weather'].get(str(weather), 'Unknown')
            area_type_label = mappings['Area Type'].get(str(area_type), 'Unknown')
            economic_status_label = mappings['Economic Status of Area'].get(str(economic_status), 'Unknown')
            traffic_density_label = mappings['Traffic Density'].get(traffic_density, 'Unknown')

            input_data1 = {
                'crime_type': crime_type_label,
                'severity': severity_label,
                'latitude': latitude,
                'longitude': longitude,
                'weather': weather_label,
                'population_density': population_density,
                'area_type': area_type_label,
                'economic_status': economic_status_label,
                'traffic_density': traffic_density_label,
                'algorithm': 'Support Vector Machine (SVM)' if algorithm == 'SVM' else 'Random Forest'
            }

            return render(request, 'Master/predict_crime_result.html', {
                'predicted_crime_type': crime_type_label,
                'input_data': input_data1
            })

        except Exception as e:
            return JsonResponse({"error": str(e)})

    return redirect('prediction_crime')


def send_prediction_warning(request, latitude, longitude,crimetype):
    
    # Ensure the user is logged in (adjust session check as per your auth logic)
    if 'aname' not in request.session:
        return redirect('user_login')
    
    # Convert latitude and longitude parameters to floats
    try:
        target_lat = float(latitude)
        target_lon = float(longitude)
    except (TypeError, ValueError):
        messages.error(request, "Invalid coordinates provided.")
        return redirect('some_error_page')  # or wherever you want to redirect on error

    # Define your email subject and message content
    subject = "Warning: Nearby Alert"
    plain_message = (
        "This is an alert: you are within a 5 km radius of a hotspot area. "
        "Please take the necessary precautions."
    )
    html_message = format_html(
        """
        <div style="font-family: sans-serif; line-height: 1.5;">
            <h2>Hotspot Warning</h2>
            <p>You are within a 5 km perimeter of a hotspot area.</p>
            <p>Please take the necessary precautions.</p>
        </div>
        """
    )
    
    # For efficiency, first filter by a bounding box.
    # Approximate conversion: 1 degree latitude ~ 111 km.
    lat_diff = 5 / 111.0  # about 0.045 degrees
    # Longitude degrees vary with latitude. At the equator 1 degree ~ 111 km.
    # Adjust the longitude difference based on the current latitude:
    lon_diff = 5 / (111.0 * math.cos(math.radians(target_lat)))
    
    # Query users whose stored coordinates are not null and within the bounding box.
    nearby_users = UserInfo.objects.all()
    
    # Further filter using the precise Haversine formula
    recipients = []
    for user in nearby_users:
        try:
            user_lat = float(user.latitude)
            user_lon = float(user.longitude)
        except (TypeError, ValueError):
            continue  # Skip users with invalid coordinate values

        distance = haversine(target_lat, target_lon, user_lat, user_lon)
        if distance <= 5:
            recipients.append(user.email_id)
            obj=CrimePrediction()
            obj.longitude=longitude
            obj.latitude=latitude
            obj.user_id=user.user_id
            obj.predicted_crime_type=crimetype
            obj.save()
    
    # If there are recipients, send them the email
    if recipients:
     
        send_mail(recipients, html_message, subject)
        messages.success(request, "Warning emails have been sent to nearby users and police stations.")
    else:
        messages.info(request, "No users found within a 5 km radius.")

    return render(request, 'Master/hostspot_message_success.html')

def user_hot_spot(request):
    if 'aname' in request.session:
        
        hotspots = CrimeHotSpot.objects.all()  
        return render(request, 'Master/user_hot_spot.html', {'hotspots': hotspots})
           
            
    else:
        return redirect('user_login') 
def adm_display_crimes(request, latitude, longitude):
    if 'aname' in request.session:
             # Load dataset from CSV (change path accordingly)
        latitude = float(latitude)
        longitude = float(longitude)
        csv_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)
        df = pd.read_csv(csv_path)
        
# Rename columns: Replace spaces with underscores
        df.columns = df.columns.str.replace(' ', '_')
        df.columns = df.columns.str.replace('&', '_')
        df.columns = df.columns.str.replace('(minutes)', '')
        # Convert latitude & longitude columns to float
        df['Latitude'] = pd.to_numeric(df['Latitude'], errors='coerce')
        df['Longitude'] = pd.to_numeric(df['Longitude'], errors='coerce')

        # Drop rows where conversion failed (NaN values)
        df = df.dropna(subset=['Latitude', 'Longitude'])

     

        # Convert latitude & longitude columns to float
        df['Latitude'] = pd.to_numeric(df['Latitude'], errors='coerce')
        df['Longitude'] = pd.to_numeric(df['Longitude'], errors='coerce')

        # Drop rows where conversion failed (NaN values)
        df = df.dropna(subset=['Latitude', 'Longitude'])

        # Compute distances & filter crimes within 5km radius
        df['Distance'] = df.apply(lambda row: haversine(latitude, longitude, row['Latitude'], row['Longitude']), axis=1)
        nearby_crimes = df[df['Distance'] <= 5]  # Crimes within 5km

        # Convert DataFrame to list of dictionaries for template
        crimes_list = nearby_crimes.to_dict(orient='records')

        return render(request, 'Master/adm_display_crimes.html', {'crimes': crimes_list})
            
    else:
        return redirect('user_login')

def user_predition_list(request):
    if 'aname' in request.session:
        
        prediction = CrimePrediction.objects.all()  
        return render(request, 'Master/user_predition_list.html', {'prediction': prediction})
           
            
    else:
        return redirect('user_login') 
def user_predition_list(request):
    if 'aname' in request.session:
        
        prediction = CrimePrediction.objects.all()  
        return render(request, 'Master/user_predition_list.html', {'prediction': prediction})
           
            
    else:
        return redirect('user_login')     



def heat_map(request):
    csv_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)  # Replace with actual filename

    if not os.path.exists(csv_path):
        return render(request, "Master/heat_map.html.html", {"hotspots": None})

    try:
        crime_data = pd.read_csv(csv_path)
    except Exception as e:
        return render(request, "Master/heat_map.html.html", {"error": f"Error loading CSV: {str(e)}"})

    required_columns = {"Latitude", "Longitude"}
    if not required_columns.issubset(crime_data.columns):
        return render(request, "Master/heat_map.html.html", {"error": "Invalid CSV format"})

    crime_data = crime_data[(crime_data["Latitude"].between(-90, 90)) & (crime_data["Longitude"].between(-180, 180))]
    locations = crime_data[['Latitude', 'Longitude']].dropna().copy()

    if locations.shape[0] < 5:
        return render(request, "Master/heat_map.html.html", {"error": "Not enough data for clustering."})

    # Apply K-Means Clustering
    kmeans = KMeans(n_clusters=5, random_state=42, n_init=10)
    locations['Cluster'] = kmeans.fit_predict(locations)

    hotspots = locations.to_dict(orient="records")

    return render(request, "Master/heat_map.html", {"hotspots": hotspots})
   
def plc_warning_list(request):
    if 'pname' in request.session:
        
        hotspots = CrimeHotSpot.objects.all()  
        return render(request, 'Police/plc_warning_list.html', {'hotspots': hotspots})
           
            
    else:
        return redirect('user_login') 
    
def p_google_map_view_spot(request, latitude, longitude):
    if 'pname' in request.session:
     
            context = {'latitude': latitude,'longitude': longitude,}
            return render(request, 'Police/google_map_view_spot.html',context)
    else:
        return redirect('user_login')
def p_display_crimes(request, latitude, longitude):
    if 'pname' in request.session:
             # Load dataset from CSV (change path accordingly)
        latitude = float(latitude)
        longitude = float(longitude)
        csv_path = os.path.join(settings.MEDIA_ROOT, FIXED_FILENAME)
        df = pd.read_csv(csv_path)
        
# Rename columns: Replace spaces with underscores
        df.columns = df.columns.str.replace(' ', '_')
        df.columns = df.columns.str.replace('&', '_')
        df.columns = df.columns.str.replace('(minutes)', '')
        # Convert latitude & longitude columns to float
        df['Latitude'] = pd.to_numeric(df['Latitude'], errors='coerce')
        df['Longitude'] = pd.to_numeric(df['Longitude'], errors='coerce')

        # Drop rows where conversion failed (NaN values)
        df = df.dropna(subset=['Latitude', 'Longitude'])

     

        # Convert latitude & longitude columns to float
        df['Latitude'] = pd.to_numeric(df['Latitude'], errors='coerce')
        df['Longitude'] = pd.to_numeric(df['Longitude'], errors='coerce')

        # Drop rows where conversion failed (NaN values)
        df = df.dropna(subset=['Latitude', 'Longitude'])

        # Compute distances & filter crimes within 5km radius
        df['Distance'] = df.apply(lambda row: haversine(latitude, longitude, row['Latitude'], row['Longitude']), axis=1)
        nearby_crimes = df[df['Distance'] <= 30]  # Crimes within 5km

        # Convert DataFrame to list of dictionaries for template
        crimes_list = nearby_crimes.to_dict(orient='records')

        return render(request, 'Police/display_crimes.html', {'crimes': crimes_list})
            
    else:
        return redirect('user_login')
def crime_updates(request,id):
    if 'pname' in request.session:
        
            CrimeUpdatesdata = CrimeUpdates.objects.filter(crime_id=id)
            context = {'CrimeUpdates': CrimeUpdatesdata,'id':id}
            return render(request, 'Police/crime_updates.html',context)
    else:
        return redirect('user_login')
def save_updates(request,id):
    if 'pname' in request.session:
        data=get_police(request.session['slogid'])
        police_station_id=data.police_station_id
        c=Crime.objects.get(crime_id=id)
        c.status="Investigation is started"
        c.save()
        crime=CrimeUpdates()
        crime.crime_id=id
        crime.police_station_id=police_station_id
        crime.crime_updates=request.POST.get('updates')
        crime.save()
        messages.add_message(request, messages.INFO, 'Updated Successfully.')
        return redirect('crime_updates',id)
    else:
        return redirect('user_login')
def add_culprit(request,id):
    if 'pname' in request.session:
        
            today = date.today()
            CulpritDetails = Culprit.objects.filter(crime_id=id)
            context = {'id':id,'today':today,'CulpritDetails':CulpritDetails}
            return render(request, 'Police/add_culprit.html',context)
    else:
        return redirect('user_login')
    


def save_culprit(request, id):
    if 'pname' in request.session:
        if request.method == "POST":
            culprit_name = request.POST.get('culprit_name')
          
            culprit_gender = request.POST.get('culprit_gender')
            culprit_dob = request.POST.get('culprit_dob')
            culprit_address = request.POST.get('culprit_address')
            culprit_phone = request.POST.get('culprit_phone')

            if culprit_name and culprit_gender and culprit_dob and culprit_address and culprit_phone:
                Culprit.objects.create(
                    culprit_name=culprit_name,
                    culprit_gender=culprit_gender,
                    culprit_dob=culprit_dob,
                    culprit_address=culprit_address,
                    culprit_phone=culprit_phone,
                    crime_id=id
                )
                messages.success(request, "Culprit details saved successfully!")
            else:
                messages.error(request, "All fields are required.")

        return redirect('add_culprit',id)  # Update with your actual template/view name
    else:
        return redirect('user_login')
def delete_updates(request,id):
 if 'pname' in request.session:
    data=CrimeUpdates.objects.get(crime_updates_id=id)
    tbl=CrimeUpdates.objects.get(crime_updates_id=id)
    tbl.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('crime_updates',data.crime_id) 
 else:
      return redirect('user_login')
def delete_culprit(request,id):
 if 'pname' in request.session:
    data=Culprit.objects.get(culprit_id=id)
    tbl=Culprit.objects.get(culprit_id=id)
    tbl.delete()
    messages.add_message(request, messages.INFO, 'Deleted successfully.')
    return redirect('add_culprit',data.crime_id)  
 else:
      return redirect('user_login')
def get_user(logid):
     data=UserInfo.objects.get(login_id=logid)
     return data
def get_police(logid):
     data=PoliceStation.objects.get(login_id=logid)
     return data
# Function to plot Confusion Matrix and save as image
def plot_confusion_matrix(y_test, y_pred, image_name):
    cm = confusion_matrix(y_test, y_pred, labels=np.unique(y_test))
    
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap="Blues", xticklabels=np.unique(y_test), yticklabels=np.unique(y_test))
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.title('Confusion Matrix')
    
    image_path = f"media/Detection/{image_name}"
    plt.savefig(image_path)
    plt.close()

# Function to plot ROC Curve and save as image
def plot_roc_curve(model, X_test, y_test, image_name):
    y_test_bin = label_binarize(y_test, classes=np.unique(y_test))
    n_classes = y_test_bin.shape[1]
    
    y_score = model.predict_proba(X_test)

    plt.figure(figsize=(8, 6))
    for i in range(n_classes):
        fpr, tpr, _ = roc_curve(y_test_bin[:, i], y_score[:, i])
        roc_auc = auc(fpr, tpr)
        plt.plot(fpr, tpr, label=f'Class {i} (AUC = {roc_auc:.2f})')

    plt.plot([0, 1], [0, 1], 'k--', lw=2)
    plt.xlim([0.0, 1.0])
    plt.ylim([0.0, 1.05])
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Multi-Class ROC Curve')
    plt.legend(loc="lower right")
    
    image_path = f"media/Detection/{image_name}"
    plt.savefig(image_path)
    plt.close()