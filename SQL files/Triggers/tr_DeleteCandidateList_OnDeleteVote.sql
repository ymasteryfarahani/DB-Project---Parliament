USE [Parlimant]
GO
/****** Object:  Trigger [dbo].[tr_DeleteCandidateList_OnDeleteVote]    Script Date: 28/06/2022 17:34:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[tr_DeleteCandidateList_OnDeleteVote]
   ON [dbo].[Vote]
   FOR DELETE
AS 
BEGIN
	SET NOCOUNT ON;

    DELETE CL 
	FROM Candidate_List AS CL
	WHERE EXISTS ( SELECT *	
				   FROM deleted
				   WHERE deleted.ID = CL.Vote_ID )
END
