# Codelecta 2.0

> **A Modern Interactive Programming Learning Platform**  
> Built with ASP.NET Web Forms 4.8, C#, Entity Framework 6 (Code-First), and Microsoft SQL Server LocalDB.

---

## 📖 Table of Contents
- [Project Overview](#-project-overview)
- [Key Features](#-key-features)
  - [Learner Experience](#learner-experience)
  - [Admin Management](#admin-management)
- [Technology Stack](#-technology-stack)
- [Project Structure](#-project-structure)
- [Getting Started & Local Setup](#-getting-started--local-setup)
- [Database & Seeded Data](#-database--seeded-data)
- [Default Test Credentials](#-default-test-credentials)
- [Architecture & Design Details](#-architecture--design-details)

---

## 🎯 Project Overview

**Codelecta 2.0** provides a structured, responsive, and engaging programming education environment tailored for beginners, university students, and working professionals. Learners can enroll in level-tailored tracks, follow structured lessons with rich syntax-formatted markdown and interactive video chapters, complete graded quizzes, track their progress with contribution heatmaps and streaks, and compete on the global leaderboard.

---

## ✨ Key Features

### Learner Experience
- **Account & Identity Management**: Secure registration, login, profile management, and role-based access using ASP.NET Identity & OWIN cookies.
- **Dynamic Course Catalog (`Courses.aspx`)**: Search by keyword, filter by difficulty (Beginner, Intermediate, Advanced), real-time enrollment statistics, and responsive grid layouts.
- **Detailed Course Overview (`CourseDetail.aspx`)**: Course syllabus, prerequisites, completion badges, and single-click enrollment with defensive error handling for non-existent IDs.
- **Interactive Lesson Player (`ViewLesson.aspx`)**:
  - Embedded YouTube video player synced with an **Interactive Video Chapters** timeline.
  - Markdown-to-HTML parser rendering syntax-highlighted code blocks with language tags and one-click copy buttons.
  - Formatted callout banners, headings, and bullet points.
  - Next/Previous lesson navigation with button-loading debounce states.
- **Comprehensive Assessment System (`TakeQuiz.aspx`)**:
  - Course-specific multiple-choice quizzes with randomized questions.
  - Instant scoring, pass/fail thresholds, and detailed answer explanations.
- **Personalized Student Dashboard (`Dashboard.aspx`)**:
  - Real-time progress metrics (courses enrolled, lessons completed, quiz passing rates).
  - Activity Heatmap (GitHub-style calendar) tracking learning activity.
  - Learning streak tracker and recent quiz attempt records.
  - Quick action to view the platform leaderboard.
- **Global Leaderboard (`Leaderboard.aspx`)**:
  - Dynamic ranking based on average assessment scores and passing attempts.
  - Mobile touch-scrolling optimization for table views.

### Admin Management (`/Admin/*`)
- **Admin Dashboard (`Admin/Dashboard.aspx`)**: System-wide statistics (total users, enrollments, course engagement, completion metrics).
- **Course Management (`Admin/ManageCourses.aspx`)**: Full CRUD operations with validation groups and animated feedback notifications.
- **Lesson Management (`Admin/ManageLessons.aspx`)**: Add/edit lessons, order indices, video embed links, and markdown content.
- **Quiz & Assessment Control (`Admin/ManageQuizzes.aspx`)**: Manage passing scores, quiz questions, and options.
- **User & Enrollment Audits (`Admin/ManageUsers.aspx` & `Admin/ManageEnrollments.aspx`)**: View student accounts, change roles, and inspect course enrollments.

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| **Framework** | ASP.NET Web Forms 4.8 (.NET Framework 4.8) |
| **Language** | C# 7.3+ |
| **ORM / Data Access** | Entity Framework 6 (Code-First) |
| **Database** | Microsoft SQL Server LocalDB (`(LocalDB)\MSSQLLocalDB`) |
| **Authentication** | ASP.NET Identity 2.0 & OWIN Security |
| **Frontend Styling** | Custom CSS3 Design System (CSS Variables, Flexbox/Grid), Bootstrap utilities |
| **Client Scripting** | JavaScript (ES6+), FontAwesome / SVG Icons |
| **Build & Tooling** | Visual Studio 2022 / MSBuild |

---

## 📂 Project Structure

```text
Codelecta_2.0/
├── Account/                   # Authentication (Login, Register, Manage, ForgotPassword)
├── Admin/                     # Administrative management suite
│   ├── Admin.Master           # Admin layout master template
│   ├── Dashboard.aspx         # High-level metrics & analytics
│   ├── ManageCourses.aspx     # Course CRUD
│   ├── ManageLessons.aspx     # Lesson CRUD & video linking
│   ├── ManageQuizzes.aspx     # Quiz & Question configuration
│   ├── ManageUsers.aspx       # User account administration
│   └── ManageEnrollments.aspx # Student enrollment inspection
├── App_Data/                  # LocalDB SQL database MDF/LDF files
├── App_Start/                 # Route, Bundle, Identity, and Startup configs
├── Content/                   # CSS stylesheets, static assets, and SVG course badges
│   └── css/                   # Modular CSS (base, hero, navbar, components, etc.)
├── Migrations/                # EF Code-First database migrations & seed scripts
├── Models/                    # Entity models (Course, Lesson, Quiz, Progress, Identity)
├── Scripts/                   # Client-side scripts & vendor libraries
├── Site.Master                # Public master page & responsive navigation
├── Default.aspx               # Modern homepage with hero & course showcase
├── Courses.aspx               # Course catalog with search & filtering
├── CourseDetail.aspx          # Single course overview & syllabus
├── ViewLesson.aspx            # Interactive video lesson & markdown reader
├── TakeQuiz.aspx              # Multi-choice quiz assessment engine
├── Dashboard.aspx             # Learner portal, stats, heatmap, and streaks
├── Leaderboard.aspx           # Platform-wide top performer rankings
└── Web.config                 # Connection strings, assembly bindings, and OWIN settings
```

---

## 🚀 Getting Started & Local Setup

### Prerequisites
- **Visual Studio 2022** (with *.NET desktop development* and *ASP.NET and web development* workloads)
- **.NET Framework 4.8 Developer Pack**
- **SQL Server LocalDB** (included with Visual Studio)

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/Codelecta_2.0.git
   cd Codelecta_2.0
   ```

2. **Open the solution**:
   Open `Codelecta_2.0.sln` or `Codelecta_2.0.csproj` in Visual Studio 2022.

3. **Restore NuGet Packages**:
   Visual Studio should restore automatically upon build, or execute via Package Manager Console:
   ```powershell
   Update-Package -reinstall
   ```

4. **Verify Database Connection**:
   Check `Web.config` to ensure the `DefaultConnection` string points to your local instance:
   ```xml
   <connectionStrings>
     <add name="DefaultConnection" 
          connectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\aspnet-Codelecta_2.0-20260812124505.mdf;Initial Catalog=aspnet-Codelecta_2.0-20260812124505;Integrated Security=True" 
          providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

5. **Build and Run**:
   - Press `Ctrl + F5` or click **Start Without Debugging** in Visual Studio.
   - Alternatively, build using MSBuild:
     ```powershell
     & "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\MSBuild.exe" "Codelecta_2.0.csproj" -p:Configuration=Debug
     ```

---

## 📊 Database & Seeded Data

The application comes pre-configured with rich demonstration records:
- **8 Core Courses**: Python Fundamentals, JavaScript & Modern Web, C# Programming, React Deep Dive, Java Enterprise, Data Structures & Algorithms, HTML5 & CSS3 Mastery, System Architecture.
- **40 Structured Lessons**: 5 ordered lessons per course with video URLs and markdown coding walkthroughs.
- **8 Quizzes & 40 Questions**: Tailored assessment sets with scoring configurations.
- **Enrollment & Progress Records**: Active course enrollments, completion timestamps, and quiz attempts.

---

## 🔐 Default Test Credentials

Use these pre-seeded accounts to explore both learner and administrator capabilities:

| Role | Email / Username | Password | Notes |
|---|---|---|---|
| **Administrator** | `admin@gmail.com` | `Admin@123` | Full access to `/Admin/*` control panels |
| **Learner (Intermediate)**| `user@gmail.com` | `User@123` | Active enrollments, streaks, & quiz attempts |
| **Learner (Beginner)** | `user1@gmail.com` | `User1@123` | Demonstration student account |
| **Learner** | `test@gmail.com` | `Test@123` | Additional test profile |
| **Learner** | `beginner@gmail.com`| `Beginner@123`| Starter profile for clean walkthroughs |

---

## 💡 Architecture & Design Details

- **Responsive Design System**: Custom mobile-first CSS architecture with CSS custom properties (`--primary`, `--bg-card`, `--border`, etc.) ensuring consistent dark/light contrast without heavy dependencies.
- **Defensive UI & Error Handling**: Invalid or omitted query parameters (e.g. `?id=999`) render in-page friendly error cards with direct recovery links instead of silent redirects or unhandled exceptions.
- **Markdown & Code Presentation**: Custom server-side regex parser converts markdown syntax to HTML, wraps code blocks with syntax highlighting classes, and attaches copy-to-clipboard functionality.
- **Double-Postback Prevention**: Client-side JavaScript disablers and loading text spinners on submit buttons mitigate accidental duplicate form submissions.
