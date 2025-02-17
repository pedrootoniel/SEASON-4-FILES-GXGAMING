USE [MuOnline]
GO
/****** Object:  StoredProcedure [dbo].[WZ_PeriodItemInsert]    Script Date: 10/20/2018 19:43:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER Procedure [dbo].[WZ_PeriodItemInsert]

	@UserGuid		int,
	@CharacterName	varchar(10),
	@ItemCode		int,
	@OptionType		tinyint,
	@EffectType1		tinyint,
	@EffectType2		tinyint,
	@TotalUsePeriod	int,
	@ExpireDate		varchar(20)
AS
BEGIN
	DECLARE @ErrorCode int
	DECLARE @PeriodItemIndex int

	SET @ErrorCode = 0
	SET @PeriodItemIndex = 0

	SET XACT_ABORT ON
	SET NOCOUNT ON

	BEGIN TRANSACTION

	SELECT  @PeriodItemIndex = PeriodIndex FROM T_PeriodItem_Info WHERE CharacterName = @CharacterName AND OptionType = @OptionType AND UsedInfo = 1

	IF ( @PeriodItemIndex != 0 )
	BEGIN
		UPDATE T_PeriodItem_Info SET UsedInfo = 0 WHERE CharacterName = @CharacterName AND OptionType = @OptionType AND UsedInfo = 1
	END

	INSERT INTO T_PeriodItem_Info (UserGuid, CharacterName, ItemCode, OptionType, EffectType1, EffectType2, LeftTime, BuyDate, ExpireDate, UsedInfo) VALUES
	( @UserGuid, @CharacterName, @ItemCode, @OptionType, @EffectType1, @EffectType2, @TotalUsePeriod, GETDATE(), @ExpireDate, 1 )
	IF( @@Error <> 0 )
	BEGIN
		SET @ErrorCode = 2
	END

	IF ( @ErrorCode  <> 0 )
		ROLLBACK TRANSACTION
	ELSE
		COMMIT TRANSACTION

	SELECT @ErrorCode

	SET NOCOUNT OFF
	SET XACT_ABORT OFF
END

