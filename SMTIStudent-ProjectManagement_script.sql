USE [master]
GO
/****** Object:  Database [SMTIStudent-ProjectManagement]    Script Date: 2024-04-26 9:36:11 PM ******/
CREATE DATABASE [SMTIStudent-ProjectManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SMTIStudent-ProjectManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SMTIStudent-ProjectManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SMTIStudent-ProjectManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SMTIStudent-ProjectManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SMTIStudent-ProjectManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET  MULTI_USER 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SMTIStudent-ProjectManagement', N'ON'
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET QUERY_STORE = ON
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SMTIStudent-ProjectManagement]
GO
/****** Object:  Table [dbo].[ProjectAssignments]    Script Date: 2024-04-26 9:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAssignments](
	[ProjectAssignmentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[SubmittedDate] [date] NULL,
 CONSTRAINT [PK_ProjectAssignments] PRIMARY KEY CLUSTERED 
(
	[ProjectAssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 2024-04-26 9:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectTitle] [nvarchar](100) NOT NULL,
	[DueDate] [date] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2024-04-26 9:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[UserType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProjectAssignments] ON 

INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [StudentId], [ProjectId], [SubmittedDate]) VALUES (7, 3, 3, NULL)
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [StudentId], [ProjectId], [SubmittedDate]) VALUES (12, 2, 3, CAST(N'2024-04-22' AS Date))
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [StudentId], [ProjectId], [SubmittedDate]) VALUES (13, 4, 5, NULL)
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [StudentId], [ProjectId], [SubmittedDate]) VALUES (14, 4, 6, NULL)
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [StudentId], [ProjectId], [SubmittedDate]) VALUES (15, 4, 3, CAST(N'2024-04-22' AS Date))
INSERT [dbo].[ProjectAssignments] ([ProjectAssignmentId], [StudentId], [ProjectId], [SubmittedDate]) VALUES (17, 7, 5, NULL)
SET IDENTITY_INSERT [dbo].[ProjectAssignments] OFF
GO
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([ProjectId], [ProjectTitle], [DueDate]) VALUES (3, N'Review for Final Exam', CAST(N'2024-04-22' AS Date))
INSERT [dbo].[Projects] ([ProjectId], [ProjectTitle], [DueDate]) VALUES (5, N'ASP.NET Web Application', CAST(N'2024-04-24' AS Date))
INSERT [dbo].[Projects] ([ProjectId], [ProjectTitle], [DueDate]) VALUES (6, N'Android Mobile Application', CAST(N'2024-04-25' AS Date))
INSERT [dbo].[Projects] ([ProjectId], [ProjectTitle], [DueDate]) VALUES (7, N'React Portfolio', CAST(N'2024-04-30' AS Date))
SET IDENTITY_INSERT [dbo].[Projects] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [UserType]) VALUES (1, N'Mary', N'Brown', N'mary.teacher', N'12345678', N'Teacher')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [UserType]) VALUES (2, N'Julia', N'Wei', N'julia.student', N'12345678', N'Student')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [UserType]) VALUES (3, N'Jack', N'Green', N'jack.student', N'12345678', N'Student')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [UserType]) VALUES (4, N'Ayrton Senna', N'Seraphim do Amaral', N'ayrton.student', N'12345678', N'Student')
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [UserName], [Password], [UserType]) VALUES (7, N'Victor Hugo', N'De Souza', N'victor.student', N'12345678', N'Student')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[ProjectAssignments]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAssignments_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[ProjectAssignments] CHECK CONSTRAINT [FK_ProjectAssignments_Projects]
GO
ALTER TABLE [dbo].[ProjectAssignments]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAssignments_Users] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ProjectAssignments] CHECK CONSTRAINT [FK_ProjectAssignments_Users]
GO
USE [master]
GO
ALTER DATABASE [SMTIStudent-ProjectManagement] SET  READ_WRITE 
GO
