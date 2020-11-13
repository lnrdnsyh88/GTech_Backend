USE [master]
GO
/****** Object:  Database [GTECH_DB]    Script Date: 13/11/2020 10:44:30 ******/
CREATE DATABASE [GTECH_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GTECH_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GTECH_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GTECH_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\GTECH_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [GTECH_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GTECH_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GTECH_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GTECH_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GTECH_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GTECH_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GTECH_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GTECH_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GTECH_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GTECH_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GTECH_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GTECH_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GTECH_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GTECH_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GTECH_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GTECH_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GTECH_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GTECH_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GTECH_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GTECH_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GTECH_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GTECH_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GTECH_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GTECH_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GTECH_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GTECH_DB] SET  MULTI_USER 
GO
ALTER DATABASE [GTECH_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GTECH_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GTECH_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GTECH_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GTECH_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GTECH_DB] SET QUERY_STORE = OFF
GO
USE [GTECH_DB]
GO
/****** Object:  User [admin]    Script Date: 13/11/2020 10:44:31 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[CreateIdentifier]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CreateIdentifier]
(
    -- Add the parameters for the function here
    @Name varchar(255),
    @random1 decimal(18,10) ,
    @random2 decimal(18,10)
)
RETURNS varchar(10)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @S VARCHAR(10)
    DECLARE @S1 VARCHAR(1)
    DECLARE @S2 VARCHAR(1)
    DECLARE @len INT
    DECLARE @Random1Fixed INT
    DECLARE @Random2Fixed INT

    declare @alphabet varchar(36) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ23456789'



    SET @alphabet = REPLACE(@alphabet,LEFT(@Name,1),'')

    SELECT @len = len(@alphabet)
    SET @Random1Fixed = ROUND(((@len - 1 -1) * @random1 + 1), 0)
    SET @Random2Fixed = ROUND(((@len - 1 -1) * @random2 + 1), 0)


    SET @S1 = substring(@alphabet, convert(int, @Random1Fixed ), 1)
    SET @S2 = substring(@alphabet, convert(int, @Random2Fixed), 1)

    SET @S = 'GTECH' + @S1 + LEFT(REPLACE(@Name,' ', ''),1) + @S2
    RETURN @S

END
GO
/****** Object:  UserDefinedFunction [dbo].[f_hashString]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_hashString]
(
	@Value AS VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN

	DECLARE @ResultVal AS VARCHAR(100)

	SET @ResultVal = (SELECT HASHBYTES ('MD5', @Value));

	RETURN @ResultVal

END
GO
/****** Object:  Table [dbo].[BankTransferTransaction]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankTransferTransaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionNumber] [varchar](50) NOT NULL,
	[TransactionDate] [datetime] NULL,
	[TransactionAmount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_BankTransferTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eCommerceTransaction]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eCommerceTransaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionNumber] [varchar](50) NULL,
	[TransactionDate] [datetime] NULL,
	[TransactionAmount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_eCommerceTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentGatewayTransaction]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentGatewayTransaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionNumber] [varchar](50) NULL,
	[TransactionDate] [datetime] NULL,
	[TransactionAmount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_PaymentGatewayTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserName] [varchar](50) NOT NULL,
	[UserPassword] [varchar](max) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateBy] [varchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersToken]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersToken](
	[UserName] [varchar](150) NOT NULL,
	[UserToken] [varchar](max) NOT NULL,
	[ExpiredToken] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UsersToken] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BankTransferTransaction] ON 

INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (1, N'1111', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(30000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (2, N'2222', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(35000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (3, N'3333', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (4, N'4444', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(60000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (5, N'5555', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(73000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (6, N'6666', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(75000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (7, N'7777', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (8, N'8888', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(25000.00 AS Decimal(18, 2)))
INSERT [dbo].[BankTransferTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (9, N'9999', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[BankTransferTransaction] OFF
GO
SET IDENTITY_INSERT [dbo].[eCommerceTransaction] ON 

INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (2, N'1111', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(30000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (3, N'2222', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(40000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (4, N'3333', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (5, N'4444', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(60000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (6, N'5555', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(70000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (7, N'6666', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(75000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (8, N'7777', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(15000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (9, N'8888', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(25000.00 AS Decimal(18, 2)))
INSERT [dbo].[eCommerceTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (10, N'9999', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[eCommerceTransaction] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentGatewayTransaction] ON 

INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (1, N'1111', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(30000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (2, N'2222', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(32000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (3, N'3333', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (4, N'4444', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(60000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (5, N'5555', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(73500.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (6, N'6666', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(75000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (7, N'7777', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(12000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (8, N'8888', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(25000.00 AS Decimal(18, 2)))
INSERT [dbo].[PaymentGatewayTransaction] ([TransactionId], [TransactionNumber], [TransactionDate], [TransactionAmount]) VALUES (9, N'9999', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[PaymentGatewayTransaction] OFF
GO
INSERT [dbo].[Users] ([UserName], [UserPassword], [Name], [IsActive], [CreatedDate], [CreatedBy], [UpdateDate], [UpdateBy]) VALUES (N'alan', N'º¸‘Þ—šç‘Ï£{üˆížˆ', N'Alan Ardiansyah', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserName], [UserPassword], [Name], [IsActive], [CreatedDate], [CreatedBy], [UpdateDate], [UpdateBy]) VALUES (N'alan123', N'º¸‘Þ—šç‘Ï£{üˆížˆ', N'alan123', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserName], [UserPassword], [Name], [IsActive], [CreatedDate], [CreatedBy], [UpdateDate], [UpdateBy]) VALUES (N'alan1234', N't#Fhz¶ Þ$îø²Pƒ', N'alan1234', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserName], [UserPassword], [Name], [IsActive], [CreatedDate], [CreatedBy], [UpdateDate], [UpdateBy]) VALUES (N'alan123456', N'¨éì&C‰…`Õ€\%É', N'alan123456', 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[UsersToken] ([UserName], [UserToken], [ExpiredToken], [IsActive]) VALUES (N'alan', N'GTECHLAF', CAST(N'2020-11-13T11:41:55.970' AS DateTime), 1)
INSERT [dbo].[UsersToken] ([UserName], [UserToken], [ExpiredToken], [IsActive]) VALUES (N'alan123456', N'GTECH3aU', CAST(N'2020-11-13T11:37:16.440' AS DateTime), 1)
GO
/****** Object:  StoredProcedure [dbo].[spInsertUser]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertUser]
(
	@UserName AS VARCHAR(50), 
	@UserPassword AS VARCHAR(MAX),
	@Name AS VARCHAR(150),
	@OutputFlag AS BIT OUTPUT,
	@OutputMessage AS VARCHAR(250) OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	IF EXISTS (SELECT TOP 1 'x' FROM Users WHERE UserName = @UserName)
	BEGIN
		SET @OutputFlag = 0
		SET @OutputMessage = 'Username : ' + @UserName + ' already exists, please choose another username !'
	END
	ELSE
	BEGIN
		INSERT INTO Users(UserName, UserPassword, Name, IsActive)
		SELECT @UserName, dbo.f_hashString(@UserPassword), @Name, 1

		SET @OutputFlag = 1
		SET @OutputMessage = 'Username : ' + @UserName + ' successfully created !'
	END

END
GO
/****** Object:  StoredProcedure [dbo].[spReconcileTransaction]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spReconcileTransaction]
(
	@DateStart AS DATETIME,
	@DateEnd AS DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		a.TransactionDate,
		a.TransactionNumber,
		a.TransactionAmount eCommerceAmount,
		b.TransactionAmount PaymentGatewayAmount,
		c.TransactionAmount BankTransferAmount, 
		CASE 
			WHEN (a.TransactionAmount = b.TransactionAmount) AND (a.TransactionAmount = c.TransactionAmount) THEN 1
			ELSE 0
		END isMatched
	FROM eCommerceTransaction a
	LEFT JOIN PaymentGatewayTransaction b
		ON a.TransactionNumber = b.TransactionNumber
			AND a.TransactionDate = b.TransactionDate
	LEFT JOIN BankTransferTransaction c
		ON a.TransactionNumber = c.TransactionNumber
			AND a.TransactionDate = c.TransactionDate
	WHERE 
		a.TransactionDate BETWEEN @DateStart AND @DateEnd
	ORDER BY
		a.TransactionDate,
		a.TransactionNumber
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectUsers]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSelectUsers]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT a.UserName, a.Name FROM Users a
	WHERE a.IsActive = 1
	ORDER BY a.UserName
END
GO
/****** Object:  StoredProcedure [dbo].[SpUsersLogon]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpUsersLogon]
(
	@UserName AS VARCHAR(150),
	@UserPassword AS VARCHAR(MAX),
	@OutputFlag AS BIT OUTPUT,
	@OutputMEssage AS VARCHAR(MAX) OUTPUT,
	@OutputToken AS VARCHAR(MAX) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Name AS VARCHAR(150)
	DECLARE @Token AS VARCHAR(MAX)

	SELECT @Name = a.Name, @Token = dbo.CreateIdentifier(a.Name, RAND(), RAND()) FROM Users a
	WHERE a.UserName = @UserName AND a.UserPassword = dbo.f_hashString(@UserPassword)


	IF TRIM(@Token) != ''
	BEGIN 
		IF EXISTS (SELECT TOP 1 'x' FROM UsersToken WHERE UserName = @UserName)
		BEGIN 
			UPDATE UsersToken
			SET
				UserToken = @Token,
				ExpiredToken = DATEADD(HOUR, 1, GETDATE()),
				IsActive = 1
			WHERE
				UserName = @UserName
		END
		ELSE
		BEGIN
			INSERT UsersToken (UserName, UserToken, ExpiredToken, IsActive)
			SELECT @UserName, @Token, DATEADD(HOUR, 1, GETDATE()), 1
		END

		SET @OutputFlag = 1
		SET @OutputMEssage = 'Logon Success'
		SET @OutputToken = @Token
	END
	ELSE
	BEGIN
		UPDATE UsersToken
		SET
			UserToken = '',
			ExpiredToken = GETDATE(),
			IsActive = 0
		WHERE
			UserName = @UserName

		SET @OutputFlag = 0
		SET @OutputMEssage = 'Logon Fail, Username or Userpassword invalid !'
		SET @OutputToken = ''
	END

END
GO
/****** Object:  StoredProcedure [dbo].[spValidateToken]    Script Date: 13/11/2020 10:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spValidateToken]
(
	@UserName AS VARCHAR(150),
	@UserToken AS VARCHAR(MAX),
	@OutputFlag AS BIT OUTPUT,
	@OutputMessage AS VARCHAR(MAX) OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	IF EXISTS (SELECT TOP 1 'x' FROM UsersToken a WHERE a.UserName = @UserName AND a.UserToken = @UserToken AND a.ExpiredToken >= GETDATE() AND a.IsActive = 1)
	BEGIN 
		SET @OutputFlag = 1
		SET @OutputMessage = 'Token succefully validated'

		UPDATE UsersToken
		SET
			UserToken = @UserToken,
			ExpiredToken = DATEADD(HOUR, 1, GETDATE()),
			IsActive = 1
		WHERE
			UserName = @UserName
	END
	ELSE
	BEGIN 
		SET @OutputFlag = 0
		SET @OutputMessage = 'Token failed to validate, token expired (1 Hout) or username used by others. You can relogin.'
	END

END
GO
USE [master]
GO
ALTER DATABASE [GTECH_DB] SET  READ_WRITE 
GO
