/*
I spent 14 hours working on this. Not. Even. Joking. 
Man, <**censored**> SQL. 
For at *least* two hours I was just randomly changing 
things in the hopes that I would accidently fix it.
*/

CREATE TEMP TABLE tree AS 
	(SELECT p."SubmissionID", p."UserName", "ID" AS "ParentID", 0 AS "ChildID" FROM "Comment" p 
	WHERE 
		p."ParentID" IS NULL
		AND p."SubmissionID" = @SubmissionID
	UNION ALL
		SELECT c."SubmissionID", c."UserName", c."ParentID", c."ID" AS "ChildID" FROM "Comment" c
		WHERE
			c."ParentID" IS NOT NULL 
			AND (
					((@ParentID IS NULL)
					AND c."ParentID" IS NOT NULL
					AND c."SubmissionID" = @SubmissionID)
				OR
					((@ParentID IS NOT NULL)
					AND c."ParentID" > @ParentID
					AND c."SubmissionID" = @SubmissionID)
				)
	);

WITH RECURSIVE "CommentHierarchy"
     AS (
        SELECT 
            "SubmissionID",
            "UserName",
            "RootID" = "ParentID", 
            "Depth" = CASE WHEN "ChildID" = 0 THEN 0 ELSE 1 END, 
            "Path" = CAST("ParentID" AS TEXT) || CASE WHEN ("ChildID" != 0) THEN CAST("ChildID" AS TEXT) ELSE '' END,
            "ChildID" = "ChildID",
            "ParentID" = "ParentID" 
        FROM tree
        WHERE NOT "ParentID" IN (SELECT "ChildID" FROM tree)
        UNION ALL
            SELECT
                P."SubmissionID", 
                C."UserName",
                P."RootID",
                P."Depth" + 1 ,
                P."Path" || CAST(C."ChildID" AS TEXT) ,
                C."ChildID",
                C."ParentID"
            FROM "CommentHierarchy" P
            INNER JOIN tree C ON P."ChildID" = C."ParentID"
       )
SELECT 
		(SELECT COUNT(*)  FROM "CommentHierarchy"
		 WHERE
		 c."ID" = "ParentID"
		 AND "ChildID" != 0
		)  AS "ChildCount", 
    -- h.*,
    h."Depth",
    h."Path",
    m."Subverse",
    c.*
FROM "CommentHierarchy" h
INNER JOIN "Comment" c ON (c."ID" = CASE WHEN "ChildID" IS NULL OR "ChildID" = 0 THEN h."ParentID" ELSE "ChildID" END)
INNER JOIN "Submission" m ON (c."SubmissionID" = m."ID")
WHERE 
    ("Depth" <= @Depth OR @Depth IS NULL)
-- OPTION (MAXRECURSION 1000)
-- ORDER BY "ID", "Depth", "ParentID"
    -- AND (h."RootID" = @ParentID OR @ParentID IS NULL)
/*
    LOAD ALL COMMENTS FOR SUBMISSION
    usp_CommentTree 2441
    , NULL, 6116
    usp_CommentTree 2510, 1, 7407
    usp_CommentTree 2510, 1, 7408
    usp_CommentTree 2510, 1, 7409
        usp_CommentTree 2441, NULL, 6177
    usp_CommentTree 2441, 1, 6116
    usp_CommentTree 2441, NULL, 6113
    usp_CommentTree 2441, NULL, 6287
    SELECT p.MessageID, ID, 0 FROM Comments p 
    WHERE 
        p.ID = 6177
    UNION ALL
    SELECT c.MessageID, c.ParentID, c.ID FROM Comments c
    WHERE
        c.MessageID = 2441
        AND
        c.ParentID != 6177
*/
