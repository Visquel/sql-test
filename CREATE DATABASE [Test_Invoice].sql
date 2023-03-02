CREATE DATABASE [Test_Invoice]
GO

USE [Test_Invoice]
GO

/****** Object: Table [dbo].[Customers] Script Date: 1/31/2022 1:00:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customers](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [CustName] [nvarchar](70) NOT NULL,
    [Adress] [nvarchar](120) NOT NULL,
    [Status] [bit] NOT NULL,
    [CustomerTypeId] [int] NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED
    (
    [Id] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[CustomerTypes] Script Date: 1/31/2022 1:00:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustomerTypes](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Description] [nvarchar](70) NOT NULL,
    CONSTRAINT [PK_CustomerType] PRIMARY KEY CLUSTERED
    (
    [Id] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
GO

/****** Object: Table [dbo].[Invoice] Script Date: 1/31/2022 1:00:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Invoice](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [CustomerId] [int] NOT NULL,
    [TotalItbis] [money] NOT NULL,
    [SubTotal] [money] NOT NULL,
    [Total] [money] NOT NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED
    (
    [Id] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
GO

/****** Object: Table [dbo].[InvoiceDetail] Script Date: 1/31/2022 1:00:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InvoiceDetail](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [CustomerId] [int] NOT NULL,
    [Qty] [int] NOT NULL,
    [Price] [money] NOT NULL,
    [TotalItbis] [money] NOT NULL,
    [SubTotal] [money] NOT NULL,
    [Total] [money] NOT NULL,
    CONSTRAINT [PK_InvoiceDetail] PRIMARY KEY CLUSTERED
    ([Id] ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
    ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_Status] DEFAULT ((1)) FOR [Status]
GO

ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustomerType] DEFAULT ((1)) FOR
[CustomerTypeId]
GO

ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [DF_Invoice_TotalItbis] DEFAULT ((0)) FOR [TotalItbis]
GO

ALTER TABLE [dbo].[InvoiceDetail] ADD CONSTRAINT [DF_InvoiceDetail_TotalItbis1] DEFAULT ((0)) FOR [Qty]
GO

ALTER TABLE [dbo].[InvoiceDetail] ADD CONSTRAINT [DF_InvoiceDetail_TotalItbis] DEFAULT ((0)) FOR [TotalItbis]
GO

ALTER TABLE [dbo].[Customers] WITH CHECK ADD CONSTRAINT [FK_Customers_CustomerTypes] FOREIGN KEY([CustomerTypeId])
REFERENCES [dbo].[CustomerTypes] ([Id])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_CustomerTypes]
GO

ALTER TABLE [dbo].[Invoice] WITH CHECK ADD CONSTRAINT [FK_Invoice_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customers]
GO

ALTER TABLE [dbo].[InvoiceDetail] WITH CHECK ADD CONSTRAINT [FK_InvoiceDetail_Invoice] FOREIGN
KEY([CustomerId])
REFERENCES [dbo].[Invoice] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[InvoiceDetail] CHECK CONSTRAINT [FK_InvoiceDetail_Invoice]
GO



-- CRUD test Operations


-- CREATE 

INSERT INTO Invoice (Id, CustomerId, TotalItbis, SubTotal, Total)
 VALUES 
('1', '100', '600' '1000', '1600'),
('2', '200', '800' '2000', '2800'),
('3', '300', '900' '3000', '3900');
commit;


-- UPDATE

UPDATE Invoice
SET CustomerId = '500' , TotalItbis = '5000' , SubTotal = '10000', Total= '15000'
WHERE ID = 3;


-- READ

SELECT * 
FROM InvoiceDetail
Where CustomerId = 2;


SELECT i.ID, i.CustomerId, i.TotalItbis, id.Total as Total_Invoice
FROM Invoice i
INNER JOIN InvoiceDetail id on i.ID = id.ID
WHERE i.ID = 1
ORDER BY i.ID;


-- DELETE

DELETE TOP(1) FROM Invoice
WHERE ID = 1;
