USE [MuOnlineS4]
GO

/****** Object:  Table [dbo].[EventRanking]    Script Date: 11/02/2018 02:09:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[EventRanking](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountId] [varchar](10) NOT NULL,
	[Name] [varchar](10) NOT NULL,
	[ServerCode] [int] NOT NULL,
	[BloodCastleScore] [bigint] NOT NULL,
	[DevilSquareScore] [bigint] NOT NULL,
	[ChaosCastleScore] [bigint] NOT NULL,
	[IllusionTempleScore] [bigint] NOT NULL,
	[DuelWin] [bigint] NOT NULL,
	[DuelLoser] [bigint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[EventRanking] ADD  CONSTRAINT [DF_EventRanking_BloodCastleScore]  DEFAULT ((0)) FOR [BloodCastleScore]
GO

ALTER TABLE [dbo].[EventRanking] ADD  CONSTRAINT [DF_EventRanking_DevilSquareScore]  DEFAULT ((0)) FOR [DevilSquareScore]
GO

ALTER TABLE [dbo].[EventRanking] ADD  CONSTRAINT [DF_Table_1_ChaosCastle]  DEFAULT ((0)) FOR [ChaosCastleScore]
GO

ALTER TABLE [dbo].[EventRanking] ADD  CONSTRAINT [DF_EventRanking_IllusionTempleScore]  DEFAULT ((0)) FOR [IllusionTempleScore]
GO

ALTER TABLE [dbo].[EventRanking] ADD  CONSTRAINT [DF_EventRanking_DuelWin]  DEFAULT ((0)) FOR [DuelWin]
GO

ALTER TABLE [dbo].[EventRanking] ADD  CONSTRAINT [DF_EventRanking_DuelLoser]  DEFAULT ((0)) FOR [DuelLoser]
GO


