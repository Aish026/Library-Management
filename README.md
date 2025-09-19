# Online Library Management System

## Overview
The **Online Library Management System** is a Java web application that allows:

- **Admin**: Add and manage books.
- **Users**: Register, login, borrow, and return books.

It is built using **Java Servlets, JSP, JDBC, MySQL, Bootstrap, and Tomcat**.

---

## Tech Stack
- **Frontend**: HTML, CSS, Bootstrap, JSP
- **Backend**: Java Servlets
- **Database**: MySQL
- **Server**: Apache Tomcat
- **Build Tool**: Maven

---

## Project Structure
LibraryManagement/
├── src/main/java/com/library/
│ ├── servlets/ # All servlets (Login, Register, Borrow, Return, etc.)
│ └── utils/ # DBUtil.java (database connection helper)
├── src/main/webapp/
│ ├── css/style.css
│ ├── login.jsp
│ ├── register.jsp
│ ├── dashboard.jsp
│ ├── admin.jsp
│ └── WEB-INF/web.xml
└── pom.xml # Maven dependencies

---

## Setup Instructions

1. **Prerequisites**: Install JDK 11+, Eclipse IDE, Tomcat 9/10, MySQL, Maven.
2. **Database Setup**: Create database `library_db` and run the SQL script provided.
3. **Configure DB Connection**: Update `DBUtil.java` with your MySQL username and password.
4. **Run Project**:
   - Import as Maven Web Project in Eclipse.
   - Add Tomcat server.
   - Right-click project → Run As → Run on Server.
5. Open in browser:  
http://localhost:8080/LibraryManagement

---

## Default Login Credentials

| Role  | Username | Password  |
|-------|----------|-----------|
| Admin | admin    | admin123  |
| User  | alice    | alice123  |
| User  | bob      | bob123    |

---

## Features
- User registration and login  
- Admin can add and view books  
- Users can borrow and return books  
- Transactions tracked with borrow and return dates  
- Responsive UI with Bootstrap and custom CSS

---

## License
This project is for **educational purposes only**.
