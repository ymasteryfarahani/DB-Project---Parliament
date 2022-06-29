USE [Parliament]
GO
/****** Object:  StoredProcedure [dbo].[ProvinceRankings]    Script Date: 6/30/2022 2:06:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROC [dbo].[ProvinceRankings]
    @Base int
AS

BEGIN
	--Total Votes Ranking
	IF (@Base = 1)
	BEGIN
		SELECT Province_Name, SUM(F_Votes_no + S_Votes_no) AS [Votes]
		FROM Province
		GROUP BY Province_Name
		ORDER BY SUM(F_Votes_no + S_Votes_no) DESC
	END
	--Political Faction Ranking 
	ELSE IF (@Base = 2)
	BEGIN
		SELECT Co.C_Name, C.Political_Faction, COUNT(C.Political_Faction)
		FROM Candidate_List AS CL
			INNER JOIN 
			Candidate AS C
			ON C.ID = CL.Candidate_ID
			INNER JOIN 
			Constituency AS Co
			ON Co.ID = C.CO_ID
			INNER JOIN 
			Province AS P
			ON Co.P_ID = P.ID
			GROUP BY C.Political_Faction, C_Name
			ORDER BY COUNT(C.Political_Faction) DESC
	END
	--Participation Ranking 
	ELSE IF (@Base = 3)
	BEGIN
		SELECT ROUND (CAST (SUM (F_Votes_no + S_Votes_no) AS FLOAT) / Voter_Population * 100, 4) AS [Participation(%)]
		FROM Province
			GROUP BY Province_Name , Voter_Population
			ORDER BY CAST (SUM (F_Votes_no + S_Votes_no) AS FLOAT) / Voter_Population DESC
	END
END

