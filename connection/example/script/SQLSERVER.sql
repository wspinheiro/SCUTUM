USE [SCUTUM]
GO
/****** Object:  Table [dbo].[TBL_CLASSES_DB]    Script Date: 30/08/2013 00:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_CLASSES_DB](
	[cdb_id] [int] IDENTITY(1,1) NOT NULL,
	[cdb_nome] [varchar](50) NOT NULL,
	[cdb_banco] [varchar](50) NOT NULL,
	[cdb_framework] [varchar](50) NOT NULL,
	[cdb_unit] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_CLASSES_DB] ON 

INSERT [dbo].[TBL_CLASSES_DB] ([cdb_id], [cdb_nome], [cdb_banco], [cdb_framework], [cdb_unit]) VALUES (1, N'TSCUTUMDatabaseFactoryFirebirdDbx', N'Firebird', N'DBX', N'SCUTUM.Connection.Firebird.DBX')
INSERT [dbo].[TBL_CLASSES_DB] ([cdb_id], [cdb_nome], [cdb_banco], [cdb_framework], [cdb_unit]) VALUES (2, N'TSCUTUMDatabaseFactoryFirebirdFireDac', N'Firebird', N'FireDac', N'SCUTUM.Connection.Firebird.FireDac')
INSERT [dbo].[TBL_CLASSES_DB] ([cdb_id], [cdb_nome], [cdb_banco], [cdb_framework], [cdb_unit]) VALUES (3, N'TSCUTUMDatabaseFactoryMSSQLFireDac', N'SQLServer', N'FireDac', N'SCUTUM.Connection.MSSQL.FireDac')
SET IDENTITY_INSERT [dbo].[TBL_CLASSES_DB] OFF
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Classes factory concretas para acesso a banco de dados do framework SCUTUMConnection' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TBL_CLASSES_DB'
GO
