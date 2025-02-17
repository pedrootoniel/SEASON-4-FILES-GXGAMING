USE [MuOnline]
GO
/****** Object:  StoredProcedure [dbo].[WZ_PeriodItemDelete]    Script Date: 10/20/2018 19:44:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER Procedure [dbo].[WZ_PeriodItemDelete]

	@UserGuid		int,
	@CharacterName	varchar(10)
AS
BEGIN
	DECLARE @ErrorCode int
	DECLARE @ItemInfoCount int

	SET @ErrorCode = 0
	SET @ItemInfoCount = 0

	SET NOCOUNT ON

	SELECT @ItemInfoCount = COUNT(*) FROM T_PeriodItem_Info where CharacterName = @CharacterName

	IF( @ItemInfoCount < 1 )
	BEGIN
		SET @ErrorCode = 1
	END

	IF( @ErrorCode <> 1 )
	BEGIN
		UPDATE T_PeriodItem_Info SET UsedInfo = 0 WHERE CharacterName = @CharacterName
	END

	SELECT @ErrorCode

	SET NOCOUNT OFF
END

