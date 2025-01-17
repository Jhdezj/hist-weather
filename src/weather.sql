USE [weather]
GO
/****** Object:  Table [dbo].[cities] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cities](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[id_state] [int] NOT NULL,
	[population] [decimal](18, 0) NOT NULL,
	[id_climate] [int] NOT NULL,
	[latitude] [nchar](10) NOT NULL,
	[longitude] [nchar](10) NOT NULL,
	[climate] [nchar](50) NOT NULL,
 CONSTRAINT [PK_city] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[climates]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[climates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group] [nchar](2) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_climates] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[states]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[states](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[density] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_states] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[weather_icons]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[weather_icons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[day_icon] [varchar](50) NOT NULL,
	[night_icon] [varchar](50) NOT NULL,
	[description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_weather_code] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[weather_readings]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[weather_readings](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](7) NOT NULL,
	[icon_id] [int] NOT NULL,
	[city_id] [int] NOT NULL,
	[temperature] [float] NULL,
	[dew_point] [float] NULL,
	[pressure] [float] NULL,
	[wind_speed] [float] NULL,
	[relative_humidity] [float] NULL,
 CONSTRAINT [PK_weather] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cities]  WITH CHECK ADD  CONSTRAINT [FK_cities_climates] FOREIGN KEY([id_climate])
REFERENCES [dbo].[climates] ([id])
GO
ALTER TABLE [dbo].[cities] CHECK CONSTRAINT [FK_cities_climates]
GO
ALTER TABLE [dbo].[cities]  WITH CHECK ADD  CONSTRAINT [FK_cities_states] FOREIGN KEY([id_state])
REFERENCES [dbo].[states] ([id])
GO
ALTER TABLE [dbo].[cities] CHECK CONSTRAINT [FK_cities_states]
GO
ALTER TABLE [dbo].[weather_readings]  WITH CHECK ADD  CONSTRAINT [FK_weather_readings_cities] FOREIGN KEY([city_id])
REFERENCES [dbo].[cities] ([id])
GO
ALTER TABLE [dbo].[weather_readings] CHECK CONSTRAINT [FK_weather_readings_cities]
GO
ALTER TABLE [dbo].[weather_readings]  WITH CHECK ADD  CONSTRAINT [FK_weather_readings_weather_codes] FOREIGN KEY([icon_id])
REFERENCES [dbo].[weather_icons] ([id])
GO
ALTER TABLE [dbo].[weather_readings] CHECK CONSTRAINT [FK_weather_readings_weather_codes]
GO
