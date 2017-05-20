--
-- Database: `voat_users`
--
CREATE DATABASE IF NOT EXISTS `voat_users` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `voat_users`;

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
CREATE TABLE IF NOT EXISTS `applications` (
  `ApplicationId` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationName` varchar(256) NOT NULL,
  `LoweredApplicationName` varchar(256) NOT NULL,
  `Description` varchar(256) NOT NULL,
  PRIMARY KEY (`ApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `aspnetroles`
--

DROP TABLE IF EXISTS `aspnetroles`;
CREATE TABLE IF NOT EXISTS `aspnetroles` (
  `Id` varchar(128) NOT NULL,
  `Name` varchar(4096) NOT NULL,
  `baxt` int(11) NOT NULL,
  `saxt` int(11) NOT NULL,
  PRIMARY KEY (`Id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

DROP TABLE IF EXISTS `membership`;
CREATE TABLE IF NOT EXISTS `membership` (
  `ApplicationId` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `Password` varchar(128) NOT NULL,
  `PasswordFormat` int(11) NOT NULL,
  `PasswordSalt` varchar(128) NOT NULL,
  `MobilePIN` varchar(16) NOT NULL,
  `Email` varchar(256) NOT NULL,
  `LoweredEmail` varchar(256) NOT NULL,
  `PasswordQuestion` varchar(256) NOT NULL,
  `PasswordAnswer` varchar(128) NOT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `IsLockedOut` tinyint(1) NOT NULL,
  `CreateDate` datetime NOT NULL,
  `LastLoginDate` datetime NOT NULL,
  `LastPasswordChangedDate` datetime NOT NULL,
  `LastLockoutDate` datetime NOT NULL,
  `FailedPasswordAttemptCount` int(11) NOT NULL,
  `FailedPasswordAttemptWindowStart` datetime NOT NULL,
  `FailedPasswordAnswerAttemptCount` int(11) NOT NULL,
  `FailedPasswordAnswerAttemptWindowStart` datetime NOT NULL,
  `Comment` text,
  PRIMARY KEY (`ApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `paths`
--

DROP TABLE IF EXISTS `paths`;
CREATE TABLE IF NOT EXISTS `paths` (
  `ApplicationId` int(11) NOT NULL AUTO_INCREMENT,
  `PathId` int(11) NOT NULL,
  `Path` varchar(256) NOT NULL,
  `LoweredPath` varchar(256) NOT NULL,
  PRIMARY KEY (`ApplicationId`),
  UNIQUE KEY `PathId` (`PathId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `personalizationallusers`
--

DROP TABLE IF EXISTS `personalizationallusers`;
CREATE TABLE IF NOT EXISTS `personalizationallusers` (
  `PathId` int(11) NOT NULL AUTO_INCREMENT,
  `PageSettings` blob NOT NULL,
  `LastUpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`PathId`),
  UNIQUE KEY `PathId` (`PathId`),
  UNIQUE KEY `PathId_2` (`PathId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `personalizationperuser`
--

DROP TABLE IF EXISTS `personalizationperuser`;
CREATE TABLE IF NOT EXISTS `personalizationperuser` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PathId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `PageSettings` blob NOT NULL,
  `LastUpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `PathId` (`PathId`),
  UNIQUE KEY `UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
CREATE TABLE IF NOT EXISTS `profile` (
  `UserId` int(11) NOT NULL,
  `PropertyNames` text NOT NULL,
  `PropertyValuesString` text NOT NULL,
  `PropertyValuesBinary` blob NOT NULL,
  `LastUpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `ApplicationId` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL,
  `RoleName` varchar(256) NOT NULL,
  `LoweredRoleName` varchar(256) NOT NULL,
  `Description` varchar(256) NOT NULL,
  PRIMARY KEY (`RoleId`),
  UNIQUE KEY `ApplicationId` (`ApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `schemaversions`
--

DROP TABLE IF EXISTS `schemaversions`;
CREATE TABLE IF NOT EXISTS `schemaversions` (
  `Feature` varchar(128) NOT NULL,
  `CompatibleSchemaVersion` varchar(128) NOT NULL,
  `IsCurrentVersion` tinyint(1) NOT NULL,
  PRIMARY KEY (`Feature`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `SessionId` varchar(88) NOT NULL,
  `Created` datetime NOT NULL,
  `Expires` datetime NOT NULL,
  `LockDate` datetime NOT NULL,
  `LockCookie` int(11) NOT NULL,
  `Locked` tinyint(1) NOT NULL,
  `SessionItem` blob NOT NULL,
  `Flags` int(11) NOT NULL,
  `Timeout` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `ApplicationId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `UserName` varchar(256) NOT NULL,
  `LoweredUserName` varchar(256) NOT NULL,
  `MobileAlias` varchar(16) NOT NULL,
  `IsAnonymous` tinyint(1) NOT NULL,
  `LastActivityDate` datetime NOT NULL,
  PRIMARY KEY (`UserId`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usersinroles`
--

DROP TABLE IF EXISTS `usersinroles`;
CREATE TABLE IF NOT EXISTS `usersinroles` (
  `UserId` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL,
  `naxt` int(11) NOT NULL,
  `baxt` int(11) NOT NULL,
  PRIMARY KEY (`RoleId`),
  UNIQUE KEY `UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_applications`
--

DROP TABLE IF EXISTS `vw_aspnet_applications`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_applications` (
  `ApplicationName` varchar(256) NOT NULL,
  `LoweredApplicationName` varchar(256) NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `Description` varchar(256) NOT NULL,
  PRIMARY KEY (`ApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_membershipusers`
--

DROP TABLE IF EXISTS `vw_aspnet_membershipusers`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_membershipusers` (
  `UserId` int(11) NOT NULL,
  `PasswordFormat` int(11) NOT NULL,
  `MobilePIN` varchar(16) NOT NULL,
  `Email` varchar(256) NOT NULL,
  `LoweredEmail` varchar(256) NOT NULL,
  `PasswordQuestion` varchar(256) NOT NULL,
  `PasswordAnswer` varchar(256) NOT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `IsLockedOut` tinyint(1) NOT NULL,
  `CreateDate` datetime NOT NULL,
  `LastLoginDate` datetime NOT NULL,
  `LastPasswordChangedDate` datetime NOT NULL,
  `LastLockoutDate` datetime NOT NULL,
  `FailedPasswordAttemptCount` int(11) NOT NULL,
  `FailedPasswordAttemptWindowStart` datetime NOT NULL,
  `FailedPasswordAnswerAttemptCount` int(11) NOT NULL,
  `FailedPasswordAnswerAttemptWindowStart` datetime NOT NULL,
  `Comment` text NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `UserName` varchar(256) NOT NULL,
  `MobileAlias` varchar(16) NOT NULL,
  `IsAnonymous` tinyint(1) NOT NULL,
  `LastActivityDate` datetime NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `ApplicationId` (`ApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_profiles`
--

DROP TABLE IF EXISTS `vw_aspnet_profiles`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_profiles` (
  `UserId` int(11) NOT NULL,
  `LastUpdatedDate` int(11) NOT NULL,
  `DataSize` datetime NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `LastUpdatedDate` (`LastUpdatedDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_roles`
--

DROP TABLE IF EXISTS `vw_aspnet_roles`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_roles` (
  `ApplicationId` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL,
  `RoleName` varchar(256) NOT NULL,
  `LoweredRoleName` varchar(256) NOT NULL,
  `Description` varchar(256) NOT NULL,
  PRIMARY KEY (`ApplicationId`,`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_users`
--

DROP TABLE IF EXISTS `vw_aspnet_users`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_users` (
  `ApplicationId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `UserName` varchar(256) NOT NULL,
  `LoweredUserName` varchar(256) NOT NULL,
  `MobileAlias` varchar(16) NOT NULL,
  `IsAnonymous` tinyint(1) NOT NULL,
  `LastActivityDate` datetime NOT NULL,
  UNIQUE KEY `ApplicationId` (`ApplicationId`,`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_usersinroles`
--

DROP TABLE IF EXISTS `vw_aspnet_usersinroles`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_usersinroles` (
  `UserId` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_webpartstate_paths`
--

DROP TABLE IF EXISTS `vw_aspnet_webpartstate_paths`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_webpartstate_paths` (
  `ApplicationId` int(11) NOT NULL,
  `PathId` int(11) NOT NULL,
  `Path` varchar(256) NOT NULL,
  `LoweredPath` varchar(256) NOT NULL,
  PRIMARY KEY (`ApplicationId`,`PathId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_webpartstate_shared`
--

DROP TABLE IF EXISTS `vw_aspnet_webpartstate_shared`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_webpartstate_shared` (
  `PathId` int(11) NOT NULL,
  `DataSize` int(11) DEFAULT NULL,
  `LastUpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`PathId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vw_aspnet_webpartstate_user`
--

DROP TABLE IF EXISTS `vw_aspnet_webpartstate_user`;
CREATE TABLE IF NOT EXISTS `vw_aspnet_webpartstate_user` (
  `PathId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `DataSize` int(11) DEFAULT NULL,
  `LastUpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `PathId` (`PathId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `webevent_events`
--

DROP TABLE IF EXISTS `webevent_events`;
CREATE TABLE IF NOT EXISTS `webevent_events` (
  `EventId` char(32) NOT NULL,
  `EventTimeUtc` datetime NOT NULL,
  `EventTime` datetime NOT NULL,
  `EventType` varchar(256) NOT NULL,
  `EventSequence` decimal(19,0) NOT NULL,
  `EventOccurrence` decimal(19,0) NOT NULL,
  `EventCode` int(11) NOT NULL,
  `EventDetailCode` int(11) NOT NULL,
  `Message` varchar(1024) NOT NULL,
  `ApplicationPath` varchar(256) NOT NULL,
  `ApplicationVirtualPath` varchar(256) NOT NULL,
  `MachineName` varchar(256) NOT NULL,
  `RequestUrl` varchar(1024) NOT NULL,
  `ExceptionType` varchar(256) NOT NULL,
  `Details` text NOT NULL,
  PRIMARY KEY (`EventId`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
