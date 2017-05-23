-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: voat
-- ------------------------------------------------------
-- Server version	5.7.18
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO,POSTGRESQL' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: "voat"
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ "voat" /*!40100 DEFAULT CHARACTER SET latin1 */;

USE "voat";

--
-- Table structure for table "Ad"
--

DROP TABLE IF EXISTS "Ad";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "Ad" (
  "ID" int NOT NULL,
  "IsActive" bit DEFAULT b'1',
  "GraphicUrl" varchar(100) NOT NULL,
  "DestinationUrl" text,
  "Name" varchar(100) NOT NULL,
  "Description" text NOT NULL,
  "StartDate" timestamp NOT NULL DEFAULT now(),
  "EndDate" timestamp DEFAULT NULL,
  "Subverse" varchar(50) DEFAULT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Ad"
--


/*!40000 ALTER TABLE "Ad" DISABLE KEYS */;
/*!40000 ALTER TABLE "Ad" ENABLE KEYS */;


--
-- Table structure for table "ApiClient"
--

DROP TABLE IF EXISTS "ApiClient";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ApiClient" (
  "ID" int NOT NULL,
  "IsActive" bit DEFAULT b'1',
  "UserName" varchar(100) DEFAULT NULL,
  "AppName" varchar(50) NOT NULL,
  "AppDescription" text,
  "AppAboutUrl" varchar(200) DEFAULT NULL,
  "RedirectUrl" varchar(200) DEFAULT NULL,
  "PublicKey" varchar(100) NOT NULL,
  "privateKey" varchar(100) NOT NULL,
  "LastAccessDate" timestamp NOT NULL DEFAULT now(),
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "ApiThrottlePolicyID" int DEFAULT NULL,
  "ApiPermissionPolicyID" int DEFAULT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ApiClient"
--


/*!40000 ALTER TABLE "ApiClient" DISABLE KEYS */;
/*!40000 ALTER TABLE "ApiClient" ENABLE KEYS */;


--
-- Table structure for table "ApiCorsPolicy"
--

DROP TABLE IF EXISTS "ApiCorsPolicy";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ApiCorsPolicy" (
  "ID" int NOT NULL,
  "IsActive" bit NOT NULL,
  "AllowOrigin" varchar(100) NOT NULL,
  "AllowMethods" varchar(100) NOT NULL,
  "AllowHeaders" varchar(100) NOT NULL,
  "AllowCredentials" bit DEFAULT NULL,
  "MaxAge" int DEFAULT NULL,
  "UserName" varchar(100) DEFAULT NULL,
  "Description" text,
  "CreatedBy" varchar(100) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ApiCorsPolicy"
--


/*!40000 ALTER TABLE "ApiCorsPolicy" DISABLE KEYS */;
/*!40000 ALTER TABLE "ApiCorsPolicy" ENABLE KEYS */;


--
-- Table structure for table "ApiLog"
--

DROP TABLE IF EXISTS "ApiLog";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ApiLog" (
  "ID" int NOT NULL,
  "ApiClientID" int NOT NULL,
  "Method" varchar(10) NOT NULL,
  "Url" text NOT NULL,
  "Headers" text,
  "Body" text,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ApiLog"
--


/*!40000 ALTER TABLE "ApiLog" DISABLE KEYS */;
/*!40000 ALTER TABLE "ApiLog" ENABLE KEYS */;


--
-- Table structure for table "ApiPermissionPolicy"
--

DROP TABLE IF EXISTS "ApiPermissionPolicy";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ApiPermissionPolicy" (
  "ID" int NOT NULL,
  "Name" varchar(100) NOT NULL,
  "Policy" text NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ApiPermissionPolicy"
--


/*!40000 ALTER TABLE "ApiPermissionPolicy" DISABLE KEYS */;
/*!40000 ALTER TABLE "ApiPermissionPolicy" ENABLE KEYS */;


--
-- Table structure for table "ApiThrottlePolicy"
--

DROP TABLE IF EXISTS "ApiThrottlePolicy";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ApiThrottlePolicy" (
  "ID" int NOT NULL,
  "Name" varchar(100) NOT NULL,
  "Policy" text NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ApiThrottlePolicy"
--


/*!40000 ALTER TABLE "ApiThrottlePolicy" DISABLE KEYS */;
/*!40000 ALTER TABLE "ApiThrottlePolicy" ENABLE KEYS */;


--
-- Table structure for table "Badge"
--

DROP TABLE IF EXISTS "Badge";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "Badge" (
  "ID" varchar(50) NOT NULL,
  "Graphic" varchar(50) NOT NULL,
  "Title" text NOT NULL,
  "Name" varchar(50) NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Badge"
--


/*!40000 ALTER TABLE "Badge" DISABLE KEYS */;
/*!40000 ALTER TABLE "Badge" ENABLE KEYS */;


--
-- Table structure for table "BannedDomain"
--

DROP TABLE IF EXISTS "BannedDomain";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "BannedDomain" (
  "ID" int NOT NULL,
  "Domain" varchar(50) NOT NULL,
  "CreatedBy" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Reason" text NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "BannedDomain"
--


/*!40000 ALTER TABLE "BannedDomain" DISABLE KEYS */;
/*!40000 ALTER TABLE "BannedDomain" ENABLE KEYS */;


--
-- Table structure for table "BannedUser"
--

DROP TABLE IF EXISTS "BannedUser";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "BannedUser" (
  "ID" int NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Reason" text NOT NULL,
  "CreatedBy" varchar(50) NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "BannedUser"
--


/*!40000 ALTER TABLE "BannedUser" DISABLE KEYS */;
/*!40000 ALTER TABLE "BannedUser" ENABLE KEYS */;


--
-- Table structure for table "Comment"
--

DROP TABLE IF EXISTS "Comment";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "Comment" (
  "ID" int NOT NULL,
  "Votes" int DEFAULT NULL,
  "UserName" varchar(50) NOT NULL,
  "Content" text NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "LastEditDate" timestamp ,
  "SubmissionID" int NOT NULL,
  "UpCount" bigint NOT NULL DEFAULT '1',
  "DownCount" bigint DEFAULT '0',
  "ParentID" int DEFAULT NULL,
  "IsAnonymized" bit DEFAULT b'0',
  "IsDistinguished" bit DEFAULT b'0',
  "FormattedContent" text,
  "IsDeleted" bit DEFAULT b'0',
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Comment"
--


/*!40000 ALTER TABLE "Comment" DISABLE KEYS */;
/*!40000 ALTER TABLE "Comment" ENABLE KEYS */;


--
-- Table structure for table "CommentSaveTracker"
--

DROP TABLE IF EXISTS "CommentSaveTracker";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "CommentSaveTracker" (
  "ID" int NOT NULL,
  "CommentID" int NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "CommentSaveTracker"
--


/*!40000 ALTER TABLE "CommentSaveTracker" DISABLE KEYS */;
/*!40000 ALTER TABLE "CommentSaveTracker" ENABLE KEYS */;


--
-- Table structure for table "CommentVoteTracker"
--

DROP TABLE IF EXISTS "CommentVoteTracker";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "CommentVoteTracker" (
  "ID" int NOT NULL,
  "CommentID" int NOT NULL,
  "UserName" varchar(50) DEFAULT NULL,
  "VoteStatus" int DEFAULT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "IPAddress" varchar(90) DEFAULT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "CommentVoteTracker"
--


/*!40000 ALTER TABLE "CommentVoteTracker" DISABLE KEYS */;
/*!40000 ALTER TABLE "CommentVoteTracker" ENABLE KEYS */;


--
-- Table structure for table "ContentRemovalLog"
--

DROP TABLE IF EXISTS "ContentRemovalLog";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ContentRemovalLog" (
  "CommentID" int NOT NULL,
  "Moderator" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Reason" text NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ContentRemovalLog"
--


/*!40000 ALTER TABLE "ContentRemovalLog" DISABLE KEYS */;
/*!40000 ALTER TABLE "ContentRemovalLog" ENABLE KEYS */;


--
-- Table structure for table "DefaultSubverse"
--

DROP TABLE IF EXISTS "DefaultSubverse";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "DefaultSubverse" (
  "Subverse" varchar(20) NOT NULL,
  "Order" int NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "DefaultSubverse"
--


/*!40000 ALTER TABLE "DefaultSubverse" DISABLE KEYS */;
/*!40000 ALTER TABLE "DefaultSubverse" ENABLE KEYS */;


--
-- Table structure for table "EventLog"
--

DROP TABLE IF EXISTS "EventLog";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "EventLog" (
  "ID" int NOT NULL,
  "ParentID" int DEFAULT NULL,
  "ActivityID" varchar(50) DEFAULT NULL,
  "UserName" varchar(100) DEFAULT NULL,
  "Origin" varchar(20) DEFAULT NULL,
  "Type" text NOT NULL,
  "Message" text NOT NULL,
  "Category" text NOT NULL,
  "Exception" text,
  "Data" text,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "EventLog"
--


/*!40000 ALTER TABLE "EventLog" DISABLE KEYS */;
/*!40000 ALTER TABLE "EventLog" ENABLE KEYS */;


--
-- Table structure for table "FeaturedSubverse"
--

DROP TABLE IF EXISTS "FeaturedSubverse";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "FeaturedSubverse" (
  "ID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "CreatedBy" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "FeaturedSubverse"
--


/*!40000 ALTER TABLE "FeaturedSubverse" DISABLE KEYS */;
/*!40000 ALTER TABLE "FeaturedSubverse" ENABLE KEYS */;


--
-- Table structure for table "Message"
--

DROP TABLE IF EXISTS "Message";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "Message" (
  "ID" int NOT NULL,
  "CorrelationID" varchar(36) NOT NULL,
  "ParentID" int DEFAULT NULL,
  "Type" int NOT NULL,
  "Sender" varchar(50) NOT NULL,
  "SenderType" int NOT NULL,
  "Recipient" varchar(50) NOT NULL,
  "RecipientType" int NOT NULL,
  "Title" text,
  "Content" text,
  "FormattedContent" text,
  "Subverse" varchar(20) DEFAULT NULL,
  "SubmissionID" int DEFAULT NULL,
  "IsAnonymized" bit NOT NULL,
  "ReadDate" timestamp NOT NULL DEFAULT now(),
  "CreatedBy" varchar(50) DEFAULT NULL,
  "CreationDate" timestamp ,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Message"
--


/*!40000 ALTER TABLE "Message" DISABLE KEYS */;
/*!40000 ALTER TABLE "Message" ENABLE KEYS */;


--
-- Table structure for table "ModeratorInvitation"
--

DROP TABLE IF EXISTS "ModeratorInvitation";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ModeratorInvitation" (
  "ID" int NOT NULL,
  "CreatedBy" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Recipient" varchar(50) NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "Power" int NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ModeratorInvitation"
--


/*!40000 ALTER TABLE "ModeratorInvitation" DISABLE KEYS */;
/*!40000 ALTER TABLE "ModeratorInvitation" ENABLE KEYS */;


--
-- Table structure for table "SessionTracker"
--

DROP TABLE IF EXISTS "SessionTracker";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SessionTracker" (
  "SessionID" varchar(90) NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now()
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SessionTracker"
--


/*!40000 ALTER TABLE "SessionTracker" DISABLE KEYS */;
/*!40000 ALTER TABLE "SessionTracker" ENABLE KEYS */;


--
-- Table structure for table "StickiedSubmission"
--

DROP TABLE IF EXISTS "StickiedSubmission";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "StickiedSubmission" (
  "SubmissionID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now()
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "StickiedSubmission"
--


/*!40000 ALTER TABLE "StickiedSubmission" DISABLE KEYS */;
/*!40000 ALTER TABLE "StickiedSubmission" ENABLE KEYS */;


--
-- Table structure for table "Submission"
--

DROP TABLE IF EXISTS "Submission";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "Submission" (
  "ID" int NOT NULL,
  "IsArchived" bit DEFAULT b'0',
  "Votes" int DEFAULT NULL,
  "UserName" varchar(50) NOT NULL,
  "Content" text,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Type" int NOT NULL,
  "Title" varchar(200) DEFAULT NULL,
  "Rank" double precision NOT NULL DEFAULT '0',
  "Subverse" varchar(20) DEFAULT NULL,
  "UpCount" bigint NOT NULL DEFAULT '1',
  "DownCount" bigint NOT NULL DEFAULT '0',
  "Thumbnail" varchar(40) DEFAULT NULL,
  "LastEditDate" timestamp ,
  "FlairLabel" varchar(50) DEFAULT NULL,
  "FlairCss" varchar(50) DEFAULT NULL,
  "Views" double precision NOT NULL DEFAULT '1',
  "IsDeleted" bit DEFAULT b'0',
  "IsAnonymized" bit DEFAULT b'0',
  "RelativeRank" double precision NOT NULL DEFAULT '0',
  "Url" text,
  "FormattedContent" text,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Submission"
--


/*!40000 ALTER TABLE "Submission" DISABLE KEYS */;
/*!40000 ALTER TABLE "Submission" ENABLE KEYS */;


--
-- Table structure for table "SubmissionRemovalLog"
--

DROP TABLE IF EXISTS "SubmissionRemovalLog";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubmissionRemovalLog" (
  "SubmissionID" int NOT NULL,
  "Moderator" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Reason" text NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubmissionRemovalLog"
--


/*!40000 ALTER TABLE "SubmissionRemovalLog" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubmissionRemovalLog" ENABLE KEYS */;


--
-- Table structure for table "SubmissionSaveTracker"
--

DROP TABLE IF EXISTS "SubmissionSaveTracker";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubmissionSaveTracker" (
  "ID" int NOT NULL,
  "SubmissionID" int NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubmissionSaveTracker"
--


/*!40000 ALTER TABLE "SubmissionSaveTracker" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubmissionSaveTracker" ENABLE KEYS */;


--
-- Table structure for table "SubmissionVoteTracker"
--

DROP TABLE IF EXISTS "SubmissionVoteTracker";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubmissionVoteTracker" (
  "ID" int NOT NULL,
  "SubmissionID" int NOT NULL,
  "UserName" varchar(50) DEFAULT NULL,
  "VoteStatus" int DEFAULT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "IPAddress" varchar(90) DEFAULT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubmissionVoteTracker"
--


/*!40000 ALTER TABLE "SubmissionVoteTracker" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubmissionVoteTracker" ENABLE KEYS */;


--
-- Table structure for table "Subverse"
--

DROP TABLE IF EXISTS "Subverse";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "Subverse" (
  "Name" varchar(20) NOT NULL,
  "Title" text NOT NULL,
  "Description" text,
  "SideBar" text,
  "SubmissionText" text,
  "Language" varchar(10) DEFAULT NULL,
  "Type" varchar(10) NOT NULL,
  "SubmitLinkLabel" varchar(50) DEFAULT NULL,
  "SubmitPostLabel" varchar(50) DEFAULT NULL,
  "SpamFilterLink" varchar(10) DEFAULT NULL,
  "SpamFilterPost" varchar(10) DEFAULT NULL,
  "SpamFilterComment" varchar(10) DEFAULT NULL,
  "IsAdult" bit DEFAULT b'0',
  "IsDefaultAllowed" bit DEFAULT b'1',
  "IsThumbnailEnabled" bit DEFAULT b'1',
  "ExcludeSitewideBans" bit DEFAULT b'0',
  "IsTrafficStatsPublic" bit DEFAULT b'0',
  "MinutesToHideComments" int DEFAULT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Stylesheet" text,
  "SubscriberCount" int DEFAULT NULL,
  "IsPrivate" bit DEFAULT b'0',
  "IsAuthorizedOnly" bit DEFAULT b'0',
  "IsAnonymized" bit DEFAULT b'0',
  "LastSubmissionDate" timestamp ,
  "MinCCPForDownVote" int NOT NULL DEFAULT '0',
  "IsAdminPrivate" bit DEFAULT b'0',
  "IsAdminDisabled" bit DEFAULT NULL,
  "CreatedBy" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("Name")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Subverse"
--


/*!40000 ALTER TABLE "Subverse" DISABLE KEYS */;
/*!40000 ALTER TABLE "Subverse" ENABLE KEYS */;


--
-- Table structure for table "SubverseBan"
--

DROP TABLE IF EXISTS "SubverseBan";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubverseBan" (
  "ID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "CreatedBy" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "Reason" text NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubverseBan"
--


/*!40000 ALTER TABLE "SubverseBan" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubverseBan" ENABLE KEYS */;


--
-- Table structure for table "SubverseFlair"
--

DROP TABLE IF EXISTS "SubverseFlair";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubverseFlair" (
  "ID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "Label" varchar(50) DEFAULT NULL,
  "CssClass" varchar(50) DEFAULT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubverseFlair"
--


/*!40000 ALTER TABLE "SubverseFlair" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubverseFlair" ENABLE KEYS */;


--
-- Table structure for table "SubverseModerator"
--

DROP TABLE IF EXISTS "SubverseModerator";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubverseModerator" (
  "ID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "Power" int NOT NULL,
  "CreatedBy" varchar(50) DEFAULT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubverseModerator"
--


/*!40000 ALTER TABLE "SubverseModerator" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubverseModerator" ENABLE KEYS */;


--
-- Table structure for table "SubverseSubscription"
--

DROP TABLE IF EXISTS "SubverseSubscription";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "SubverseSubscription" (
  "ID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "UserName" varchar(50) NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "SubverseSubscription"
--


/*!40000 ALTER TABLE "SubverseSubscription" DISABLE KEYS */;
/*!40000 ALTER TABLE "SubverseSubscription" ENABLE KEYS */;


--
-- Table structure for table "UserBadge"
--

DROP TABLE IF EXISTS "UserBadge";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserBadge" (
  "ID" int NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "BadgeID" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserBadge"
--


/*!40000 ALTER TABLE "UserBadge" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserBadge" ENABLE KEYS */;


--
-- Table structure for table "UserBlockedSubverse"
--

DROP TABLE IF EXISTS "UserBlockedSubverse";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserBlockedSubverse" (
  "ID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserBlockedSubverse"
--


/*!40000 ALTER TABLE "UserBlockedSubverse" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserBlockedSubverse" ENABLE KEYS */;


--
-- Table structure for table "UserBlockedUser"
--

DROP TABLE IF EXISTS "UserBlockedUser";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserBlockedUser" (
  "ID" int NOT NULL,
  "BlockUser" varchar(50) NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserBlockedUser"
--


/*!40000 ALTER TABLE "UserBlockedUser" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserBlockedUser" ENABLE KEYS */;


--
-- Table structure for table "UserPreference"
--

DROP TABLE IF EXISTS "UserPreference";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserPreference" (
  "UserName" varchar(50) NOT NULL,
  "DisableCSS" bit NOT NULL,
  "NightMode" bit NOT NULL,
  "Language" varchar(50) NOT NULL,
  "OpenInNewWindow" bit NOT NULL,
  "EnableAdultContent" bit NOT NULL,
  "DisplayVotes" bit NOT NULL,
  "DisplaySubscriptions" bit DEFAULT b'0',
  "UseSubscriptionsMenu" bit DEFAULT b'1',
  "Bio" varchar(100) DEFAULT NULL,
  "Avatar" varchar(50) DEFAULT NULL,
  "DisplayAds" bit DEFAULT b'0',
  "DisplayCommentCount" int DEFAULT NULL,
  "HighLightMinutes" int DEFAULT NULL,
  "VanityTitle" varchar(50) DEFAULT NULL,
  "CollapseCommentLimit" int DEFAULT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserPreference"
--


/*!40000 ALTER TABLE "UserPreference" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserPreference" ENABLE KEYS */;


--
-- Table structure for table "UserSet"
--

DROP TABLE IF EXISTS "UserSet";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserSet" (
  "ID" int NOT NULL,
  "Name" varchar(20) NOT NULL,
  "Description" varchar(200) NOT NULL,
  "CreatedBy" varchar(20) NOT NULL,
  "CreationDate" timestamp NOT NULL DEFAULT now(),
  "IsPublic" bit DEFAULT b'1',
  "SubscriberCount" int NOT NULL DEFAULT '1',
  "IsDefault" bit DEFAULT b'0',
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserSet"
--


/*!40000 ALTER TABLE "UserSet" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserSet" ENABLE KEYS */;


--
-- Table structure for table "UserSetList"
--

DROP TABLE IF EXISTS "UserSetList";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserSetList" (
  "ID" int NOT NULL,
  "UserSetID" int NOT NULL,
  "Subverse" varchar(20) NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserSetList"
--


/*!40000 ALTER TABLE "UserSetList" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserSetList" ENABLE KEYS */;


--
-- Table structure for table "UserSetSubscription"
--

DROP TABLE IF EXISTS "UserSetSubscription";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserSetSubscription" (
  "ID" int NOT NULL,
  "UserSetID" int NOT NULL,
  "Order" int NOT NULL DEFAULT '0',
  "UserName" varchar(20) NOT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserSetSubscription"
--


/*!40000 ALTER TABLE "UserSetSubscription" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserSetSubscription" ENABLE KEYS */;


--
-- Table structure for table "UserVisit"
--

DROP TABLE IF EXISTS "UserVisit";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "UserVisit" (
  "ID" int NOT NULL,
  "SubmissionID" int NOT NULL,
  "UserName" varchar(50) NOT NULL,
  "LastVisitDate" timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "UserVisit"
--


/*!40000 ALTER TABLE "UserVisit" DISABLE KEYS */;
/*!40000 ALTER TABLE "UserVisit" ENABLE KEYS */;


--
-- Table structure for table "ViewStatistic"
--

DROP TABLE IF EXISTS "ViewStatistic";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "ViewStatistic" (
  "SubmissionID" int NOT NULL,
  "ViewerID" varchar(90) NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "ViewStatistic"
--


/*!40000 ALTER TABLE "ViewStatistic" DISABLE KEYS */;
/*!40000 ALTER TABLE "ViewStatistic" ENABLE KEYS */;


