SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Submission]'
GO
CREATE TABLE [dbo].[Submission]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[IsArchived] [bit] NOT NULL CONSTRAINT [DF_Messages_IsArchived] DEFAULT ((0)),
[Votes] [int] NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Content] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [datetime] NOT NULL,
[Type] [int] NOT NULL,
[Title] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rank] [float] NOT NULL CONSTRAINT [DF_Messages_Rank] DEFAULT ((0)),
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpCount] [bigint] NOT NULL CONSTRAINT [DF_Messages_Likes] DEFAULT ((1)),
[DownCount] [bigint] NOT NULL CONSTRAINT [DF_Messages_Dislikes] DEFAULT ((0)),
[Thumbnail] [nchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastEditDate] [datetime] NULL,
[FlairLabel] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FlairCss] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsAnonymized] [bit] NOT NULL CONSTRAINT [DF_Messages_Anonymized] DEFAULT ((0)),
[Views] [float] NOT NULL CONSTRAINT [DF_Messages_Views] DEFAULT ((1)),
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Messages_IsDeleted] DEFAULT ((0)),
[RelativeRank] [float] NOT NULL CONSTRAINT [DF_Submission_RelativeRank] DEFAULT ((0)),
[Url] [nvarchar] (3000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormattedContent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Messages] on [dbo].[Submission]'
GO
ALTER TABLE [dbo].[Submission] ADD CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Comment]'
GO
CREATE TABLE [dbo].[Comment]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Votes] [int] NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Content] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[LastEditDate] [datetime] NULL,
[SubmissionID] [int] NULL,
[UpCount] [bigint] NOT NULL CONSTRAINT [DF_Comments_Likes] DEFAULT ((1)),
[DownCount] [bigint] NOT NULL CONSTRAINT [DF_Comments_Dislikes] DEFAULT ((0)),
[ParentID] [int] NULL,
[IsAnonymized] [bit] NOT NULL CONSTRAINT [DF_Comments_Anonymized] DEFAULT ((0)),
[IsDistinguished] [bit] NOT NULL CONSTRAINT [DF_Comments_IsDistinguished] DEFAULT ((0)),
[FormattedContent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Comments_IsDeleted] DEFAULT ((0))
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Comments] on [dbo].[Comment]'
GO
ALTER TABLE [dbo].[Comment] ADD CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_CommentTree]'
GO

CREATE PROC [dbo].[usp_CommentTree]
	@SubmissionID INT,
	@Depth INT = NULL,
	@ParentID INT = NULL
AS

/*
I spent 14 hours working on this. Not. Even. Joking. 
Man, <**censored**> SQL. 
For at *least* two hours I was just randomly changing 
things in the hopes that I would accidently fix it.
*/

DECLARE @tree TABLE (
   SubmissionID INT,
   UserName NVARCHAR(30),
   ParentID INT,
   ChildID INT
);

IF @ParentID IS NULL 
	INSERT INTO @tree
	SELECT p.SubmissionID, p.UserName, ID, 0 FROM Comment p 
	WHERE 
		1 = 1
		AND p.ParentID IS NULL
		AND p.SubmissionID = @SubmissionID
	UNION ALL
	SELECT c.SubmissionID, c.UserName, c.ParentID, c.ID FROM Comment c
	WHERE
		1 = 1 
		AND c.ParentID IS NOT NULL
		AND c.SubmissionID = @SubmissionID
ELSE 
	INSERT INTO @tree
	SELECT p.SubmissionID, p.UserName, ID, 0 FROM Comment p 
	WHERE 
		1 = 1
		AND p.ParentID = @ParentID
		AND p.SubmissionID = @SubmissionID
	UNION ALL
	SELECT c.SubmissionID, c.UserName, c.ParentID, c.ID FROM Comment c
	WHERE
		1 = 1
		AND c.ParentID IS NOT NULL 
		AND c.ParentID > @ParentID
		AND c.SubmissionID = @SubmissionID

