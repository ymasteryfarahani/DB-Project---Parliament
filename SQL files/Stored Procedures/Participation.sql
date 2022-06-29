USE [Parliament]
GO
/****** Object:  StoredProcedure [dbo].[Participation]    Script Date: 6/29/2022 6:09:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[Participation]
    @Population int
AS
	SELECT CAST(COUNT(*) AS FLOAT) / SUM(Voter_Population) AS [Participation(%)]
	FROM VOTE, Province


