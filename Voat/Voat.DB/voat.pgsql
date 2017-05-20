--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ad; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE ad (
    id integer NOT NULL,
    isactive bit(1) DEFAULT (1)::bit(1) NOT NULL,
    graphicurl character varying(100) NOT NULL,
    destinationurl character varying(1000),
    name character varying(100) NOT NULL,
    description character varying(2000) NOT NULL,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    subverse character varying(50),
    creationdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ad OWNER TO voat;

--
-- Name: apiclient; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE apiclient (
    id integer NOT NULL,
    isactive bit(1) DEFAULT (1)::bit(1) NOT NULL,
    username character varying(100),
    appname character varying(50) NOT NULL,
    appdescription character varying(2000),
    appabouturl character varying(200),
    redirecturl character varying(200),
    publickey character varying(100) NOT NULL,
    privatekey character varying(100) NOT NULL,
    lastaccessdate timestamp without time zone,
    creationdate timestamp without time zone DEFAULT now(),
    apithrottlepolicyid integer,
    apipermissionpolicyid integer
);


ALTER TABLE public.apiclient OWNER TO voat;

--
-- Name: apicorspolicy; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE apicorspolicy (
    id integer NOT NULL,
    isactive bit(1) NOT NULL,
    alloworigin character varying(100) NOT NULL,
    allowmethods character varying(100) NOT NULL,
    allowheaders character varying(100) NOT NULL,
    allowcredentials bit(1),
    maxage integer,
    username character varying(100),
    description character varying(500),
    createdby character varying(100) NOT NULL,
    creationdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.apicorspolicy OWNER TO voat;

--
-- Name: apilog; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE apilog (
    id integer NOT NULL,
    apiclientid integer NOT NULL,
    method character varying(10) NOT NULL,
    url character varying(500) NOT NULL,
    headers text,
    body text,
    creationdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.apilog OWNER TO voat;

--
-- Name: apipermissionpolicy; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE apipermissionpolicy (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    policy character varying(2000) NOT NULL
);


ALTER TABLE public.apipermissionpolicy OWNER TO voat;

--
-- Name: apithrottlepolicy; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE apithrottlepolicy (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    policy character varying(2000) NOT NULL
);


ALTER TABLE public.apithrottlepolicy OWNER TO voat;

--
-- Name: badge; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE badge (
    id character varying(50) NOT NULL,
    graphic character varying(50) NOT NULL,
    title character varying(300) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.badge OWNER TO voat;

--
-- Name: banneddomain; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE banneddomain (
    id integer NOT NULL,
    domain character varying(50) NOT NULL,
    createdby character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    reason character varying(500) NOT NULL
);


ALTER TABLE public.banneddomain OWNER TO voat;

--
-- Name: banneduser; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE banneduser (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    reason character varying(500) NOT NULL,
    createdby character varying(50) NOT NULL
);


ALTER TABLE public.banneduser OWNER TO voat;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE comment (
    id integer NOT NULL,
    votes integer,
    username character varying(50) NOT NULL,
    content text NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    lasteditdate timestamp without time zone,
    submissionid integer NOT NULL,
    upcount bigint DEFAULT 1 NOT NULL,
    downcount bigint DEFAULT 0,
    parentid integer,
    isanonymized bit(1) DEFAULT (0)::bit(1) NOT NULL,
    isdistinguished bit(1) DEFAULT (0)::bit(1) NOT NULL,
    formattedcontent text,
    isdeleted bit(1) DEFAULT (0)::bit(1)
);


ALTER TABLE public.comment OWNER TO voat;

--
-- Name: commentsavetracker; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE commentsavetracker (
    id integer NOT NULL,
    commentid integer NOT NULL,
    username character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.commentsavetracker OWNER TO voat;

--
-- Name: commentvotetracker; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE commentvotetracker (
    id integer NOT NULL,
    commentid integer NOT NULL,
    username character varying(50),
    votestatus integer,
    creationdate timestamp without time zone,
    ipaddress character varying(90)
);


ALTER TABLE public.commentvotetracker OWNER TO voat;

--
-- Name: contentremovallog; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE contentremovallog (
    commentid integer NOT NULL,
    moderator character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    reason character varying(500) NOT NULL
);


ALTER TABLE public.contentremovallog OWNER TO voat;

--
-- Name: defaultsubverse; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE defaultsubverse (
    subverse character varying(20) NOT NULL,
    "Order" integer NOT NULL
);


ALTER TABLE public.defaultsubverse OWNER TO voat;

--
-- Name: eventlog; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE eventlog (
    id integer NOT NULL,
    parentid integer,
    activityid character varying(50),
    username character varying(100),
    origin character varying(20),
    type character varying(300) NOT NULL,
    message character varying(1500) NOT NULL,
    category character varying(1000) NOT NULL,
    exception text,
    data text,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.eventlog OWNER TO voat;

--
-- Name: featuredsubverse; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE featuredsubverse (
    id integer NOT NULL,
    subverse character varying(20) NOT NULL,
    createdby character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.featuredsubverse OWNER TO voat;

--
-- Name: message; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE message (
    id integer NOT NULL,
    correlationid character varying(36) NOT NULL,
    parentid integer,
    type integer NOT NULL,
    sender character varying(50) NOT NULL,
    sendertype integer NOT NULL,
    recipient character varying(50) NOT NULL,
    recipienttype integer NOT NULL,
    title character varying(500),
    content text,
    formattedcontent text,
    subverse character varying(20),
    submissionid integer,
    isanonymized bit(1) NOT NULL,
    readdate timestamp without time zone,
    createdby character varying(50),
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.message OWNER TO voat;

--
-- Name: moderatorinvitation; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE moderatorinvitation (
    id integer NOT NULL,
    createdby character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    recipient character varying(50) NOT NULL,
    subverse character varying(20) NOT NULL,
    power integer NOT NULL
);


ALTER TABLE public.moderatorinvitation OWNER TO voat;

--
-- Name: sessiontracker; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE sessiontracker (
    sessionid character varying(90) NOT NULL,
    subverse character varying(20) NOT NULL,
    creationdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.sessiontracker OWNER TO voat;

--
-- Name: stickiedsubmission; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE stickiedsubmission (
    submissionid integer NOT NULL,
    subverse character varying(20) NOT NULL,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.stickiedsubmission OWNER TO voat;

--
-- Name: submission; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE submission (
    id integer NOT NULL,
    isarchived bit(1) DEFAULT (0)::bit(1),
    votes integer,
    username character varying(50) NOT NULL,
    content text,
    creationdate timestamp without time zone NOT NULL,
    type integer NOT NULL,
    title character varying(200),
    rank double precision DEFAULT 0.0 NOT NULL,
    subverse character varying(20),
    upcount bigint DEFAULT 1 NOT NULL,
    downcount bigint DEFAULT 0 NOT NULL,
    thumbnail character(40),
    lasteditdate timestamp without time zone,
    flairlabel character varying(50),
    flaircss character varying(50),
    views double precision DEFAULT 1.0 NOT NULL,
    isdeleted bit(1) DEFAULT (0)::bit(1) NOT NULL,
    isanonymized bit(1) DEFAULT (0)::bit(1) NOT NULL,
    relativerank double precision DEFAULT 0.0 NOT NULL,
    url character varying(3000),
    formattedcontent text
);


ALTER TABLE public.submission OWNER TO voat;

--
-- Name: submissionremovallog; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE submissionremovallog (
    submissionid integer NOT NULL,
    moderator character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    reason character varying(500) NOT NULL
);


ALTER TABLE public.submissionremovallog OWNER TO voat;

--
-- Name: submissionsavetracker; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE submissionsavetracker (
    id integer NOT NULL,
    submissionid integer NOT NULL,
    username character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.submissionsavetracker OWNER TO voat;

--
-- Name: submissionvotetracker; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE submissionvotetracker (
    id integer NOT NULL,
    submissionid integer NOT NULL,
    username character varying(50),
    votestatus integer,
    creationdate timestamp without time zone,
    ipaddress character varying(90)
);


ALTER TABLE public.submissionvotetracker OWNER TO voat;

--
-- Name: subverse; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE subverse (
    name character varying(20) NOT NULL,
    title character varying(500) NOT NULL,
    description character varying(500),
    sidebar character varying(4000),
    submissiontext character varying(500),
    language character varying(10),
    type character varying(10) NOT NULL,
    submitlinklabel character varying(50),
    submitpostlabel character varying(50),
    spamfilterlink character varying(10),
    spamfilterpost character varying(10),
    spamfiltercomment character varying(10),
    isadult bit(1) DEFAULT (0)::bit(1),
    isdefaultallowed bit(1) DEFAULT (1)::bit(1),
    isthumbnailenabled bit(1) DEFAULT (1)::bit(1),
    excludesitewidebans bit(1) DEFAULT (0)::bit(1),
    istrafficstatspublic bit(1) DEFAULT (0)::bit(1),
    minutestohidecomments integer,
    creationdate timestamp without time zone NOT NULL,
    stylesheet text,
    subscribercount integer,
    isprivate bit(1) DEFAULT (0)::bit(1) NOT NULL,
    isauthorizedonly bit(1) DEFAULT (0)::bit(1) NOT NULL,
    isanonymized bit(1) DEFAULT (0)::bit(1) NOT NULL,
    lastsubmissiondate timestamp without time zone,
    minccpfordownvote integer DEFAULT 0 NOT NULL,
    isadminprivate bit(1) DEFAULT (0)::bit(1) NOT NULL,
    isadmindisabled bit(1),
    createdby character varying(50)
);


ALTER TABLE public.subverse OWNER TO voat;

--
-- Name: subverseban; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE subverseban (
    id integer NOT NULL,
    subverse character varying(20) NOT NULL,
    username character varying(50) NOT NULL,
    createdby character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    reason character varying(500) NOT NULL
);


ALTER TABLE public.subverseban OWNER TO voat;

--
-- Name: subverseflair; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE subverseflair (
    id integer NOT NULL,
    subverse character varying(20) NOT NULL,
    label character varying(50),
    cssclass character varying(50)
);


ALTER TABLE public.subverseflair OWNER TO voat;

--
-- Name: subversemoderator; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE subversemoderator (
    id integer NOT NULL,
    subverse character varying(20) NOT NULL,
    username character varying(50) NOT NULL,
    power integer NOT NULL,
    createdby character varying(50),
    creationdate timestamp without time zone
);


ALTER TABLE public.subversemoderator OWNER TO voat;

--
-- Name: subversesubscription; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE subversesubscription (
    id integer NOT NULL,
    subverse character varying(20) NOT NULL,
    username character varying(50) NOT NULL
);


ALTER TABLE public.subversesubscription OWNER TO voat;

--
-- Name: userbadge; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE userbadge (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    badgeid character varying(50) NOT NULL,
    creationdate timestamp without time zone NOT NULL
);


ALTER TABLE public.userbadge OWNER TO voat;

--
-- Name: userblockedsubverse; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE userblockedsubverse (
    id integer NOT NULL,
    subverse character varying(20) NOT NULL,
    username character varying(50) NOT NULL,
    creationdate timestamp without time zone DEFAULT now()
);


ALTER TABLE public.userblockedsubverse OWNER TO voat;

--
-- Name: userblockeduser; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE userblockeduser (
    id integer NOT NULL,
    blockuser character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    creationdate timestamp without time zone DEFAULT now()
);


ALTER TABLE public.userblockeduser OWNER TO voat;

--
-- Name: userpreference; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE userpreference (
    username character varying(50) NOT NULL,
    disablecss bit(1) NOT NULL,
    nightmode bit(1) NOT NULL,
    language character varying(50) NOT NULL,
    openinnewwindow bit(1) NOT NULL,
    enableadultcontent bit(1) NOT NULL,
    displayvotes bit(1) NOT NULL,
    displaysubscriptions bit(1) DEFAULT (0)::bit(1) NOT NULL,
    usesubscriptionsmenu bit(1) DEFAULT (1)::bit(1) NOT NULL,
    bio character varying(100),
    avatar character varying(50),
    displayads bit(1) DEFAULT (0)::bit(1) NOT NULL,
    displaycommentcount integer,
    highlightminutes integer,
    vanitytitle character varying(50),
    collapsecommentlimit integer
);


ALTER TABLE public.userpreference OWNER TO voat;

--
-- Name: userset; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE userset (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(200) NOT NULL,
    createdby character varying(20) NOT NULL,
    creationdate timestamp without time zone NOT NULL,
    ispublic bit(1) DEFAULT (1)::bit(1) NOT NULL,
    subscribercount integer DEFAULT 1 NOT NULL,
    isdefault bit(1) DEFAULT (0)::bit(1) NOT NULL
);


ALTER TABLE public.userset OWNER TO voat;

--
-- Name: usersetlist; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE usersetlist (
    id integer NOT NULL,
    usersetid integer NOT NULL,
    subverse character varying(20) NOT NULL
);


ALTER TABLE public.usersetlist OWNER TO voat;

--
-- Name: usersetsubscription; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE usersetsubscription (
    id integer NOT NULL,
    usersetid integer NOT NULL,
    "Order" integer DEFAULT 0 NOT NULL,
    username character varying(20) NOT NULL
);


ALTER TABLE public.usersetsubscription OWNER TO voat;

--
-- Name: uservisit; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE uservisit (
    id integer NOT NULL,
    submissionid integer NOT NULL,
    username character varying(50) NOT NULL,
    lastvisitdate timestamp without time zone NOT NULL
);


ALTER TABLE public.uservisit OWNER TO voat;

--
-- Name: viewstatistic; Type: TABLE; Schema: public; Owner: voat; Tablespace: 
--

CREATE TABLE viewstatistic (
    submissionid integer NOT NULL,
    viewerid character varying(90) NOT NULL
);


ALTER TABLE public.viewstatistic OWNER TO voat;

--
-- Name: ad_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY ad
    ADD CONSTRAINT ad_pkey PRIMARY KEY (id);


--
-- Name: apiclient_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY apiclient
    ADD CONSTRAINT apiclient_pkey PRIMARY KEY (id);


--
-- Name: apicorspolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY apicorspolicy
    ADD CONSTRAINT apicorspolicy_pkey PRIMARY KEY (id);


--
-- Name: apilog_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY apilog
    ADD CONSTRAINT apilog_pkey PRIMARY KEY (id);


--
-- Name: apipermissionpolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY apipermissionpolicy
    ADD CONSTRAINT apipermissionpolicy_pkey PRIMARY KEY (id);


--
-- Name: apithrottlepolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY apithrottlepolicy
    ADD CONSTRAINT apithrottlepolicy_pkey PRIMARY KEY (id);


--
-- Name: badge_id_pk; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY badge
    ADD CONSTRAINT badge_id_pk PRIMARY KEY (id);


--
-- Name: banneddomain_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY banneddomain
    ADD CONSTRAINT banneddomain_pkey PRIMARY KEY (id);


--
-- Name: banneduser_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY banneduser
    ADD CONSTRAINT banneduser_pkey PRIMARY KEY (id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: commentsavetracker_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY commentsavetracker
    ADD CONSTRAINT commentsavetracker_pkey PRIMARY KEY (id);


--
-- Name: commentvotetracker_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY commentvotetracker
    ADD CONSTRAINT commentvotetracker_pkey PRIMARY KEY (id);


--
-- Name: eventlog_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY eventlog
    ADD CONSTRAINT eventlog_pkey PRIMARY KEY (id);


--
-- Name: featuredsubverse_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY featuredsubverse
    ADD CONSTRAINT featuredsubverse_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: moderatorinvitation_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY moderatorinvitation
    ADD CONSTRAINT moderatorinvitation_pkey PRIMARY KEY (id);


--
-- Name: submission_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY submission
    ADD CONSTRAINT submission_pkey PRIMARY KEY (id);


--
-- Name: submissionsavetracker_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY submissionsavetracker
    ADD CONSTRAINT submissionsavetracker_pkey PRIMARY KEY (id);


--
-- Name: submissionvotetracker_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY submissionvotetracker
    ADD CONSTRAINT submissionvotetracker_pkey PRIMARY KEY (id);


--
-- Name: subverse_name_pk; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY subverse
    ADD CONSTRAINT subverse_name_pk PRIMARY KEY (name);


--
-- Name: subverseban_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY subverseban
    ADD CONSTRAINT subverseban_pkey PRIMARY KEY (id);


--
-- Name: subverseflair_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY subverseflair
    ADD CONSTRAINT subverseflair_pkey PRIMARY KEY (id);


--
-- Name: subversemoderator_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY subversemoderator
    ADD CONSTRAINT subversemoderator_pkey PRIMARY KEY (id);


--
-- Name: subversesubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY subversesubscription
    ADD CONSTRAINT subversesubscription_pkey PRIMARY KEY (id);


--
-- Name: userbadge_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY userbadge
    ADD CONSTRAINT userbadge_pkey PRIMARY KEY (id);


--
-- Name: userblockedsubverse_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY userblockedsubverse
    ADD CONSTRAINT userblockedsubverse_pkey PRIMARY KEY (id);


--
-- Name: userblockeduser_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY userblockeduser
    ADD CONSTRAINT userblockeduser_pkey PRIMARY KEY (id);


--
-- Name: userset_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY userset
    ADD CONSTRAINT userset_pkey PRIMARY KEY (id);


--
-- Name: usersetlist_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY usersetlist
    ADD CONSTRAINT usersetlist_pkey PRIMARY KEY (id);


--
-- Name: usersetsubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY usersetsubscription
    ADD CONSTRAINT usersetsubscription_pkey PRIMARY KEY (id);


--
-- Name: uservisit_pkey; Type: CONSTRAINT; Schema: public; Owner: voat; Tablespace: 
--

ALTER TABLE ONLY uservisit
    ADD CONSTRAINT uservisit_pkey PRIMARY KEY (id);


--
-- Name: apiclient_apipermissionpolicy_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY apiclient
    ADD CONSTRAINT apiclient_apipermissionpolicy_id_fk FOREIGN KEY (apipermissionpolicyid) REFERENCES apipermissionpolicy(id);


--
-- Name: apiclient_apithrottlepolicy_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY apiclient
    ADD CONSTRAINT apiclient_apithrottlepolicy_id_fk FOREIGN KEY (apithrottlepolicyid) REFERENCES apithrottlepolicy(id);


--
-- Name: comment_submission_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_submission_id_fk FOREIGN KEY (submissionid) REFERENCES submission(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: commentsavetracker_comment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY commentsavetracker
    ADD CONSTRAINT commentsavetracker_comment_id_fk FOREIGN KEY (commentid) REFERENCES comment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: commentvotetracker_comment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY commentvotetracker
    ADD CONSTRAINT commentvotetracker_comment_id_fk FOREIGN KEY (commentid) REFERENCES comment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contentremovallog_comment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY contentremovallog
    ADD CONSTRAINT contentremovallog_comment_id_fk FOREIGN KEY (commentid) REFERENCES comment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: defaultsubverse_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY defaultsubverse
    ADD CONSTRAINT defaultsubverse_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: featuredsubverse_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY featuredsubverse
    ADD CONSTRAINT featuredsubverse_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name);


--
-- Name: stickiedsubmission_submission_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY stickiedsubmission
    ADD CONSTRAINT stickiedsubmission_submission_id_fk FOREIGN KEY (submissionid) REFERENCES submission(id);


--
-- Name: stickiedsubmission_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY stickiedsubmission
    ADD CONSTRAINT stickiedsubmission_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: submissionremovallog_submission_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY submissionremovallog
    ADD CONSTRAINT submissionremovallog_submission_id_fk FOREIGN KEY (submissionid) REFERENCES submission(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: submissionsavetracker_submission_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY submissionsavetracker
    ADD CONSTRAINT submissionsavetracker_submission_id_fk FOREIGN KEY (submissionid) REFERENCES submission(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: submissionvotetracker_submission_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY submissionvotetracker
    ADD CONSTRAINT submissionvotetracker_submission_id_fk FOREIGN KEY (submissionid) REFERENCES submission(id);


--
-- Name: subverseban_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY subverseban
    ADD CONSTRAINT subverseban_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subverseflair_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY subverseflair
    ADD CONSTRAINT subverseflair_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subversemoderator_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY subversemoderator
    ADD CONSTRAINT subversemoderator_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subversesubscription_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY subversesubscription
    ADD CONSTRAINT subversesubscription_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: userbadge_badge_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY userbadge
    ADD CONSTRAINT userbadge_badge_id_fk FOREIGN KEY (badgeid) REFERENCES badge(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: userblockedsubverse_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY userblockedsubverse
    ADD CONSTRAINT userblockedsubverse_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usersetlist_subverse_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY usersetlist
    ADD CONSTRAINT usersetlist_subverse_name_fk FOREIGN KEY (subverse) REFERENCES subverse(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usersetlist_userset_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY usersetlist
    ADD CONSTRAINT usersetlist_userset_id_fk FOREIGN KEY (usersetid) REFERENCES userset(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usersetsubscription_userset_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY usersetsubscription
    ADD CONSTRAINT usersetsubscription_userset_id_fk FOREIGN KEY (usersetid) REFERENCES userset(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: viewstatistic_submission_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: voat
--

ALTER TABLE ONLY viewstatistic
    ADD CONSTRAINT viewstatistic_submission_id_fk FOREIGN KEY (submissionid) REFERENCES submission(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