;WITH CommentHierarchy
     AS (
		SELECT 
			SubmissionID,
			UserName,
			RootID = ParentID, 
			[Depth] = CASE WHEN ChildID = 0 THEN 0 ELSE 1 END, 
			[Path] = CAST(ParentID AS VARCHAR(MAX)) + CASE WHEN ChildID != 0 THEN '\' + CAST(ChildID AS VARCHAR(MAX)) ELSE '' END,
			ChildID = ChildID ,
			ParentID = ParentID 
        FROM @tree
        WHERE NOT ParentID IN (SELECT ChildID FROM @tree)
        UNION ALL
			SELECT
				P.SubmissionID, 
				C.UserName,
				P.RootID,
				P.[Depth] + 1 ,
				P.[Path] + '\' + CAST(C.ChildID AS VARCHAR(MAX)) ,
				C.ChildID,
				C.ParentID
			FROM CommentHierarchy P
			INNER JOIN @tree C ON P.ChildID = C.ParentID
       )
SELECT 
	ChildCount = (
			SELECT COUNT(*)  FROM CommentHierarchy 
			WHERE
				1 = 1 
				AND c.ID = ParentID 
				AND ChildID != 0
		), 
	--h.*,
	h.Depth,
	h.Path,
	m.Subverse,
	c.*
FROM CommentHierarchy h
INNER JOIN Comment c ON (c.ID = CASE WHEN ChildID IS NULL OR ChildID = 0 THEN h.ParentID ELSE ChildID END)
INNER JOIN Submission m ON (c.SubmissionID = m.ID)
WHERE 
	([Depth] <= @Depth OR @Depth IS NULL)
