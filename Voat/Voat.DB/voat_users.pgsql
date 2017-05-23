--
-- Current Database: "voat_users"
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ "voat_users" /*!40100 DEFAULT CHARACTER SET utf8 */;

USE "voat_users";

--
-- Table structure for table "applications"
--

DROP TABLE IF EXISTS "applications";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "applications" (
  "ApplicationId" int NOT NULL,
  "ApplicationName" varchar(256) NOT NULL,
  "LoweredApplicationName" varchar(256) NOT NULL,
  "Description" varchar(256) NOT NULL,
  PRIMARY KEY ("ApplicationId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "applications"
--


/*!40000 ALTER TABLE "applications" DISABLE KEYS */;
/*!40000 ALTER TABLE "applications" ENABLE KEYS */;


--
-- Table structure for table "aspnetroles"
--

DROP TABLE IF EXISTS "aspnetroles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "aspnetroles" (
  "Id" varchar(128) NOT NULL,
  "Name" varchar(4096) NOT NULL,
  "baxt" int NOT NULL,
  "saxt" int NOT NULL,
  PRIMARY KEY ("Id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "aspnetroles"
--


/*!40000 ALTER TABLE "aspnetroles" DISABLE KEYS */;
/*!40000 ALTER TABLE "aspnetroles" ENABLE KEYS */;


--
-- Table structure for table "aspnetuserclaims"
--

DROP TABLE IF EXISTS "aspnetuserclaims";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "aspnetuserclaims" (
  "Id" int NOT NULL,
  "ClaimType" varchar(4096) NOT NULL,
  "ClaimValue" varchar(4096) NOT NULL,
  "UserId" varchar(128) NOT NULL,
  PRIMARY KEY ("Id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "aspnetuserclaims"
--


/*!40000 ALTER TABLE "aspnetuserclaims" DISABLE KEYS */;
/*!40000 ALTER TABLE "aspnetuserclaims" ENABLE KEYS */;


--
-- Table structure for table "aspnetuserlogins"
--

DROP TABLE IF EXISTS "aspnetuserlogins";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "aspnetuserlogins" (
  "UserId" varchar(128) NOT NULL,
  "LoginProvider" varchar(128) NOT NULL,
  "ProviderKey" varchar(128) NOT NULL,
  PRIMARY KEY ("UserId","LoginProvider","ProviderKey")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "aspnetuserlogins"
--


/*!40000 ALTER TABLE "aspnetuserlogins" DISABLE KEYS */;
/*!40000 ALTER TABLE "aspnetuserlogins" ENABLE KEYS */;


--
-- Table structure for table "aspnetuserroles"
--

DROP TABLE IF EXISTS "aspnetuserroles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "aspnetuserroles" (
  "UserId" varchar(128) NOT NULL,
  "RoleId" varchar(128) NOT NULL,
  PRIMARY KEY ("UserId","RoleId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "aspnetuserroles"
--


/*!40000 ALTER TABLE "aspnetuserroles" DISABLE KEYS */;
/*!40000 ALTER TABLE "aspnetuserroles" ENABLE KEYS */;


--
-- Table structure for table "aspnetusers"
--

DROP TABLE IF EXISTS "aspnetusers";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "aspnetusers" (
  "Id" varchar(128) NOT NULL,
  "UserName" varchar(800) NOT NULL,
  "PasswordHash" varchar(4096) NOT NULL,
  "SecurityStamp" varchar(4096) NOT NULL,
  "Email" varchar(4096) NOT NULL,
  "IsConfirmed" bit NOT NULL,
  "EmailConfirmed" bit NOT NULL,
  "PhoneNumber" char(10) NOT NULL,
  "PhoneNumberConfirmed" bit NOT NULL,
  "TwoFactorEnabled" bit NOT NULL,
  "LockoutEndDateUtc" timestamp NOT NULL,
  "LockoutEnabled" bit NOT NULL,
  "AccessFailedCount" int NOT NULL,
  "RegistrationDateTime" timestamp NOT NULL,
  "RecoveryQuestion" varchar(1024) NOT NULL,
  "Answer" varchar(1024) NOT NULL,
  "Partner" bit NOT NULL,
  "LastLoginFromIp" varchar(50) NOT NULL,
  "LastLoginDateTime" timestamp NOT NULL,
  PRIMARY KEY ("Id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "aspnetusers"
--


/*!40000 ALTER TABLE "aspnetusers" DISABLE KEYS */;
/*!40000 ALTER TABLE "aspnetusers" ENABLE KEYS */;


--
-- Table structure for table "membership"
--

DROP TABLE IF EXISTS "membership";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "membership" (
  "ApplicationId" int NOT NULL,
  "UserId" int NOT NULL,
  "Password" varchar(128) NOT NULL,
  "PasswordFormat" int NOT NULL,
  "PasswordSalt" varchar(128) NOT NULL,
  "MobilePIN" varchar(16) NOT NULL,
  "Email" varchar(256) NOT NULL,
  "LoweredEmail" varchar(256) NOT NULL,
  "PasswordQuestion" varchar(256) NOT NULL,
  "PasswordAnswer" varchar(128) NOT NULL,
  "IsApproved" bit NOT NULL,
  "IsLockedOut" bit NOT NULL,
  "CreateDate" timestamp NOT NULL,
  "LastLoginDate" timestamp NOT NULL,
  "LastPasswordChangedDate" timestamp NOT NULL,
  "LastLockoutDate" timestamp NOT NULL,
  "FailedPasswordAttemptCount" int NOT NULL,
  "FailedPasswordAttemptWindowStart" timestamp NOT NULL,
  "FailedPasswordAnswerAttemptCount" int NOT NULL,
  "FailedPasswordAnswerAttemptWindowStart" timestamp NOT NULL,
  "Comment" text,
  PRIMARY KEY ("ApplicationId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "membership"
--


/*!40000 ALTER TABLE "membership" DISABLE KEYS */;
/*!40000 ALTER TABLE "membership" ENABLE KEYS */;


--
-- Table structure for table "paths"
--

DROP TABLE IF EXISTS "paths";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "paths" (
  "ApplicationId" int NOT NULL,
  "PathId" int NOT NULL UNIQUE,
  "Path" varchar(256) NOT NULL,
  "LoweredPath" varchar(256) NOT NULL,
  PRIMARY KEY ("ApplicationId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "paths"
--


/*!40000 ALTER TABLE "paths" DISABLE KEYS */;
/*!40000 ALTER TABLE "paths" ENABLE KEYS */;


--
-- Table structure for table "personalizationallusers"
--

DROP TABLE IF EXISTS "personalizationallusers";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "personalizationallusers" (
  "PathId" int NOT NULL,
  "PageSettings" bytea NOT NULL,
  "LastUpdatedDate" timestamp NOT NULL,
  PRIMARY KEY ("PathId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "personalizationallusers"
--


/*!40000 ALTER TABLE "personalizationallusers" DISABLE KEYS */;
/*!40000 ALTER TABLE "personalizationallusers" ENABLE KEYS */;


--
-- Table structure for table "personalizationperuser"
--

DROP TABLE IF EXISTS "personalizationperuser";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "personalizationperuser" (
  "Id" int NOT NULL,
  "PathId" int NOT NULL UNIQUE,
  "UserId" int NOT NULL,
  "PageSettings" bytea NOT NULL,
  "LastUpdatedDate" timestamp NOT NULL,
  PRIMARY KEY ("Id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "personalizationperuser"
--


/*!40000 ALTER TABLE "personalizationperuser" DISABLE KEYS */;
/*!40000 ALTER TABLE "personalizationperuser" ENABLE KEYS */;


--
-- Table structure for table "profile"
--

DROP TABLE IF EXISTS "profile";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "profile" (
  "UserId" int NOT NULL,
  "PropertyNames" text NOT NULL,
  "PropertyValuesString" text NOT NULL,
  "PropertyValuesBinary" bytea NOT NULL,
  "LastUpdatedDate" timestamp NOT NULL,
  PRIMARY KEY ("UserId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "profile"
--


/*!40000 ALTER TABLE "profile" DISABLE KEYS */;
/*!40000 ALTER TABLE "profile" ENABLE KEYS */;


--
-- Table structure for table "roles"
--

DROP TABLE IF EXISTS "roles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "roles" (
  "ApplicationId" int NOT NULL UNIQUE,
  "RoleId" int NOT NULL,
  "RoleName" varchar(256) NOT NULL,
  "LoweredRoleName" varchar(256) NOT NULL,
  "Description" varchar(256) NOT NULL,
  PRIMARY KEY ("RoleId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "roles"
--


/*!40000 ALTER TABLE "roles" DISABLE KEYS */;
/*!40000 ALTER TABLE "roles" ENABLE KEYS */;


--
-- Table structure for table "schemaversions"
--

DROP TABLE IF EXISTS "schemaversions";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "schemaversions" (
  "Feature" varchar(128) NOT NULL,
  "CompatibleSchemaVersion" varchar(128) NOT NULL,
  "IsCurrentVersion" bit NOT NULL,
  PRIMARY KEY ("Feature")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "schemaversions"
--


/*!40000 ALTER TABLE "schemaversions" DISABLE KEYS */;
/*!40000 ALTER TABLE "schemaversions" ENABLE KEYS */;


--
-- Table structure for table "sessions"
--

DROP TABLE IF EXISTS "sessions";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "sessions" (
  "SessionId" varchar(88) NOT NULL,
  "Created" timestamp NOT NULL,
  "Expires" timestamp NOT NULL,
  "LockDate" timestamp NOT NULL,
  "LockCookie" int NOT NULL,
  "Locked" bit NOT NULL,
  "SessionItem" bytea NOT NULL,
  "Flags" int NOT NULL,
  "Timeout" int NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "sessions"
--


/*!40000 ALTER TABLE "sessions" DISABLE KEYS */;
/*!40000 ALTER TABLE "sessions" ENABLE KEYS */;


--
-- Table structure for table "users"
--

DROP TABLE IF EXISTS "users";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users" (
  "ApplicationId" int NOT NULL,
  "UserId" int NOT NULL,
  "UserName" varchar(256) NOT NULL,
  "LoweredUserName" varchar(256) NOT NULL,
  "MobileAlias" varchar(16) NOT NULL,
  "IsAnonymous" bit NOT NULL,
  "LastActivityDate" timestamp NOT NULL,
  PRIMARY KEY ("UserId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "users"
--


/*!40000 ALTER TABLE "users" DISABLE KEYS */;
/*!40000 ALTER TABLE "users" ENABLE KEYS */;


--
-- Table structure for table "usersinroles"
--

DROP TABLE IF EXISTS "usersinroles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "usersinroles" (
  "UserId" int NOT NULL UNIQUE,
  "RoleId" int NOT NULL,
  "naxt" int NOT NULL,
  "baxt" int NOT NULL,
  PRIMARY KEY ("RoleId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "usersinroles"
--


/*!40000 ALTER TABLE "usersinroles" DISABLE KEYS */;
/*!40000 ALTER TABLE "usersinroles" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_applications"
--

DROP TABLE IF EXISTS "vw_aspnet_applications";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_applications" (
  "ApplicationName" varchar(256) NOT NULL,
  "LoweredApplicationName" varchar(256) NOT NULL,
  "ApplicationId" int NOT NULL,
  "Description" varchar(256) NOT NULL,
  PRIMARY KEY ("ApplicationId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_applications"
--


/*!40000 ALTER TABLE "vw_aspnet_applications" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_applications" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_membershipusers"
--

DROP TABLE IF EXISTS "vw_aspnet_membershipusers";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_membershipusers" (
  "UserId" int NOT NULL,
  "PasswordFormat" int NOT NULL,
  "MobilePIN" varchar(16) NOT NULL,
  "Email" varchar(256) NOT NULL,
  "LoweredEmail" varchar(256) NOT NULL,
  "PasswordQuestion" varchar(256) NOT NULL,
  "PasswordAnswer" varchar(256) NOT NULL,
  "IsApproved" bit NOT NULL,
  "IsLockedOut" bit NOT NULL,
  "CreateDate" timestamp NOT NULL,
  "LastLoginDate" timestamp NOT NULL,
  "LastPasswordChangedDate" timestamp NOT NULL,
  "LastLockoutDate" timestamp NOT NULL,
  "FailedPasswordAttemptCount" int NOT NULL,
  "FailedPasswordAttemptWindowStart" timestamp NOT NULL,
  "FailedPasswordAnswerAttemptCount" int NOT NULL,
  "FailedPasswordAnswerAttemptWindowStart" timestamp NOT NULL,
  "Comment" text NOT NULL,
  "ApplicationId" int NOT NULL UNIQUE,
  "UserName" varchar(256) NOT NULL,
  "MobileAlias" varchar(16) NOT NULL,
  "IsAnonymous" bit NOT NULL,
  "LastActivityDate" timestamp NOT NULL,
  PRIMARY KEY ("UserId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_membershipusers"
--


/*!40000 ALTER TABLE "vw_aspnet_membershipusers" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_membershipusers" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_profiles"
--

DROP TABLE IF EXISTS "vw_aspnet_profiles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_profiles" (
  "UserId" int NOT NULL,
  "LastUpdatedDate" int NOT NULL,
  "DataSize" timestamp NOT NULL,
  PRIMARY KEY ("UserId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_profiles"
--


/*!40000 ALTER TABLE "vw_aspnet_profiles" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_profiles" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_roles"
--

DROP TABLE IF EXISTS "vw_aspnet_roles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_roles" (
  "ApplicationId" int NOT NULL,
  "RoleId" int NOT NULL,
  "RoleName" varchar(256) NOT NULL,
  "LoweredRoleName" varchar(256) NOT NULL,
  "Description" varchar(256) NOT NULL,
  PRIMARY KEY ("ApplicationId","RoleId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_roles"
--


/*!40000 ALTER TABLE "vw_aspnet_roles" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_roles" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_users"
--

DROP TABLE IF EXISTS "vw_aspnet_users";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_users" (
  "ApplicationId" int NOT NULL UNIQUE,
  "UserId" int NOT NULL UNIQUE,
  "UserName" varchar(256) NOT NULL,
  "LoweredUserName" varchar(256) NOT NULL,
  "MobileAlias" varchar(16) NOT NULL,
  "IsAnonymous" bit NOT NULL,
  "LastActivityDate" timestamp NOT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_users"
--


/*!40000 ALTER TABLE "vw_aspnet_users" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_users" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_usersinroles"
--

DROP TABLE IF EXISTS "vw_aspnet_usersinroles";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_usersinroles" (
  "UserId" int NOT NULL,
  "RoleId" int NOT NULL,
  PRIMARY KEY ("UserId","RoleId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_usersinroles"
--


/*!40000 ALTER TABLE "vw_aspnet_usersinroles" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_usersinroles" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_webpartstate_paths"
--

DROP TABLE IF EXISTS "vw_aspnet_webpartstate_paths";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_webpartstate_paths" (
  "ApplicationId" int NOT NULL,
  "PathId" int NOT NULL,
  "Path" varchar(256) NOT NULL,
  "LoweredPath" varchar(256) NOT NULL,
  PRIMARY KEY ("ApplicationId","PathId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_webpartstate_paths"
--


/*!40000 ALTER TABLE "vw_aspnet_webpartstate_paths" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_webpartstate_paths" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_webpartstate_shared"
--

DROP TABLE IF EXISTS "vw_aspnet_webpartstate_shared";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_webpartstate_shared" (
  "PathId" int NOT NULL,
  "DataSize" int DEFAULT NULL,
  "LastUpdatedDate" timestamp NOT NULL,
  PRIMARY KEY ("PathId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_webpartstate_shared"
--


/*!40000 ALTER TABLE "vw_aspnet_webpartstate_shared" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_webpartstate_shared" ENABLE KEYS */;


--
-- Table structure for table "vw_aspnet_webpartstate_user"
--

DROP TABLE IF EXISTS "vw_aspnet_webpartstate_user";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "vw_aspnet_webpartstate_user" (
  "PathId" int NOT NULL UNIQUE,
  "UserId" int NOT NULL,
  "DataSize" int DEFAULT NULL,
  "LastUpdatedDate" timestamp NOT NULL,
  PRIMARY KEY ("UserId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vw_aspnet_webpartstate_user"
--


/*!40000 ALTER TABLE "vw_aspnet_webpartstate_user" DISABLE KEYS */;
/*!40000 ALTER TABLE "vw_aspnet_webpartstate_user" ENABLE KEYS */;


--
-- Table structure for table "webevent_events"
--

DROP TABLE IF EXISTS "webevent_events";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "webevent_events" (
  "EventId" char(32) NOT NULL,
  "EventTimeUtc" timestamp NOT NULL,
  "EventTime" timestamp NOT NULL,
  "EventType" varchar(256) NOT NULL,
  "EventSequence" decimal(19,0) NOT NULL,
  "EventOccurrence" decimal(19,0) NOT NULL,
  "EventCode" int NOT NULL,
  "EventDetailCode" int NOT NULL,
  "Message" varchar(1024) NOT NULL,
  "ApplicationPath" varchar(256) NOT NULL,
  "ApplicationVirtualPath" varchar(256) NOT NULL,
  "MachineName" varchar(256) NOT NULL,
  "RequestUrl" varchar(1024) NOT NULL,
  "ExceptionType" varchar(256) NOT NULL,
  "Details" text NOT NULL,
  PRIMARY KEY ("EventId")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "webevent_events"
--


/*!40000 ALTER TABLE "webevent_events" DISABLE KEYS */;
/*!40000 ALTER TABLE "webevent_events" ENABLE KEYS */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-23  0:14:22
