USE [master]
GO
/****** Object:  Database [UNIFOOD]    Script Date: 18.06.2023 23:14:15 ******/
CREATE DATABASE [UNIFOOD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UNIFOOD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\UNIFOOD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UNIFOOD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\UNIFOOD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [UNIFOOD] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UNIFOOD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UNIFOOD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UNIFOOD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UNIFOOD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UNIFOOD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UNIFOOD] SET ARITHABORT OFF 
GO
ALTER DATABASE [UNIFOOD] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [UNIFOOD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UNIFOOD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UNIFOOD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UNIFOOD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UNIFOOD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UNIFOOD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UNIFOOD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UNIFOOD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UNIFOOD] SET  ENABLE_BROKER 
GO
ALTER DATABASE [UNIFOOD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UNIFOOD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UNIFOOD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UNIFOOD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UNIFOOD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UNIFOOD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UNIFOOD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UNIFOOD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UNIFOOD] SET  MULTI_USER 
GO
ALTER DATABASE [UNIFOOD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UNIFOOD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UNIFOOD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UNIFOOD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UNIFOOD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UNIFOOD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [UNIFOOD] SET QUERY_STORE = ON
GO
ALTER DATABASE [UNIFOOD] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [UNIFOOD]
GO
/****** Object:  User [unifood]    Script Date: 18.06.2023 23:14:15 ******/
CREATE USER [unifood] FOR LOGIN [unifood] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedTableType [dbo].[OrderDetails]    Script Date: 18.06.2023 23:14:15 ******/
CREATE TYPE [dbo].[OrderDetails] AS TABLE(
	[OrderNo] [varchar](max) NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UserId] [int] NULL,
	[Status] [varchar](50) NULL,
	[PaymentId] [int] NULL,
	[OrderDate] [datetime] NULL
)
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[ImageUrl] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[RestaurantId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Subject] [varchar](200) NULL,
	[Message] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ProductId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourites]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favourites](
	[FavId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[UserId] [int] NULL,
	[CreateDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[FavId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [varchar](max) NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[UserId] [int] NULL,
	[Status] [varchar](50) NULL,
	[PaymentId] [int] NULL,
	[OrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[CardNo] [varchar](50) NULL,
	[ExpiryDate] [varchar](50) NULL,
	[CvvNo] [int] NULL,
	[Address] [varchar](max) NULL,
	[PaymentMode] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[Price] [decimal](18, 2) NULL,
	[Quantity] [int] NULL,
	[ImageUrl] [varchar](max) NULL,
	[CategoryId] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[RestaurantId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[RatingId] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [float] NULL,
	[ProductId] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RatingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[RestaurantId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Username] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Address] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[Password] [varchar](50) NULL,
	[ImageUrl] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RestaurantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Username] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Address] [varchar](max) NULL,
	[PostCode] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[ImageUrl] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[TeacherCard] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Restaurants] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([RestaurantId])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Restaurants]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Products]