OPTION (MAXRECURSION 1000)
--ORDER BY ID, Depth, ParentID
	--AND (h.RootID = @ParentID OR @ParentID IS NULL)
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
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubverseModerator]'
GO
CREATE TABLE [dbo].[SubverseModerator]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Power] [int] NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [datetime] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SubverseAdmins] on [dbo].[SubverseModerator]'
GO
ALTER TABLE [dbo].[SubverseModerator] ADD CONSTRAINT [PK_SubverseAdmins] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Subverse]'
GO
CREATE TABLE [dbo].[Subverse]
(
[Name] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Title] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SideBar] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmissionText] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Language] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SubmitLinkLabel] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmitPostLabel] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpamFilterLink] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpamFilterPost] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpamFilterComment] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsAdult] [bit] NOT NULL CONSTRAINT [DF_Subverses_rated_adult] DEFAULT ((0)),
[IsDefaultAllowed] [bit] NOT NULL CONSTRAINT [DF_Subverses_allow_default] DEFAULT ((1)),
[IsThumbnailEnabled] [bit] NOT NULL CONSTRAINT [DF_Subverses_enable_thumbnails] DEFAULT ((1)),
[ExcludeSitewideBans] [bit] NOT NULL CONSTRAINT [DF_Subverses_exclude_sitewide_bans] DEFAULT ((0)),
[IsTrafficStatsPublic] [bit] NULL CONSTRAINT [DF_Subverses_traffic_stats_public] DEFAULT ((0)),
[MinutesToHideComments] [int] NULL,
[CreationDate] [datetime] NOT NULL,
[Stylesheet] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubscriberCount] [int] NULL,
[IsPrivate] [bit] NOT NULL CONSTRAINT [DF_Subverses_private] DEFAULT ((0)),
[IsAuthorizedOnly] [bit] NOT NULL CONSTRAINT [DF_Subverses_authorized_submitters_only] DEFAULT ((0)),
[IsAnonymized] [bit] NOT NULL CONSTRAINT [DF_Subverses_anonymized_mode] DEFAULT ((0)),
[LastSubmissionDate] [datetime] NULL,
[MinCCPForDownvote] [int] NOT NULL CONSTRAINT [DF_Subverses_minimumccpfordownvotes] DEFAULT ((0)),
[IsAdminPrivate] [bit] NOT NULL CONSTRAINT [DF_Subverses_forced_private] DEFAULT ((0)),
[IsAdminDisabled] [bit] NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Subverses] on [dbo].[Subverse]'
GO
ALTER TABLE [dbo].[Subverse] ADD CONSTRAINT [PK_Subverses] PRIMARY KEY CLUSTERED  ([Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubmissionVoteTracker]'
GO
CREATE TABLE [dbo].[SubmissionVoteTracker]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[SubmissionID] [int] NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoteStatus] [int] NULL,
[CreationDate] [datetime] NULL,
[IPAddress] [nvarchar] (90) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Votingtracker] on [dbo].[SubmissionVoteTracker]'
GO
ALTER TABLE [dbo].[SubmissionVoteTracker] ADD CONSTRAINT [PK_Votingtracker] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CommentVoteTracker]'
GO
CREATE TABLE [dbo].[CommentVoteTracker]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[CommentID] [int] NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoteStatus] [int] NULL,
[CreationDate] [datetime] NULL,
[IPAddress] [nvarchar] (90) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Commentvotingtracker] on [dbo].[CommentVoteTracker]'
GO
ALTER TABLE [dbo].[CommentVoteTracker] ADD CONSTRAINT [PK_Commentvotingtracker] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserSetList]'
GO
CREATE TABLE [dbo].[UserSetList]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[UserSetID] [int] NOT NULL,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Usersetdefinitions] on [dbo].[UserSetList]'
GO
ALTER TABLE [dbo].[UserSetList] ADD CONSTRAINT [PK_Usersetdefinitions] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserBlockedSubverse]'
GO
CREATE TABLE [dbo].[UserBlockedSubverse]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_UserBlockedSubverse_CreationDate] DEFAULT (getutcdate())
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_UserBlockedSubverses] on [dbo].[UserBlockedSubverse]'
GO
ALTER TABLE [dbo].[UserBlockedSubverse] ADD CONSTRAINT [PK_UserBlockedSubverses] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubverseSubscription]'
GO
CREATE TABLE [dbo].[SubverseSubscription]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Subscriptions] on [dbo].[SubverseSubscription]'
GO
ALTER TABLE [dbo].[SubverseSubscription] ADD CONSTRAINT [PK_Subscriptions] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubverseFlair]'
GO
CREATE TABLE [dbo].[SubverseFlair]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Label] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CssClass] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SubverseFlairSettings] on [dbo].[SubverseFlair]'
GO
ALTER TABLE [dbo].[SubverseFlair] ADD CONSTRAINT [PK_SubverseFlairSettings] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubverseBan]'
GO
CREATE TABLE [dbo].[SubverseBan]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Reason] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SubverseBans] on [dbo].[SubverseBan]'
GO
ALTER TABLE [dbo].[SubverseBan] ADD CONSTRAINT [PK_SubverseBans] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[StickiedSubmission]'
GO
CREATE TABLE [dbo].[StickiedSubmission]
(
[SubmissionID] [int] NOT NULL,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Stickiedsubmissions] on [dbo].[StickiedSubmission]'
GO
ALTER TABLE [dbo].[StickiedSubmission] ADD CONSTRAINT [PK_Stickiedsubmissions] PRIMARY KEY CLUSTERED  ([SubmissionID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SessionTracker]'
GO
CREATE TABLE [dbo].[SessionTracker]
(
[SessionID] [nvarchar] (90) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_Sessiontracker_Timestamp] DEFAULT (getdate())
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Sessiontracker_1] on [dbo].[SessionTracker]'
GO
ALTER TABLE [dbo].[SessionTracker] ADD CONSTRAINT [PK_Sessiontracker_1] PRIMARY KEY CLUSTERED  ([SessionID], [Subverse])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ModeratorInvitation]'
GO
CREATE TABLE [dbo].[ModeratorInvitation]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Recipient] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subverse] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Power] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Moderatorinvitations] on [dbo].[ModeratorInvitation]'
GO
ALTER TABLE [dbo].[ModeratorInvitation] ADD CONSTRAINT [PK_Moderatorinvitations] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[FeaturedSubverse]'
GO
CREATE TABLE [dbo].[FeaturedSubverse]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Featuredsubs] on [dbo].[FeaturedSubverse]'
GO
ALTER TABLE [dbo].[FeaturedSubverse] ADD CONSTRAINT [PK_Featuredsubs] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[DefaultSubverse]'
GO
CREATE TABLE [dbo].[DefaultSubverse]
(
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Defaultsubverses] on [dbo].[DefaultSubverse]'
GO
ALTER TABLE [dbo].[DefaultSubverse] ADD CONSTRAINT [PK_Defaultsubverses] PRIMARY KEY CLUSTERED  ([Subverse])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ApiClient]'
GO
CREATE TABLE [dbo].[ApiClient]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IsActive] [bit] NOT NULL CONSTRAINT [DF_ApiClient_IsActive] DEFAULT ((1)),
[UserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AppName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AppDescription] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AppAboutUrl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedirectUrl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PublicKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PrivateKey] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastAccessDate] [datetime] NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_ApiClient_CreationDate] DEFAULT (getutcdate()),
[ApiThrottlePolicyID] [int] NULL,
[ApiPermissionPolicyID] [int] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ApiClient] on [dbo].[ApiClient]'
GO
ALTER TABLE [dbo].[ApiClient] ADD CONSTRAINT [PK_ApiClient] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Ad]'
GO
CREATE TABLE [dbo].[Ad]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IsActive] [bit] NOT NULL CONSTRAINT [DF_Ad_IsActive] DEFAULT ((1)),
[GraphicUrl] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DestinationUrl] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StartDate] [datetime] NULL,
[EndDate] [datetime] NULL,
[Subverse] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_Ad_CreationDate] DEFAULT (getutcdate())
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Ad] on [dbo].[Ad]'
GO
ALTER TABLE [dbo].[Ad] ADD CONSTRAINT [PK_Ad] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserBlockedUser]'
GO
CREATE TABLE [dbo].[UserBlockedUser]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[BlockUser] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_UserBlockedUser_CreationDate] DEFAULT (getutcdate())
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_UserBlockedUser] on [dbo].[UserBlockedUser]'
GO
ALTER TABLE [dbo].[UserBlockedUser] ADD CONSTRAINT [PK_UserBlockedUser] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserPreference]'
GO
CREATE TABLE [dbo].[UserPreference]
(
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisableCSS] [bit] NOT NULL,
[NightMode] [bit] NOT NULL,
[Language] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OpenInNewWindow] [bit] NOT NULL,
[EnableAdultContent] [bit] NOT NULL,
[DisplayVotes] [bit] NOT NULL,
[DisplaySubscriptions] [bit] NOT NULL CONSTRAINT [DF_Userpreferences_Public_subscriptions] DEFAULT ((0)),
[UseSubscriptionsMenu] [bit] NOT NULL CONSTRAINT [DF_Userpreferences_Topmenu_from_subscriptions] DEFAULT ((1)),
[Bio] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Avatar] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayAds] [bit] NOT NULL CONSTRAINT [DF_UserPreference_DisplayAds] DEFAULT ((0)),
[DisplayCommentCount] [int] NULL,
[HighlightMinutes] [int] NULL,
[VanityTitle] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CollapseCommentLimit] [int] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Userpreferences] on [dbo].[UserPreference]'
GO
ALTER TABLE [dbo].[UserPreference] ADD CONSTRAINT [PK_Userpreferences] PRIMARY KEY CLUSTERED  ([UserName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ApiLog]'
GO
CREATE TABLE [dbo].[ApiLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[ApiClientID] [int] NOT NULL,
[Method] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Url] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Headers] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Body] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_ApiLog_CreationDate] DEFAULT (getutcdate())
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ApiLog] on [dbo].[ApiLog]'
GO
ALTER TABLE [dbo].[ApiLog] ADD CONSTRAINT [PK_ApiLog] PRIMARY KEY CLUSTERED  ([ID] DESC)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserSet]'
GO
CREATE TABLE [dbo].[UserSet]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Name] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[IsPublic] [bit] NOT NULL CONSTRAINT [DF_Usersets_Public] DEFAULT ((1)),
[SubscriberCount] [int] NOT NULL CONSTRAINT [DF_Usersets_Subscribers] DEFAULT ((1)),
[IsDefault] [bit] NOT NULL CONSTRAINT [DF_Usersets_Default] DEFAULT ((0))
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Usersets] on [dbo].[UserSet]'
GO
ALTER TABLE [dbo].[UserSet] ADD CONSTRAINT [PK_Usersets] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserSetSubscription]'
GO
CREATE TABLE [dbo].[UserSetSubscription]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[UserSetID] [int] NOT NULL,
[Order] [int] NOT NULL CONSTRAINT [DF_Usersetsubscriptions_Order] DEFAULT ((0)),
[UserName] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Usersetsubscriptions] on [dbo].[UserSetSubscription]'
GO
ALTER TABLE [dbo].[UserSetSubscription] ADD CONSTRAINT [PK_Usersetsubscriptions] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[EventLog]'
GO
CREATE TABLE [dbo].[EventLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[ActivityID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
	[Origin] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
	[Type] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Message] [varchar](1500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Category] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Exception] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Data] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
	[CreationDate] [datetime] NOT NULL
)
 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_EventLog] on [dbo].[EventLog]'
