--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: dissemination_category_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE dissemination_category_type AS ENUM (
    'internal',
    'external'
);


--
-- Name: good_bad_neutral; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE good_bad_neutral AS ENUM (
    'good',
    'bad',
    'neutral'
);


--
-- Name: good_medium_bad_neutral; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE good_medium_bad_neutral AS ENUM (
    'good',
    'medium',
    'bad',
    'neutral'
);


--
-- Name: study_stage; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE study_stage AS ENUM (
    'concept',
    'protocol_erb',
    'delivery',
    'completion',
    'withdrawn_postponed'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    namespace character varying,
    body text,
    resource_id character varying NOT NULL,
    resource_type character varying NOT NULL,
    author_id integer,
    author_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activities (
    id integer NOT NULL,
    trackable_id integer,
    trackable_type character varying,
    owner_id integer,
    owner_type character varying,
    key character varying,
    parameters text,
    recipient_id integer,
    recipient_type character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    related_content_id integer,
    related_content_type character varying
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: collaborators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE collaborators (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: collaborators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE collaborators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collaborators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE collaborators_id_seq OWNED BY collaborators.id;


--
-- Name: delivery_update_invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_update_invites (
    id integer NOT NULL,
    study_id integer NOT NULL,
    invited_user_id integer NOT NULL,
    inviting_user_id integer NOT NULL,
    delivery_update_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delivery_update_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_update_invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_update_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delivery_update_invites_id_seq OWNED BY delivery_update_invites.id;


--
-- Name: delivery_update_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_update_statuses (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    good_medium_bad_or_neutral good_medium_bad_neutral DEFAULT 'neutral'::good_medium_bad_neutral NOT NULL
);


--
-- Name: delivery_update_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_update_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_update_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delivery_update_statuses_id_seq OWNED BY delivery_update_statuses.id;


--
-- Name: delivery_updates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_updates (
    id integer NOT NULL,
    study_id integer NOT NULL,
    data_analysis_status_id integer NOT NULL,
    data_collection_status_id integer NOT NULL,
    interpretation_and_write_up_status_id integer NOT NULL,
    user_id integer NOT NULL,
    comments text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delivery_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_updates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delivery_updates_id_seq OWNED BY delivery_updates.id;


--
-- Name: dissemination_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dissemination_categories (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    dissemination_category_type dissemination_category_type NOT NULL
);


--
-- Name: dissemination_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dissemination_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dissemination_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dissemination_categories_id_seq OWNED BY dissemination_categories.id;


--
-- Name: disseminations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE disseminations (
    id integer NOT NULL,
    dissemination_category_id integer NOT NULL,
    study_id integer NOT NULL,
    details text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    other_dissemination_category text,
    user_id integer
);


--
-- Name: disseminations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE disseminations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disseminations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE disseminations_id_seq OWNED BY disseminations.id;


--
-- Name: document_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE document_types (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: document_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE document_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE document_types_id_seq OWNED BY document_types.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    document_type_id integer NOT NULL,
    study_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    document_file_name character varying,
    document_content_type character varying,
    document_file_size integer,
    document_updated_at timestamp without time zone,
    user_id integer,
    description text
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: erb_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE erb_statuses (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text NOT NULL,
    good_bad_or_neutral good_bad_neutral DEFAULT 'neutral'::good_bad_neutral NOT NULL
);


--
-- Name: erb_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE erb_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: erb_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE erb_statuses_id_seq OWNED BY erb_statuses.id;


--
-- Name: impact_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE impact_types (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: impact_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE impact_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: impact_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE impact_types_id_seq OWNED BY impact_types.id;


--
-- Name: msf_locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE msf_locations (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: msf_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE msf_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: msf_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE msf_locations_id_seq OWNED BY msf_locations.id;


--
-- Name: publications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE publications (
    id integer NOT NULL,
    study_id integer,
    doi_number text,
    lead_author text NOT NULL,
    article_title text NOT NULL,
    book_or_journal_title text NOT NULL,
    publication_year integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: publications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE publications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE publications_id_seq OWNED BY publications.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sent_alerts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sent_alerts (
    id integer NOT NULL,
    study_id integer NOT NULL,
    user_id integer NOT NULL,
    alert_type text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sent_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sent_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sent_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sent_alerts_id_seq OWNED BY sent_alerts.id;


--
-- Name: studies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE studies (
    id integer NOT NULL,
    title text NOT NULL,
    reference_number text NOT NULL,
    study_type_id integer NOT NULL,
    study_setting_id integer NOT NULL,
    research_team text,
    concept_paper_date date,
    protocol_needed boolean NOT NULL,
    pre_approved_protocol boolean,
    erb_status_id integer,
    erb_reference text,
    erb_approval_expiry date,
    local_erb_submitted date,
    local_erb_approved date,
    completed date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    other_study_type text,
    principal_investigator_id integer,
    research_manager_id integer,
    country_codes text,
    study_stage study_stage DEFAULT 'concept'::study_stage NOT NULL,
    expected_completion_date date,
    erb_submitted date,
    erb_approved date,
    hidden boolean DEFAULT false,
    delivery_delayed boolean DEFAULT false NOT NULL,
    exemption_approved_by text
);


--
-- Name: studies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE studies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE studies_id_seq OWNED BY studies.id;


--
-- Name: studies_study_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE studies_study_topics (
    study_topic_id integer NOT NULL,
    study_id integer NOT NULL
);


--
-- Name: study_collaborators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_collaborators (
    id integer NOT NULL,
    study_id integer NOT NULL,
    collaborator_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: study_collaborators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_collaborators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_collaborators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_collaborators_id_seq OWNED BY study_collaborators.id;


--
-- Name: study_impacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_impacts (
    id integer NOT NULL,
    study_id integer NOT NULL,
    impact_type_id integer NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: study_impacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_impacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_impacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_impacts_id_seq OWNED BY study_impacts.id;


--
-- Name: study_invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_invites (
    id integer NOT NULL,
    study_id integer NOT NULL,
    inviting_user_id integer NOT NULL,
    invited_user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: study_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_invites_id_seq OWNED BY study_invites.id;


--
-- Name: study_notes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_notes (
    id integer NOT NULL,
    notes text NOT NULL,
    study_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: study_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_notes_id_seq OWNED BY study_notes.id;


--
-- Name: study_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_settings (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: study_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_settings_id_seq OWNED BY study_settings.id;


--
-- Name: study_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_topics (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: study_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_topics_id_seq OWNED BY study_topics.id;


--
-- Name: study_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE study_types (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: study_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE study_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: study_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE study_types_id_seq OWNED BY study_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name text NOT NULL,
    msf_location_id integer,
    external_location text,
    is_admin boolean DEFAULT false NOT NULL,
    invite_token character varying NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    delivery_update_token character varying NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY collaborators ALTER COLUMN id SET DEFAULT nextval('collaborators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_update_invites ALTER COLUMN id SET DEFAULT nextval('delivery_update_invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_update_statuses ALTER COLUMN id SET DEFAULT nextval('delivery_update_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_updates ALTER COLUMN id SET DEFAULT nextval('delivery_updates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dissemination_categories ALTER COLUMN id SET DEFAULT nextval('dissemination_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY disseminations ALTER COLUMN id SET DEFAULT nextval('disseminations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY document_types ALTER COLUMN id SET DEFAULT nextval('document_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY erb_statuses ALTER COLUMN id SET DEFAULT nextval('erb_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY impact_types ALTER COLUMN id SET DEFAULT nextval('impact_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY msf_locations ALTER COLUMN id SET DEFAULT nextval('msf_locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY publications ALTER COLUMN id SET DEFAULT nextval('publications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sent_alerts ALTER COLUMN id SET DEFAULT nextval('sent_alerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies ALTER COLUMN id SET DEFAULT nextval('studies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_collaborators ALTER COLUMN id SET DEFAULT nextval('study_collaborators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_impacts ALTER COLUMN id SET DEFAULT nextval('study_impacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_invites ALTER COLUMN id SET DEFAULT nextval('study_invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_notes ALTER COLUMN id SET DEFAULT nextval('study_notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_settings ALTER COLUMN id SET DEFAULT nextval('study_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_topics ALTER COLUMN id SET DEFAULT nextval('study_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_types ALTER COLUMN id SET DEFAULT nextval('study_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY collaborators
    ADD CONSTRAINT collaborators_pkey PRIMARY KEY (id);


--
-- Name: delivery_update_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_update_invites
    ADD CONSTRAINT delivery_update_invites_pkey PRIMARY KEY (id);


--
-- Name: delivery_update_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_update_statuses
    ADD CONSTRAINT delivery_update_statuses_pkey PRIMARY KEY (id);


--
-- Name: delivery_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_updates
    ADD CONSTRAINT delivery_updates_pkey PRIMARY KEY (id);


--
-- Name: dissemination_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dissemination_categories
    ADD CONSTRAINT dissemination_categories_pkey PRIMARY KEY (id);


--
-- Name: disseminations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY disseminations
    ADD CONSTRAINT disseminations_pkey PRIMARY KEY (id);


--
-- Name: document_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: erb_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY erb_statuses
    ADD CONSTRAINT erb_statuses_pkey PRIMARY KEY (id);


--
-- Name: impact_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY impact_types
    ADD CONSTRAINT impact_types_pkey PRIMARY KEY (id);


--
-- Name: msf_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY msf_locations
    ADD CONSTRAINT msf_locations_pkey PRIMARY KEY (id);


--
-- Name: publications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY (id);


--
-- Name: sent_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sent_alerts
    ADD CONSTRAINT sent_alerts_pkey PRIMARY KEY (id);


--
-- Name: studies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT studies_pkey PRIMARY KEY (id);


--
-- Name: study_collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_collaborators
    ADD CONSTRAINT study_collaborators_pkey PRIMARY KEY (id);


--
-- Name: study_impacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_impacts
    ADD CONSTRAINT study_impacts_pkey PRIMARY KEY (id);


--
-- Name: study_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_invites
    ADD CONSTRAINT study_invites_pkey PRIMARY KEY (id);


--
-- Name: study_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_notes
    ADD CONSTRAINT study_notes_pkey PRIMARY KEY (id);


--
-- Name: study_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_settings
    ADD CONSTRAINT study_settings_pkey PRIMARY KEY (id);


--
-- Name: study_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_topics
    ADD CONSTRAINT study_topics_pkey PRIMARY KEY (id);


--
-- Name: study_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY study_types
    ADD CONSTRAINT study_types_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_activities_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_owner_id_and_owner_type ON activities USING btree (owner_id, owner_type);


--
-- Name: index_activities_on_recipient_id_and_recipient_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_recipient_id_and_recipient_type ON activities USING btree (recipient_id, recipient_type);


--
-- Name: index_activities_on_related_content_type_and_related_content_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_related_content_type_and_related_content_id ON activities USING btree (related_content_type, related_content_id);


--
-- Name: index_activities_on_trackable_id_and_trackable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_trackable_id_and_trackable_type ON activities USING btree (trackable_id, trackable_type);


--
-- Name: index_delivery_update_invites_on_delivery_update_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_update_invites_on_delivery_update_id ON delivery_update_invites USING btree (delivery_update_id);


--
-- Name: index_delivery_update_invites_on_invited_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_update_invites_on_invited_user_id ON delivery_update_invites USING btree (invited_user_id);


--
-- Name: index_delivery_update_invites_on_inviting_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_update_invites_on_inviting_user_id ON delivery_update_invites USING btree (inviting_user_id);


--
-- Name: index_delivery_update_invites_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_update_invites_on_study_id ON delivery_update_invites USING btree (study_id);


--
-- Name: index_delivery_update_statuses_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_delivery_update_statuses_on_name ON delivery_update_statuses USING btree (name);


--
-- Name: index_delivery_updates_on_data_analysis_status_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_updates_on_data_analysis_status_id ON delivery_updates USING btree (data_analysis_status_id);


--
-- Name: index_delivery_updates_on_data_collection_status_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_updates_on_data_collection_status_id ON delivery_updates USING btree (data_collection_status_id);


--
-- Name: index_delivery_updates_on_interpretation_and_write_up_status_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_updates_on_interpretation_and_write_up_status_id ON delivery_updates USING btree (interpretation_and_write_up_status_id);


--
-- Name: index_delivery_updates_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_updates_on_study_id ON delivery_updates USING btree (study_id);


--
-- Name: index_delivery_updates_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_delivery_updates_on_user_id ON delivery_updates USING btree (user_id);


--
-- Name: index_dissemination_categories_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_dissemination_categories_on_name ON dissemination_categories USING btree (name);


--
-- Name: index_disseminations_on_dissemination_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disseminations_on_dissemination_category_id ON disseminations USING btree (dissemination_category_id);


--
-- Name: index_disseminations_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disseminations_on_study_id ON disseminations USING btree (study_id);


--
-- Name: index_disseminations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_disseminations_on_user_id ON disseminations USING btree (user_id);


--
-- Name: index_document_types_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_document_types_on_name ON document_types USING btree (name);


--
-- Name: index_documents_on_document_type_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_documents_on_document_type_id ON documents USING btree (document_type_id);


--
-- Name: index_documents_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_documents_on_study_id ON documents USING btree (study_id);


--
-- Name: index_documents_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_documents_on_user_id ON documents USING btree (user_id);


--
-- Name: index_erb_statuses_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_erb_statuses_on_name ON erb_statuses USING btree (name);


--
-- Name: index_impact_types_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_impact_types_on_name ON impact_types USING btree (name);


--
-- Name: index_msf_locations_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_msf_locations_on_name ON msf_locations USING btree (name);


--
-- Name: index_publications_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_publications_on_study_id ON publications USING btree (study_id);


--
-- Name: index_publications_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_publications_on_user_id ON publications USING btree (user_id);


--
-- Name: index_sent_alerts_on_alert_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sent_alerts_on_alert_type ON sent_alerts USING btree (alert_type);


--
-- Name: index_sent_alerts_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sent_alerts_on_study_id ON sent_alerts USING btree (study_id);


--
-- Name: index_sent_alerts_on_study_id_and_user_id_and_alert_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_sent_alerts_on_study_id_and_user_id_and_alert_type ON sent_alerts USING btree (study_id, user_id, alert_type);


--
-- Name: index_sent_alerts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sent_alerts_on_user_id ON sent_alerts USING btree (user_id);


--
-- Name: index_studies_on_erb_status_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_on_erb_status_id ON studies USING btree (erb_status_id);


--
-- Name: index_studies_on_principal_investigator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_on_principal_investigator_id ON studies USING btree (principal_investigator_id);


--
-- Name: index_studies_on_research_manager_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_on_research_manager_id ON studies USING btree (research_manager_id);


--
-- Name: index_studies_on_study_setting_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_on_study_setting_id ON studies USING btree (study_setting_id);


--
-- Name: index_studies_on_study_type_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_on_study_type_id ON studies USING btree (study_type_id);


--
-- Name: index_studies_study_topics_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_study_topics_on_study_id ON studies_study_topics USING btree (study_id);


--
-- Name: index_studies_study_topics_on_study_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_studies_study_topics_on_study_topic_id ON studies_study_topics USING btree (study_topic_id);


--
-- Name: index_study_collaborators_on_collaborator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_collaborators_on_collaborator_id ON study_collaborators USING btree (collaborator_id);


--
-- Name: index_study_collaborators_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_collaborators_on_study_id ON study_collaborators USING btree (study_id);


--
-- Name: index_study_collaborators_on_study_id_and_collaborator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_study_collaborators_on_study_id_and_collaborator_id ON study_collaborators USING btree (study_id, collaborator_id);


--
-- Name: index_study_impacts_on_impact_type_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_impacts_on_impact_type_id ON study_impacts USING btree (impact_type_id);


--
-- Name: index_study_impacts_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_impacts_on_study_id ON study_impacts USING btree (study_id);


--
-- Name: index_study_impacts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_impacts_on_user_id ON study_impacts USING btree (user_id);


--
-- Name: index_study_invites_on_invited_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_invites_on_invited_user_id ON study_invites USING btree (invited_user_id);


--
-- Name: index_study_invites_on_inviting_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_invites_on_inviting_user_id ON study_invites USING btree (inviting_user_id);


--
-- Name: index_study_invites_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_invites_on_study_id ON study_invites USING btree (study_id);


--
-- Name: index_study_notes_on_study_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_notes_on_study_id ON study_notes USING btree (study_id);


--
-- Name: index_study_notes_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_study_notes_on_user_id ON study_notes USING btree (user_id);


--
-- Name: index_study_settings_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_study_settings_on_name ON study_settings USING btree (name);


--
-- Name: index_study_topics_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_study_topics_on_name ON study_topics USING btree (name);


--
-- Name: index_study_types_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_study_types_on_name ON study_types USING btree (name);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_delivery_update_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_delivery_update_token ON users USING btree (delivery_update_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_msf_location_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_msf_location_id ON users USING btree (msf_location_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_03839ae5f9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_notes
    ADD CONSTRAINT fk_rails_03839ae5f9 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_03e5ee9cba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_03e5ee9cba FOREIGN KEY (msf_location_id) REFERENCES msf_locations(id);


--
-- Name: fk_rails_086c771341; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY disseminations
    ADD CONSTRAINT fk_rails_086c771341 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_0e2a1a9789; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT fk_rails_0e2a1a9789 FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_105fab0e5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_update_invites
    ADD CONSTRAINT fk_rails_105fab0e5c FOREIGN KEY (delivery_update_id) REFERENCES delivery_updates(id);


--
-- Name: fk_rails_16cbc9041f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_update_invites
    ADD CONSTRAINT fk_rails_16cbc9041f FOREIGN KEY (invited_user_id) REFERENCES users(id);


--
-- Name: fk_rails_24e0da1d15; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_invites
    ADD CONSTRAINT fk_rails_24e0da1d15 FOREIGN KEY (invited_user_id) REFERENCES users(id);


--
-- Name: fk_rails_288a35645b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_collaborators
    ADD CONSTRAINT fk_rails_288a35645b FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_2a4fa11b2b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_updates
    ADD CONSTRAINT fk_rails_2a4fa11b2b FOREIGN KEY (data_analysis_status_id) REFERENCES delivery_update_statuses(id);


--
-- Name: fk_rails_2be0318c46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT fk_rails_2be0318c46 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_2cbe0621cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY disseminations
    ADD CONSTRAINT fk_rails_2cbe0621cc FOREIGN KEY (dissemination_category_id) REFERENCES dissemination_categories(id);


--
-- Name: fk_rails_2e29f4b837; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_updates
    ADD CONSTRAINT fk_rails_2e29f4b837 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_3abf35384e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_updates
    ADD CONSTRAINT fk_rails_3abf35384e FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_467a05ce2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_notes
    ADD CONSTRAINT fk_rails_467a05ce2c FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_4c7f593262; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_update_invites
    ADD CONSTRAINT fk_rails_4c7f593262 FOREIGN KEY (inviting_user_id) REFERENCES users(id);


--
-- Name: fk_rails_4f82512c3f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sent_alerts
    ADD CONSTRAINT fk_rails_4f82512c3f FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_529dd6c0d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT fk_rails_529dd6c0d7 FOREIGN KEY (principal_investigator_id) REFERENCES users(id);


--
-- Name: fk_rails_5b8fd83dce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY publications
    ADD CONSTRAINT fk_rails_5b8fd83dce FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_656a38bbd9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_impacts
    ADD CONSTRAINT fk_rails_656a38bbd9 FOREIGN KEY (impact_type_id) REFERENCES impact_types(id);


--
-- Name: fk_rails_66bb2fb821; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_invites
    ADD CONSTRAINT fk_rails_66bb2fb821 FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_68c499eeaf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_update_invites
    ADD CONSTRAINT fk_rails_68c499eeaf FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_72e4b2d4a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_impacts
    ADD CONSTRAINT fk_rails_72e4b2d4a3 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_8220afb15f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies_study_topics
    ADD CONSTRAINT fk_rails_8220afb15f FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_84b1d4daed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_impacts
    ADD CONSTRAINT fk_rails_84b1d4daed FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_85cdabbd40; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_collaborators
    ADD CONSTRAINT fk_rails_85cdabbd40 FOREIGN KEY (collaborator_id) REFERENCES collaborators(id);


--
-- Name: fk_rails_973ddb4933; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY study_invites
    ADD CONSTRAINT fk_rails_973ddb4933 FOREIGN KEY (inviting_user_id) REFERENCES users(id);


--
-- Name: fk_rails_99700bf9f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT fk_rails_99700bf9f1 FOREIGN KEY (research_manager_id) REFERENCES users(id);


--
-- Name: fk_rails_a9fe0d5311; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sent_alerts
    ADD CONSTRAINT fk_rails_a9fe0d5311 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_b2c97bc5e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY disseminations
    ADD CONSTRAINT fk_rails_b2c97bc5e8 FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- Name: fk_rails_bf79167e3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies_study_topics
    ADD CONSTRAINT fk_rails_bf79167e3d FOREIGN KEY (study_topic_id) REFERENCES study_topics(id);


--
-- Name: fk_rails_c0b00bc50e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT fk_rails_c0b00bc50e FOREIGN KEY (erb_status_id) REFERENCES erb_statuses(id);


--
-- Name: fk_rails_c6a7362db2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT fk_rails_c6a7362db2 FOREIGN KEY (study_setting_id) REFERENCES study_settings(id);


--
-- Name: fk_rails_dc60ba7c37; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_updates
    ADD CONSTRAINT fk_rails_dc60ba7c37 FOREIGN KEY (data_collection_status_id) REFERENCES delivery_update_statuses(id);


--
-- Name: fk_rails_dc8ad7f727; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY studies
    ADD CONSTRAINT fk_rails_dc8ad7f727 FOREIGN KEY (study_type_id) REFERENCES study_types(id);


--
-- Name: fk_rails_dea7b575a7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_updates
    ADD CONSTRAINT fk_rails_dea7b575a7 FOREIGN KEY (interpretation_and_write_up_status_id) REFERENCES delivery_update_statuses(id);


--
-- Name: fk_rails_e77e122717; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT fk_rails_e77e122717 FOREIGN KEY (document_type_id) REFERENCES document_types(id);


--
-- Name: fk_rails_fd8844a90c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY publications
    ADD CONSTRAINT fk_rails_fd8844a90c FOREIGN KEY (study_id) REFERENCES studies(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20160108112933');

INSERT INTO schema_migrations (version) VALUES ('20160114173551');

INSERT INTO schema_migrations (version) VALUES ('20160114175311');

INSERT INTO schema_migrations (version) VALUES ('20160119150601');

INSERT INTO schema_migrations (version) VALUES ('20160121123326');

INSERT INTO schema_migrations (version) VALUES ('20160122111240');

INSERT INTO schema_migrations (version) VALUES ('20160125143207');

INSERT INTO schema_migrations (version) VALUES ('20160126174841');

INSERT INTO schema_migrations (version) VALUES ('20160202165749');

INSERT INTO schema_migrations (version) VALUES ('20160203150222');

INSERT INTO schema_migrations (version) VALUES ('20160203164358');

INSERT INTO schema_migrations (version) VALUES ('20160203182723');

INSERT INTO schema_migrations (version) VALUES ('20160210104516');

INSERT INTO schema_migrations (version) VALUES ('20160210161706');

INSERT INTO schema_migrations (version) VALUES ('20160212155554');

INSERT INTO schema_migrations (version) VALUES ('20160215092603');

INSERT INTO schema_migrations (version) VALUES ('20160217093325');

INSERT INTO schema_migrations (version) VALUES ('20160217112504');

INSERT INTO schema_migrations (version) VALUES ('20160218115619');

INSERT INTO schema_migrations (version) VALUES ('20160218153609');

INSERT INTO schema_migrations (version) VALUES ('20160222175051');

INSERT INTO schema_migrations (version) VALUES ('20160223095020');

INSERT INTO schema_migrations (version) VALUES ('20160223132202');

INSERT INTO schema_migrations (version) VALUES ('20160309172826');

INSERT INTO schema_migrations (version) VALUES ('20160309173302');

INSERT INTO schema_migrations (version) VALUES ('20160310123338');

INSERT INTO schema_migrations (version) VALUES ('20160311151330');

INSERT INTO schema_migrations (version) VALUES ('20160311152216');

INSERT INTO schema_migrations (version) VALUES ('20160311153558');

INSERT INTO schema_migrations (version) VALUES ('20160321105450');

INSERT INTO schema_migrations (version) VALUES ('20160321172127');

INSERT INTO schema_migrations (version) VALUES ('20160321174435');

INSERT INTO schema_migrations (version) VALUES ('20160321181326');

INSERT INTO schema_migrations (version) VALUES ('20160322074054');

INSERT INTO schema_migrations (version) VALUES ('20160624154831');

INSERT INTO schema_migrations (version) VALUES ('20160722133713');

INSERT INTO schema_migrations (version) VALUES ('20160725105103');

