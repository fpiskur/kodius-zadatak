## Kodius zadatak
See it live at: https://protected-taiga-38192.herokuapp.com/

---
**Functionalities:**

 **- User management (login, logout, password reset...**
 
 **- Adminstrative dashboard for overlooking state of the hotel rooms in the accommodation for receptionists.**
 - Dashboard with statistics:


		1. Available rooms on today’s date
		2. Booked rooms on today’s date

**- User dashboard for viewing available rooms and booking.**

 - A list of available rooms for booking for turists/users (a room has to have pictures)
 - Filter/search of the rooms by price and/or calendar availability
 
**- Preload of data fixtures (fake data)**
https://docs.djangoproject.com/en/3.2/howto/initial-data

**- Custom command for notifying all of the customers who are currently
   staying in the room with the message of candidate’s choice.**

**- Room numbers need to be specified in advance in the range between 10 and 50.**

---
**Intro**

To complete this task I worked with several presumptions:

 - people staying in the hotel are booking overnight stay, so check-in date and check-out date cannot be the same, and new check-in can be made on the same day as the check-out from another user
 - room numbers are in the following format: [floor][room_number]
---
**Installation**

1. `git clone git@github.com:fpiskur/kodius-zadatak.git`
2. `cd kodius-zadatak`
3. `bundle install`
4. `rails db:migrate`
5. `rails db:seed`
6. `rails server`

---
**Info**

- **admin** email: admin@example.com / pass: "password"
- **customer** email: other@example.com / pass: "password"
- custom message to users is sent via email so to test it online you will have to sign up with a valid email and activate your account