GO
ALTER TABLE [dbo].[Favourites]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favourites]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([PaymentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Restaurants] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([RestaurantId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Restaurants]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[Cart_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Cart_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ProductId INT = NULL,
	@Quantity INT = NULL,
	@UserId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --SELECT
    IF @Action = 'SELECT'
      BEGIN
			SELECT c.ProductId,p.Name,p.ImageUrl,p.Price,c.Quantity,c.Quantity as Qty,p.Quantity as PrdQty FROM dbo.Carts c
			INNER JOIN dbo.Products p ON p.ProductId = c.ProductId
			WHERE c.UserId = @UserId
      END
 
    --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Carts(ProductId, Quantity, UserId)
            VALUES (@ProductId, @Quantity, @UserId)
      END
 
    --UPDATE
    IF @Action = 'UPDATE'
      BEGIN		
			UPDATE dbo.Carts
			SET Quantity = @Quantity
			WHERE ProductId = @ProductId and UserId = @UserId		
      END
 
    --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Carts WHERE ProductId = @ProductId and UserId = @UserId
      END

	--GETBYID
    IF @Action = 'GETBYID'
      BEGIN
			SELECT * FROM dbo.Carts WHERE ProductId = @ProductId and UserId = @UserId
      END

END
GO
/****** Object:  StoredProcedure [dbo].[Category_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Category_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@CategoryId INT = NULL,
	@RestaurantId INT = NULL,
	@Name VARCHAR(100) = NULL,
	@IsActive BIT = false,
	@ImageUrl VARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT * FROM dbo.Categories ORDER BY CreatedDate DESC
      END
 
    IF @Action = 'SELEC'
      BEGIN
            SELECT * FROM dbo.Categories Where RestaurantId=@RestaurantId ORDER BY CreatedDate DESC
      END
    --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Categories(Name, ImageUrl,RestaurantId, IsActive, CreatedDate)
            VALUES (@Name, @ImageUrl,@RestaurantId, @IsActive, GETDATE())
      END
 
    --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF @UPDATE_IMAGE = 'NO'
			BEGIN
				UPDATE dbo.Categories
				SET Name = @Name, IsActive = @IsActive, RestaurantId=@RestaurantId
				WHERE CategoryId = @CategoryId
			END
		ELSE
			BEGIN
				UPDATE dbo.Categories
				SET Name = @Name, ImageUrl = @ImageUrl, IsActive = @IsActive, RestaurantId=@RestaurantId
				WHERE CategoryId = @CategoryId
			END
      END
 
    --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Categories WHERE CategoryId = @CategoryId
      END

	--GETBYID
    IF @Action = 'GETBYID'
      BEGIN
            SELECT * FROM dbo.Categories WHERE CategoryId = @CategoryId
      END

	  IF @Action = 'GETBYI'
      BEGIN
            SELECT * FROM dbo.Categories WHERE CategoryId = @CategoryId and RestaurantId=@RestaurantId
      END

END


GO
/****** Object:  StoredProcedure [dbo].[ContactSp]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ContactSp]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ContactId INT = NULL,
	@Name VARCHAR(50) = NULL,
	@Email VARCHAR(50) = NULL,
	@Subject VARCHAR(200) = NULL,
	@Message VARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --INSERT
	IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Contact(Name, Email, Subject, Message, CreatedDate)
            VALUES (@Name, @Email, @Subject, @Message, GETDATE())
      END

	--SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],* FROM dbo.Contact
      END

	--DELETE BY ADMIN
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Contact WHERE ContactId = @ContactId
      END

END



GO
/****** Object:  StoredProcedure [dbo].[Dashboard]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Dashboard]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --1.Categories
	IF @Action = 'CATEGORY'
	BEGIN
		SELECT COUNT(*) FROM dbo.Categories
	END

	--2.Products
	IF @Action = 'PRODUCT'
	BEGIN
		SELECT COUNT(*) FROM dbo.Products
	END

	--3.Orders
	IF @Action = 'ORDER'
	BEGIN
		SELECT COUNT(*) FROM dbo.Orders
	END

	--4.Orders Delivered
	IF @Action = 'DELIVERED'
	BEGIN
		SELECT COUNT(*) FROM dbo.Orders 
		WHERE Status = 'Delivered'
	END

	--5.Orders Pending
	IF @Action = 'PENDING'
	BEGIN
		SELECT COUNT(*) FROM dbo.Orders 
		WHERE Status IN ('Pending','Dispatched')
	END

	--6.Users
	IF @Action = 'USER'
	BEGIN
		SELECT COUNT(*) FROM dbo.Users
	END

	--Sold Item Cost
	IF @Action = 'SOLDAMOUNT'
	BEGIN
		SELECT SUM(o.Quantity * p.Price) FROM Orders o
		INNER JOIN Products p ON p.ProductId = o.ProductId
	END

	--Contact
	IF @Action = 'CONTACT'
	BEGIN
		SELECT COUNT(*) FROM dbo.Contact
	END

END


GO
/****** Object:  StoredProcedure [dbo].[Fav_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Fav_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ProductId INT = NULL,
	@UserId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


 
    --INSERT
    IF @Action = 'INSERT'
		IF NOT EXISTS(Select * from Favourites WHERE UserId = @UserId AND ProductId = @ProductId)
		  BEGIN
				INSERT INTO dbo.Favourites(ProductId, UserId)
				VALUES (@ProductId, @UserId)
		  END

    --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Favourites WHERE ProductId = @ProductId and UserId = @UserId
      END

	--GETBYID
    IF @Action = 'GETBYID'
           BEGIN
			SELECT pr.ProductId, pr.Name as ProductName, pr.ImageUrl as ImageUrl1 FROM dbo.Favourites f
			INNER JOIN Products pr ON pr.ProductId = f.ProductId
			WHERE UserId = @UserId
			
      END

END


GO
/****** Object:  StoredProcedure [dbo].[Invoice]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Invoice]
	@Action VARCHAR(10),
	@PaymentId INT = NULL,
	@UserId INT = NULL,
	@RestaurantId INT = NULL,
	@OrderDetailsId INT = NULL,
	@Status VARCHAR(50) = NULL,
	@OrderNo VARCHAR(Max) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--GET INVOICE BY ID
    IF @Action = 'INVOICBYID'
      BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo], o.OrderNo, p.Name, p.Price, o.Quantity,
			(p.Price * o.Quantity) as TotalPrice, o.OrderDate,o.Status FROM Orders o
			INNER JOIN Products p ON p.ProductId = o.ProductId
			WHERE o.PaymentId = @PaymentId AND o.UserId = @UserId
	  END

	--SELECT ORDER HISTORY
    IF @Action = 'ODRHISTORY'
      BEGIN
			SELECT DISTINCT o.PaymentId,p.PaymentMode,p.CardNo FROM Orders o
            INNER JOIN Payment p on p.PaymentId = o.PaymentId
            WHERE o.UserId = @UserId
	  END

	--GET ORDER STATUS
	IF @Action = 'GETSTATUS'
      BEGIN
			SELECT o.OrderDetailsId, o.OrderNo, (pr.Price * o.Quantity) as TotalPrice, o.Status,
			o.OrderDate, p.PaymentMode, pr.Name FROM Orders o
			INNER JOIN Payment p ON p.PaymentId = o.PaymentId
			INNER JOIN Products pr ON pr.ProductId = o.ProductId
	  END

	  IF @Action = 'GETSTATU'
      BEGIN
			SELECT o.OrderDetailsId, o.OrderNo, (pr.Price * o.Quantity) as TotalPrice, o.Status,
			o.OrderDate, p.PaymentMode, pr.Name FROM Orders o
			INNER JOIN Payment p ON p.PaymentId = o.PaymentId
			INNER JOIN Products pr ON pr.ProductId = o.ProductId and pr.RestaurantId =@RestaurantId
	  END

	--GET ORDER STATUS BY ID
	IF @Action = 'STATUSBYID'
      BEGIN
			SELECT OrderDetailsId, Status FROM Orders
            WHERE OrderDetailsId = @OrderDetailsId
	  END

	--UPDATE ORDER STATUS
    IF @Action = 'UPDTSTATUS'
      BEGIN
			UPDATE dbo.Orders
			SET Status = @Status WHERE OrderDetailsId = @OrderDetailsId
	  END
	IF @Action = 'CNCLSTATUS'
	BEGIN
		UPDATE dbo.Products SET Quantity = Quantity+(SELECT o.Quantity FROM Orders o
			INNER JOIN Products pr ON pr.ProductId = o.ProductId
			WHERE o.OrderNo = @OrderNo)
		WHERE ProductId = (
			SELECT pr.ProductId FROM Orders o
			INNER JOIN Products pr ON pr.ProductId = o.ProductId
			WHERE o.OrderNo = @OrderNo)
	  END
	  BEGIN
			UPDATE dbo.Orders
			SET Status = @Status WHERE OrderNo = @OrderNo
	  END
END


GO
/****** Object:  StoredProcedure [dbo].[Product_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Product_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ProductId INT = NULL,
	@RestaurantId INT =NULL,
	@Name VARCHAR(100) = NULL,
	@Description VARCHAR(MAX) = NULL,
	@Price DECIMAL(18,2) = 0,
	@Quantity INT = NULL,
	@ImageUrl VARCHAR(MAX) = NULL,
	@CategoryId INT = NULL,
	@IsActive BIT = false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT p.*,c.Name AS CategoryName FROM dbo.Products p
			INNER JOIN dbo.Categories c ON c.CategoryId = p.CategoryId ORDER BY p.CreatedDate DESC
      END

    IF @Action = 'SELEC'
      BEGIN
            SELECT * from dbo.Products where RestaurantId=@RestaurantId
      END
	
    --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Products(Name, Description, Price, Quantity, ImageUrl, CategoryId, RestaurantId, IsActive, CreatedDate)
            VALUES (@Name, @Description, @Price, @Quantity, @ImageUrl, @CategoryId, @RestaurantId, @IsActive, GETDATE())
      END
 
    --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF @UPDATE_IMAGE = 'NO'
			BEGIN
				UPDATE dbo.Products
				SET Name = @Name, Description = @Description, Price = @Price, Quantity = @Quantity, RestaurantId = @RestaurantId,
				CategoryId = @CategoryId, IsActive = @IsActive
				WHERE ProductId = @ProductId
			END
		ELSE
			BEGIN
				UPDATE dbo.Products
				SET Name = @Name, Description = @Description, Price = @Price, Quantity = @Quantity, RestaurantId = @RestaurantId,
				ImageUrl = @ImageUrl, CategoryId = @CategoryId, IsActive = @IsActive
				WHERE ProductId = @ProductId
			END
      END

	--UPDATE QUANTITY
    IF @Action = 'QTYUPDATE'
	BEGIN
		UPDATE dbo.Products SET Quantity = @Quantity
		WHERE ProductId = @ProductId
	END
 
    --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Products WHERE ProductId = @ProductId
      END
	  
	--GETBYID
    IF @Action = 'GETBYID'
      BEGIN
            SELECT * FROM dbo.Products WHERE ProductId = @ProductId
      END

	  IF @Action = 'GETBYI'
      BEGIN
            SELECT * FROM dbo.Products WHERE ProductId = @ProductId and RestaurantId=@RestaurantId
      END

END


GO
/****** Object:  StoredProcedure [dbo].[Rate_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rate_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ProductId INT = NULL,
	@Rating INT = NULL,
	@UserId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --SELECT
    IF @Action = 'SELECT'
      BEGIN
			SELECT r.ProductId,p.Name,p.ImageUrl,p.Price,p.Quantity as PrdQty FROM dbo.Rating r
			INNER JOIN dbo.Products p ON p.ProductId = r.ProductId
			WHERE r.UserId = @UserId
      END
 
    --INSERT
    IF @Action = 'INSERT'
		IF NOT EXISTS(Select * from Rating WHERE UserId = @UserId AND ProductId = @ProductId)
			  BEGIN
					INSERT INTO dbo.Rating(ProductId,Rating,UserId)
					VALUES (@ProductId,@Rating,@UserId)
			  END
		ELSE
			 BEGIN		
						UPDATE dbo.Rating
						SET Rating = @Rating
						WHERE ProductId = @ProductId and UserId = @UserId		
				 END
 
    --UPDATE
    IF @Action = 'UPDATE'
      BEGIN		
			UPDATE dbo.Rating
			SET Rating = @Rating
			WHERE ProductId = @ProductId and UserId = @UserId		
      END
 
    --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Rating WHERE ProductId = @ProductId and UserId = @UserId
      END

	--GETBYID
    IF @Action = 'GETBYID'
      BEGIN
			SELECT * FROM dbo.Rating WHERE ProductId = @ProductId and UserId = @UserId
      END

	--GETAvg
    IF @Action = 'GetAvg'
      BEGIN
			SELECT AVG(Rating) as AvgRating FROM dbo.Rating WHERE ProductId = @ProductId
      END

END

GO
/****** Object:  StoredProcedure [dbo].[Restaurant_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Restaurant_Crud] 
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20),
	@RestaurantId INT = NULL,
	@Name varchar(50) = null,
	@Username varchar(50) = null,
	@Mobile varchar(50) = null,
	@Email varchar(50) = null,
	@Address varchar(max) = null,
	@Description varchar(max) = null,
	@Password varchar(50) = null,
	@ImageUrl varchar(max) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT FOR LOGIN
    IF @Action = 'SELECT4LOGIN'
      BEGIN
            SELECT * FROM dbo.Restaurants WHERE Username = @Username and Password = @Password
      END

     --Select 
	IF @Action = 'SELECT'
      BEGIN
            SELECT * FROM dbo.Restaurants
      END
	
    -- Insert (REGISTRATION)
	IF @Action = 'INSERT'
		BEGIN
			Insert into dbo.Restaurants(Name,Username,Mobile,Email,Address,Description,Password,ImageUrl,CreatedDate) 
			values (@Name,@Username,@Mobile,@Email,@Address,@Description,@Password,@ImageUrl,GETDATE())
		END

	--UPDATE Restaurant PROFILE
    IF @Action = 'UPDATE'
      BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF @UPDATE_IMAGE = 'NO'
			BEGIN
				UPDATE dbo.Restaurants
				SET Name = @Name, Username = @Username, Mobile = @Mobile, Email = @Email, Address = @Address,
				Description = @Description
				WHERE RestaurantId = @RestaurantId
			END
		ELSE
			BEGIN
				UPDATE dbo.Restaurants
				SET Name = @Name, Username = @Username, Mobile = @Mobile, Email = @Email, Address = @Address,
				Description = @Description, ImageUrl = @ImageUrl
				WHERE RestaurantId = @RestaurantId
			END
      END

	--SELECT FOR ADMIN
	IF @Action = 'SELECT4ADMIN'
		BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],RestaurantId, Name, 
			Username, Email, CreatedDate
			FROM Restaurants
		END

		--GETBYID
    IF @Action = 'GETBYID'
      BEGIN
            SELECT * FROM dbo.Restaurants WHERE RestaurantId = @RestaurantId
      END

	--DELETE BY ADMIN
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Restaurants WHERE RestaurantId = @RestaurantId
      END
END

GO
/****** Object:  StoredProcedure [dbo].[Save_Orders]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Save_Orders] @tblOrders OrderDetails READONLY
AS
BEGIN
      SET NOCOUNT ON;
     
      INSERT INTO Orders(OrderNo, ProductId, Quantity, UserId, Status, PaymentId, OrderDate)
      SELECT OrderNo, ProductId, Quantity, UserId, Status, PaymentId, OrderDate FROM @tblOrders
END


GO
/****** Object:  StoredProcedure [dbo].[Save_Payment]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Save_Payment] 
	@Name VARCHAR(100) = NULL,
	@CardNo VARCHAR(50) = NULL,
	@ExpiryDate VARCHAR(50) = NULL,
	@Cvv INT = NULL,
	@Address VARCHAR(MAX) = NULL,
	@PaymentMode VARCHAR(10) = 'card',
	@InsertedId int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--INSERT
      BEGIN
            INSERT INTO dbo.Payment(Name, CardNo, ExpiryDate, CvvNo, Address, PaymentMode)
            VALUES (@Name, @CardNo, @ExpiryDate, @Cvv, @Address, @PaymentMode)

			SELECT @InsertedId = SCOPE_IDENTITY();
      END
END


GO
/****** Object:  StoredProcedure [dbo].[SellingReport]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SellingReport]
	-- Add the parameters for the stored procedure here
	@FromDate DATE = NULL,
	@ToDate DATE = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Print @FromDate
	Print @ToDate

	SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],u.Name,u.Email,
		SUM(o.Quantity) AS TotalOrders, SUM(o.Quantity * p.Price) AS TotalPrice 
		FROM Orders o
		INNER JOIN Products p ON p.ProductId = o.ProductId
		INNER JOIN Users u ON u.UserId = o.UserId
		WHERE CAST(o.OrderDate AS DATE) BETWEEN @FromDate AND @ToDate
		GROUP BY u.Name, u.Email;	
END




GO
/****** Object:  StoredProcedure [dbo].[User_Crud]    Script Date: 18.06.2023 23:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_Crud] 
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20),
	@UserId INT = NULL,
	@Name varchar(50) = null,
	@Username varchar(50) = null,
	@Mobile varchar(50) = null,
	@Email varchar(50) = null,
	@Address varchar(max) = null,
	@PostCode varchar(50) = null,
	@TeacherCard varchar(50) = null,
	@Password varchar(50) = null,
	@ImageUrl varchar(max) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT FOR LOGIN
    IF @Action = 'SELECT4LOGIN'
      BEGIN
            SELECT * FROM dbo.Users WHERE Username = @Username and Password = @Password
      END

	--SELECT FOR USER PROFILE
    IF @Action = 'SELECT4PROFILE'
      BEGIN
            SELECT * FROM dbo.Users WHERE UserId = @UserId
      END

    -- Insert (REGISTRATION)
	IF @Action = 'INSERT'
		BEGIN
			Insert into dbo.Users(Name,Username,Mobile,Email,Address,PostCode,TeacherCard,Password,ImageUrl,CreatedDate) 
			values (@Name,@Username,@Mobile,@Email,@Address,@PostCode,@TeacherCard,@Password,@ImageUrl,GETDATE())
		END

	--UPDATE USER PROFILE
    IF @Action = 'UPDATE'
      BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF @UPDATE_IMAGE = 'NO'
			BEGIN
				UPDATE dbo.Users
				SET Name = @Name, Username = @Username, Mobile = @Mobile, Email = @Email, Address = @Address,TeacherCard=@TeacherCard,
				PostCode = @PostCode
				WHERE UserId = @UserId
			END
		ELSE
			BEGIN
				UPDATE dbo.Users
				SET Name = @Name, Username = @Username, Mobile = @Mobile, Email = @Email, Address = @Address,TeacherCard=@TeacherCard,
				PostCode = @PostCode, ImageUrl = @ImageUrl
				WHERE UserId = @UserId
			END
      END

	--SELECT FOR ADMIN
	IF @Action = 'SELECT4ADMIN'
		BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],UserId, Name, 
			Username, Email, CreatedDate
			FROM Users
		END
	--DELETE BY ADMIN
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Users WHERE UserId = @UserId
      END

	  IF @Action = 'ISTEACHER'
      BEGIN
            SELECT * FROM Users WHERE UserId = @UserId AND TeacherCard IS NOT NULL;
      END
END

GO
USE [master]
GO
ALTER DATABASE [UNIFOOD] SET  READ_WRITE 
GO
