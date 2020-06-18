USE [OAManagerSystem]
GO
/****** Object:  Table [dbo].[role_permission]    Script Date: 06/18/2020 19:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleId] [nvarchar](255) NULL,
	[permissionId] [int] NOT NULL,
 CONSTRAINT [PK_role_permission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 06/18/2020 19:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[id] [nvarchar](255) NOT NULL,
	[name] [nvarchar](255) NULL,
	[statement] [nvarchar](255) NULL,
	[createUserName] [nvarchar](255) NULL,
	[createTime] [smalldatetime] NULL,
 CONSTRAINT [PK_role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permission]    Script Date: 06/18/2020 19:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permission](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[menuUrl] [nvarchar](255) NULL,
	[url] [nvarchar](255) NULL,
	[type] [int] NULL,
	[parentId] [int] NULL,
	[createTime] [smalldatetime] NULL,
 CONSTRAINT [PK_permission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 06/18/2020 19:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [nvarchar](255) NOT NULL,
	[accountName] [nvarchar](32) NULL,
	[accountPassword] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[sex] [int] NULL,
	[birthday] [smalldatetime] NULL,
	[statement] [text] NULL,
	[portrait] [nvarchar](255) NULL,
	[status] [int] NULL,
	[email] [nvarchar](255) NULL,
	[loginSum] [int] NULL,
	[createTime] [smalldatetime] NULL,
	[loginTime] [smalldatetime] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_accountName] UNIQUE NONCLUSTERED 
(
	[accountName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 06/18/2020 19:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleId] [nvarchar](255) NULL,
	[userId] [nvarchar](255) NULL,
 CONSTRAINT [PK_user_role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_users_sex]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_sex]  DEFAULT ((1)) FOR [sex]
GO
/****** Object:  Default [DF_users_birthday]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_birthday]  DEFAULT (((2000)-(1))-(1)) FOR [birthday]
GO
/****** Object:  Default [DF_users_statement]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_statement]  DEFAULT ('此人很懒，没有简介') FOR [statement]
GO
/****** Object:  Default [DF_users_portrait]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_portrait]  DEFAULT (N'imgs/portrait/default_1.png') FOR [portrait]
GO
/****** Object:  Default [DF_users_status]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_status]  DEFAULT ((1)) FOR [status]
GO
/****** Object:  Default [DF_users_loginSum]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_loginSum]  DEFAULT ((0)) FOR [loginSum]
GO
/****** Object:  Default [DF_users_createTime]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_createTime]  DEFAULT (((2000)-(1))-(1)) FOR [createTime]
GO
/****** Object:  Default [DF_users_loginTime]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_loginTime]  DEFAULT (((2000)-(1))-(1)) FOR [loginTime]
GO
/****** Object:  ForeignKey [FK_user_role_role]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FK_user_role_role] FOREIGN KEY([roleId])
REFERENCES [dbo].[role] ([id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FK_user_role_role]
GO
/****** Object:  ForeignKey [FK_user_role_users]    Script Date: 06/18/2020 19:31:13 ******/
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FK_user_role_users] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FK_user_role_users]
GO
