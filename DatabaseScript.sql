USE [master]
GO
/****** Object:  Database [LibraryManagementSystem]    Script Date: 19-11-2020 14:32:37 ******/
CREATE DATABASE [LibraryManagementSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LibraryManagementSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LibraryManagementSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LibraryManagementSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LibraryManagementSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LibraryManagementSystem] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryManagementSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryManagementSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryManagementSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LibraryManagementSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryManagementSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [LibraryManagementSystem] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryManagementSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryManagementSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryManagementSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryManagementSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryManagementSystem] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LibraryManagementSystem', N'ON'
GO
ALTER DATABASE [LibraryManagementSystem] SET QUERY_STORE = OFF
GO
USE [LibraryManagementSystem]
GO
/****** Object:  Table [dbo].[LMS_tbl_Author]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_tbl_Author](
	[Author_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Address] [varchar](250) NULL,
	[PhoneNumber] [bigint] NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_LMS_tbl_Author] PRIMARY KEY CLUSTERED 
(
	[Author_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_tbl_Books]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_tbl_Books](
	[Book_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Author] [int] NULL,
	[Publisher] [int] NULL,
	[IsDeleted] [int] NULL,
	[IsLended] [int] NULL,
 CONSTRAINT [PK_LMS_tbl_Books] PRIMARY KEY CLUSTERED 
(
	[Book_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_tbl_Publisher]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_tbl_Publisher](
	[Publisher_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[OwnerName] [nvarchar](250) NULL,
	[PhoneNumber] [nvarchar](250) NULL,
	[IsDeleted] [int] NULL,
	[Address] [varchar](250) NULL,
 CONSTRAINT [PK_LMS_tbl_Publisher] PRIMARY KEY CLUSTERED 
(
	[Publisher_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_tbl_User]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_tbl_User](
	[User_Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NULL,
	[Password] [varchar](250) NULL,
	[Name] [varchar](200) NULL,
	[PhoneNumber] [bigint] NULL,
	[IsDeleted] [int] NULL,
	[UserType] [int] NULL,
 CONSTRAINT [PK_LMS_tbl_User] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_CheckLoginStatus]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vignesh,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_CheckLoginStatus] 
	-- Add the parameters for the stored procedure here
	@UserName varchar(250),
	@Password varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Count INT;
    -- Insert statements for procedure here
	SELECT @Count= count(*) from LMS_tbl_User where UserName=@UserName and Password=@Password and IsDeleted=0

	if(@Count)>0
	Begin
	Select User_Id,UserType from LMS_tbl_User where UserName=@UserName and Password=@Password and IsDeleted=0
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_DeleteAuthor]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vignesh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_DeleteAuthor] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update LMS_tbl_Author set IsDeleted=1 where Author_Id=@Id
	Select 'Success'
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_DeleteBook]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_DeleteBook] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update LMS_tbl_Books set IsDeleted=1 where Book_Id=@Id
	Select 'Success'
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_DeletePublisher]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_DeletePublisher]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update LMS_tbl_Publisher set IsDeleted=1 where Publisher_Id=@Id
	Select 'Success'
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_DeleteUser]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vignesh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_DeleteUser]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update LMS_tbl_User set IsDeleted=1 where User_Id=@Id
	Select 'Success'
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_GetAllAuthor]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_GetAllAuthor] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;
	if(@Id=0)
	Begin
    -- Insert statements for procedure here
	SELECT * from LMS_tbl_Author where IsDeleted=0
	End
	Else
	Begin
	SELECT * from LMS_tbl_Author where IsDeleted=0 and Author_Id=@Id
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_GetAllBook]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_GetAllBook]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@Id=0)
	Begin
    -- Insert statements for procedure here
	SELECT b.Book_Id,b.Name,a.Name as 'Author', p.Name as 'Publisher',b.IsLended from LMS_tbl_Books b left join LMS_tbl_Author a on a.Author_Id=b.Author left join LMS_tbl_Publisher p
	on p.Publisher_Id=b.Publisher where b.IsDeleted=0
	End
	Else
	Begin
	SELECT * from LMS_tbl_Books where IsDeleted=0 and Book_Id=@Id
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_GetAllPublisher]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_GetAllPublisher]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;
	if(@Id=0)
	Begin
    -- Insert statements for procedure here
	SELECT * from LMS_tbl_Publisher where IsDeleted=0
	End
	Else
	Begin
	SELECT * from LMS_tbl_Publisher where IsDeleted=0 and Publisher_Id=@Id
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_GetAllUser]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vignesh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_GetAllUser] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if(@Id=0)
	Begin
    -- Insert statements for procedure here
	SELECT * from LMS_tbl_User where IsDeleted=0
	End
	Else
	Begin
	SELECT * from LMS_tbl_User where IsDeleted=0 and User_Id=@Id
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_LendBook]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_LendBook]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Count INT;
    -- Insert statements for procedure here
	Select @Count=Count(*) from LMS_tbl_Books where Book_Id=@Id and IsLended=0
	if(@Count>0)
	Begin
	Update LMS_tbl_Books set IsLended=1 where Book_Id=@Id
	Select 'Success'
	End
	Else
	Select 'Failed'
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_SaveAuthor]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_SaveAuthor]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Name varchar(250),
	@Address varchar(250),
	@PhoneNumber Bigint
	As
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@Id=0)Begin
	Insert into LMS_tbl_Author(Name,PhoneNumber,Address,IsDeleted)values(@Name,@PhoneNumber,@Address,0)
	Select 'save'
	End
	Else Begin
	Update LMS_tbl_Author set Name=@Name,PhoneNumber=@PhoneNumber,Address=@Address where Author_Id=@Id
	Select 'update'
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_SaveBook]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_SaveBook] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@Name varchar(250),
	@Author int,
	@Publisher int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@Id=0)Begin
	Insert into LMS_tbl_Books(Name,Author,Publisher,IsDeleted,IsLended)values(@Name,@Author,@Publisher,0,0)
	Select 'save'
	End
	Else Begin
	Update LMS_tbl_Books set Name=@Name,Author=@Author,Publisher=@Author where Book_Id=@Id
	Select 'update'
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_SavePublisher]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_SavePublisher]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Name varchar(250),
	@OwnerName varchar(250),
	@Address varchar(250),
	@PhoneNumber Bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@Id=0)Begin
	Insert into LMS_tbl_Publisher(Name,OwnerName,PhoneNumber,Address,IsDeleted)values(@Name,@OwnerName,@PhoneNumber,@Address,0)
	Select 'save'
	End
	Else Begin
	Update LMS_tbl_Publisher set Name=@Name,OwnerName=@OwnerName,PhoneNumber=@PhoneNumber,Address=@Address where Publisher_Id=@Id
	Select 'update'
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_SaveUser]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Vignesh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_SaveUser] 
	-- Add the parameters for the stored procedure here
	@Id int,
	@Name varchar(250),
	@PhoneNumber Bigint,
	@UserName varchar(250),
	@Password varchar(250)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@Id=0)Begin
	Insert into LMS_tbl_User(Name,PhoneNumber,UserName,Password,IsDeleted,UserType)values(@Name,@PhoneNumber,@UserName,@Password,0,1)
	Select 'save'
	End
	Else Begin
	Update LMS_tbl_User set Name=@Name,PhoneNumber=@PhoneNumber,Password=@Password,UserName=@UserName where User_Id=@Id
	Select 'update'
	End
END
GO
/****** Object:  StoredProcedure [dbo].[LMS_sp_SearchBook]    Script Date: 19-11-2020 14:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LMS_sp_SearchBook]
	-- Add the parameters for the stored procedure here
	@Name varchar(250),
	@Author varchar(250),
	@Publisher varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @tbl_name TABLE (
    Book_Id int,
	Name varchar(250),
	Author varchar(250),
	Publisher varchar(250),
	IsLended int
);
DECLARE @tbl_Author TABLE (
    Book_Id int,
	Name varchar(250),
	Author varchar(250),
	Publisher varchar(250),
	IsLended int
);
DECLARE @tbl_Publisher TABLE (
    Book_Id int,
	Name varchar(250),
	Author varchar(250),
	Publisher varchar(250),
	IsLended int
);
    -- Insert statements for procedure here
	if(@Name ='')
	Begin
	Insert into @tbl_name SELECT b.Book_Id,b.Name,a.Name as 'Author', p.Name as 'Publisher',b.IsLended from LMS_tbl_Books b left join LMS_tbl_Author a on a.Author_Id=b.Author left join LMS_tbl_Publisher p
	on p.Publisher_Id=b.Publisher where b.IsDeleted=0
	End
	Else Begin
	Insert into @tbl_name SELECT b.Book_Id,b.Name,a.Name as 'Author', p.Name as 'Publisher',b.IsLended from LMS_tbl_Books b left join LMS_tbl_Author a on a.Author_Id=b.Author left join LMS_tbl_Publisher p
	on p.Publisher_Id=b.Publisher where b.IsDeleted=0 and b.Name=@Name
	End
	if(@Author ='') Begin
	Insert into @tbl_Author Select * from @tbl_name
	End
	Else
	Begin
	Insert into @tbl_Author Select * from @tbl_name where Author=@Author
	End
	if(@Publisher ='') Begin
	Insert into @tbl_Publisher Select * from @tbl_Author
	End
	Else
	Begin
	Insert into @tbl_Publisher Select * from @tbl_Author where Publisher=@Publisher
	End
	SELECT * from  @tbl_Publisher
END
GO
USE [master]
GO
ALTER DATABASE [LibraryManagementSystem] SET  READ_WRITE 
GO

USE [LibraryManagementSystem]
GO
Insert into LMS_tbl_User(Name,Password,UserType,IsDeleted,PhoneNumber)values('admin','admin',0,0,888888888)
GO
