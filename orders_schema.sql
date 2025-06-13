CREATE TABLE [dbo].[orders_data](
    [order_id] [nvarchar](20) NULL,
    [order_date] [date] NULL,
    [ship_date] [date] NULL,
    [customer_name] [nvarchar](30) NULL,
    [region] [nvarchar](10) NULL,
    [city] [nvarchar](20) NULL,
    [category] [nvarchar](20) NULL,
    [product_id] [nvarchar](50) NULL,
    [sales] [float] NULL,
    [quantity] [float] NULL,
    [profit] [float] NULL
);