GO
ALTER TABLE [dbo].[EventLog] ADD CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED  ([ID] DESC)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ApiCorsPolicy]'
GO
CREATE TABLE [dbo].[ApiCorsPolicy]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[IsActive] [bit] NOT NULL,
[AllowOrigin] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AllowMethods] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AllowHeaders] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AllowCredentials] [bit] NULL,
[MaxAge] [int] NULL,
[UserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_ApiCorsPolicy_CreationDate] DEFAULT (getutcdate())
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ApiCorsPolicy] on [dbo].[ApiCorsPolicy]'
GO
ALTER TABLE [dbo].[ApiCorsPolicy] ADD CONSTRAINT [PK_ApiCorsPolicy] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ApiPermissionPolicy]'
GO
CREATE TABLE [dbo].[ApiPermissionPolicy]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Policy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ApiPermissionPolicy] on [dbo].[ApiPermissionPolicy]'
GO
ALTER TABLE [dbo].[ApiPermissionPolicy] ADD CONSTRAINT [PK_ApiPermissionPolicy] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ApiThrottlePolicy]'
GO
CREATE TABLE [dbo].[ApiThrottlePolicy]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Policy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_ApiThrottlePolicy] on [dbo].[ApiThrottlePolicy]'
GO
ALTER TABLE [dbo].[ApiThrottlePolicy] ADD CONSTRAINT [PK_ApiThrottlePolicy] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CommentRemovalLog]'
GO
CREATE TABLE [dbo].[CommentRemovalLog]
(
[CommentID] [int] NOT NULL,
[Moderator] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Reason] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_CommentRemovalLog] on [dbo].[CommentRemovalLog]'
GO
ALTER TABLE [dbo].[CommentRemovalLog] ADD CONSTRAINT [PK_CommentRemovalLog] PRIMARY KEY CLUSTERED  ([CommentID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[CommentSaveTracker]'
GO
CREATE TABLE [dbo].[CommentSaveTracker]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[CommentID] [int] NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Commentsavingtracker] on [dbo].[CommentSaveTracker]'
GO
ALTER TABLE [dbo].[CommentSaveTracker] ADD CONSTRAINT [PK_Commentsavingtracker] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubmissionSaveTracker]'
GO
CREATE TABLE [dbo].[SubmissionSaveTracker]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[SubmissionID] [int] NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Savingtracker] on [dbo].[SubmissionSaveTracker]'
GO
ALTER TABLE [dbo].[SubmissionSaveTracker] ADD CONSTRAINT [PK_Savingtracker] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SubmissionRemovalLog]'
GO
CREATE TABLE [dbo].[SubmissionRemovalLog]
(
[SubmissionID] [int] NOT NULL,
[Moderator] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Reason] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SubmissionRemovalLog] on [dbo].[SubmissionRemovalLog]'
GO
ALTER TABLE [dbo].[SubmissionRemovalLog] ADD CONSTRAINT [PK_SubmissionRemovalLog] PRIMARY KEY CLUSTERED  ([SubmissionID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Badge]'
GO
CREATE TABLE [dbo].[Badge]
(
[ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Graphic] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Title] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Badges] on [dbo].[Badge]'
GO
ALTER TABLE [dbo].[Badge] ADD CONSTRAINT [PK_Badges] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserBadge]'
GO
CREATE TABLE [dbo].[UserBadge]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BadgeID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Userbadges] on [dbo].[UserBadge]'
GO
ALTER TABLE [dbo].[UserBadge] ADD CONSTRAINT [PK_Userbadges] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[ViewStatistic]'
GO
CREATE TABLE [dbo].[ViewStatistic]
(
[SubmissionID] [int] NOT NULL,
[ViewerID] [nvarchar] (90) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Viewstatistics] on [dbo].[ViewStatistic]'
GO
ALTER TABLE [dbo].[ViewStatistic] ADD CONSTRAINT [PK_Viewstatistics] PRIMARY KEY CLUSTERED  ([SubmissionID], [ViewerID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BannedDomain]'
GO
CREATE TABLE [dbo].[BannedDomain]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Domain] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Reason] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Banneddomains] on [dbo].[BannedDomain]'
GO
ALTER TABLE [dbo].[BannedDomain] ADD CONSTRAINT [PK_Banneddomains] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[BannedUser]'
GO
CREATE TABLE [dbo].[BannedUser]
(
[ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[Reason] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Bannedusers] on [dbo].[BannedUser]'
GO
ALTER TABLE [dbo].[BannedUser] ADD CONSTRAINT [PK_Bannedusers] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Message]'
GO
CREATE TABLE [dbo].[Message]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CorrelationID] [nvarchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ParentID] [int] NULL,
[Type] [int] NOT NULL,
[Sender] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SenderType] [int] NOT NULL,
[Recipient] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RecipientType] [int] NOT NULL,
[Title] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Content] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormattedContent] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Subverse] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubmissionID] [int] NULL,
[CommentID] [int] NULL,
[IsAnonymized] [bit] NOT NULL,
[ReadDate] [datetime] NULL,
[CreatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreationDate] [datetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Message] on [dbo].[Message]'
GO
ALTER TABLE [dbo].[Message] ADD CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED  ([ID] DESC)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[UserVisit]'
GO
CREATE TABLE [dbo].[UserVisit]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SubmissionID] [int] NOT NULL,
[UserName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastVisitDate] [smalldatetime] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_UserVisit] on [dbo].[UserVisit]'
GO
ALTER TABLE [dbo].[UserVisit] ADD CONSTRAINT [PK_UserVisit] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[__MigrationHistory]'
GO
CREATE TABLE [dbo].[__MigrationHistory]
(
[MigrationId] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ContextKey] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Model] [varbinary] (max) NOT NULL,
[ProductVersion] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_dbo.__MigrationHistory] on [dbo].[__MigrationHistory]'
GO
ALTER TABLE [dbo].[__MigrationHistory] ADD CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED  ([MigrationId], [ContextKey])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[UserBadge]'
GO
ALTER TABLE [dbo].[UserBadge] WITH NOCHECK  ADD CONSTRAINT [FK_Userbadges_Badges] FOREIGN KEY ([BadgeID]) REFERENCES [dbo].[Badge] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[CommentRemovalLog]'
GO
ALTER TABLE [dbo].[CommentRemovalLog] WITH NOCHECK  ADD CONSTRAINT [FK_CommentRemovalLog_Comments] FOREIGN KEY ([CommentID]) REFERENCES [dbo].[Comment] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[CommentSaveTracker]'
GO
ALTER TABLE [dbo].[CommentSaveTracker] WITH NOCHECK  ADD CONSTRAINT [FK_Commentsavingtracker_Comments] FOREIGN KEY ([CommentID]) REFERENCES [dbo].[Comment] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[CommentVoteTracker]'
GO
ALTER TABLE [dbo].[CommentVoteTracker] WITH NOCHECK  ADD CONSTRAINT [FK_Commentvotingtracker_Comments] FOREIGN KEY ([CommentID]) REFERENCES [dbo].[Comment] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[Comment]'
GO
ALTER TABLE [dbo].[Comment] WITH NOCHECK  ADD CONSTRAINT [FK_Comments_Messages] FOREIGN KEY ([SubmissionID]) REFERENCES [dbo].[Submission] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[DefaultSubverse]'
GO
ALTER TABLE [dbo].[DefaultSubverse] WITH NOCHECK  ADD CONSTRAINT [FK_Defaultsubverses_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[FeaturedSubverse]'
GO
ALTER TABLE [dbo].[FeaturedSubverse] WITH NOCHECK  ADD CONSTRAINT [FK_Featuredsubs_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[StickiedSubmission]'
GO
ALTER TABLE [dbo].[StickiedSubmission] WITH NOCHECK  ADD CONSTRAINT [FK_Stickiedsubmissions_Messages] FOREIGN KEY ([SubmissionID]) REFERENCES [dbo].[Submission] ([ID])
GO
ALTER TABLE [dbo].[StickiedSubmission] WITH NOCHECK  ADD CONSTRAINT [FK_Stickiedsubmissions_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubmissionRemovalLog]'
GO
ALTER TABLE [dbo].[SubmissionRemovalLog] WITH NOCHECK  ADD CONSTRAINT [FK_SubmissionRemovalLog_Messages] FOREIGN KEY ([SubmissionID]) REFERENCES [dbo].[Submission] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubmissionSaveTracker]'
GO
ALTER TABLE [dbo].[SubmissionSaveTracker] WITH NOCHECK  ADD CONSTRAINT [FK_Savingtracker_Messages] FOREIGN KEY ([SubmissionID]) REFERENCES [dbo].[Submission] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubmissionVoteTracker]'
GO
ALTER TABLE [dbo].[SubmissionVoteTracker] WITH NOCHECK  ADD CONSTRAINT [FK_Votingtracker_Messages] FOREIGN KEY ([SubmissionID]) REFERENCES [dbo].[Submission] ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ViewStatistic]'
GO
ALTER TABLE [dbo].[ViewStatistic] WITH NOCHECK  ADD CONSTRAINT [FK_Viewstatistics_Messages] FOREIGN KEY ([SubmissionID]) REFERENCES [dbo].[Submission] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubverseBan]'
GO
ALTER TABLE [dbo].[SubverseBan] WITH NOCHECK  ADD CONSTRAINT [FK_SubverseBans_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubverseFlair]'
GO
ALTER TABLE [dbo].[SubverseFlair] WITH NOCHECK  ADD CONSTRAINT [FK_Subverseflairsettings_Subverses1] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubverseModerator]'
GO
ALTER TABLE [dbo].[SubverseModerator] WITH NOCHECK  ADD CONSTRAINT [FK_SubverseAdmins_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SubverseSubscription]'
GO
ALTER TABLE [dbo].[SubverseSubscription] WITH NOCHECK  ADD CONSTRAINT [FK_Subscriptions_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[UserBlockedSubverse]'
GO
ALTER TABLE [dbo].[UserBlockedSubverse] WITH NOCHECK  ADD CONSTRAINT [FK_UserBlockedSubverses_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[UserSetList]'
GO
ALTER TABLE [dbo].[UserSetList] WITH NOCHECK  ADD CONSTRAINT [FK_Usersetdefinitions_Subverses] FOREIGN KEY ([Subverse]) REFERENCES [dbo].[Subverse] ([Name]) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[UserSetList] WITH NOCHECK  ADD CONSTRAINT [FK_Usersetdefinitions_Usersets] FOREIGN KEY ([UserSetID]) REFERENCES [dbo].[UserSet] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[UserSetSubscription]'
GO
ALTER TABLE [dbo].[UserSetSubscription] WITH NOCHECK  ADD CONSTRAINT [FK_Usersetsubscriptions_Usersets] FOREIGN KEY ([UserSetID]) REFERENCES [dbo].[UserSet] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[ApiClient]'
GO
ALTER TABLE [dbo].[ApiClient] ADD CONSTRAINT [FK_ApiClient_ApiThrottlePolicy] FOREIGN KEY ([ApiThrottlePolicyID]) REFERENCES [dbo].[ApiThrottlePolicy] ([ID])
GO
ALTER TABLE [dbo].[ApiClient] ADD CONSTRAINT [FK_ApiClient_ApiPermissionPolicy] FOREIGN KEY ([ApiPermissionPolicyID]) REFERENCES [dbo].[ApiPermissionPolicy] ([ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Disabling constraints on [dbo].[SubmissionVoteTracker]'
GO
ALTER TABLE [dbo].[SubmissionVoteTracker] NOCHECK CONSTRAINT [FK_Votingtracker_Messages]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
