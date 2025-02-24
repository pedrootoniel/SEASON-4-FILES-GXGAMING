USE [MuOnline]
GO
/****** Object:  StoredProcedure [dbo].[WZ_PeriodItemSelect]    Script Date: 10/20/2018 19:41:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[WZ_PeriodItemSelect]
@UserGuid int,
@CharacterName varchar(10)
as
BEGIN
DECLARE @ErrorCode int
DECLARE @ItemInfoCount int
DECLARE @PeriodIndex int
DECLARE @ExpireDate smalldatetime
DECLARE @UsedInfo tinyint

SET @PeriodIndex = 0
SET @ErrorCode = 0
SET @ItemInfoCount = 0
SET @UsedInfo = 0

Set nocount on

DECLARE CUR CURSOR FOR SELECT [PeriodIndex], [ExpireDate], [UsedInfo] FROM T_PeriodItem_Info WHERE CharacterName = @CharacterName AND UsedInfo = 1 FOR UPDATE
OPEN CUR
FETCH NEXT FROM CUR INTO @PeriodIndex, @ExpireDate, @UsedInfo
WHILE( @@fetch_status <> -1 )
BEGIN
IF( @@fetch_status <> -2 )
BEGIN
IF( @ExpireDate < GetDate() )
BEGIN
UPDATE T_PeriodItem_Info SET UsedInfo = 0 WHERE PeriodIndex = @PeriodIndex
END
END
FETCH NEXT FROM CUR INTO @PeriodIndex, @ExpireDate, @UsedInfo
END


SELECT *, DATEDIFF( minute, BuyDate, GETDATE() ) AS UsedMinutes, DATEDIFF( minute, GETDATE(), ExpireDate ) AS LeftMinutes FROM T_PeriodItem_Info where CharacterName = @CharacterName AND UsedInfo = 1
--SELECT * FROM T_PeriodItem_Info where UserGuid = @UserGuid AND CharacterName = @CharacterName AND UsedInfo = 1
IF( @@Error <> 0 )
BEGIN
SET @ErrorCode = -1
END

CLOSE CUR
DEALLOCATE CUR

Set nocount off
END

