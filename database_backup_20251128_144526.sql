--
-- PostgreSQL database dump
--

\restrict egBHtDeHq2ddkA5L0zXDrbxEVLgKC5c7qPYJozH5e1QE8RIE3O529IaVwD1nGoH

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaigns (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    channel text NOT NULL,
    priority text DEFAULT 'medium'::text NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    target_audience jsonb NOT NULL,
    content jsonb NOT NULL,
    scheduled_date timestamp without time zone,
    launch_date timestamp without time zone,
    estimated_reach integer DEFAULT 0,
    actual_reach integer DEFAULT 0,
    performance jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: credit_bureau; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credit_bureau (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    customer_id text NOT NULL,
    credit_score integer NOT NULL,
    delinquency_12m integer DEFAULT 0 NOT NULL,
    credit_utilization_pct numeric(4,3) NOT NULL,
    num_open_accounts integer NOT NULL,
    num_closed_accounts integer NOT NULL,
    credit_inquiries_6m integer DEFAULT 0 NOT NULL,
    bankruptcies_flag text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: crm_customer_360; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.crm_customer_360 (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    customer_id text NOT NULL,
    name text NOT NULL,
    segment text NOT NULL,
    sales_channel text NOT NULL,
    join_date timestamp without time zone NOT NULL,
    age integer NOT NULL,
    gender text NOT NULL,
    marital_status text NOT NULL,
    zip_code text NOT NULL,
    life_stage text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    crm_customer_id text,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    phone text,
    location text,
    age integer,
    segment text,
    tier text DEFAULT 'bronze'::text NOT NULL,
    churn_score numeric(3,2) DEFAULT 0.00 NOT NULL,
    clv_12_month numeric(10,2) DEFAULT 0.00 NOT NULL,
    clv_lifetime numeric(10,2) DEFAULT 0.00 NOT NULL,
    engagement_score numeric(3,1) DEFAULT 0.0 NOT NULL,
    tenure_months integer DEFAULT 0 NOT NULL,
    last_activity timestamp without time zone,
    propensity_scores jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: data_uploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_uploads (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    file_name text NOT NULL,
    file_type text NOT NULL,
    data_type text NOT NULL,
    file_size integer NOT NULL,
    record_count integer DEFAULT 0,
    column_count integer DEFAULT 0,
    status text DEFAULT 'uploading'::text NOT NULL,
    error_message text,
    uploaded_by text DEFAULT 'System'::text,
    validation_results jsonb DEFAULT '{}'::jsonb,
    quick_stats jsonb DEFAULT '{}'::jsonb,
    sample_data jsonb DEFAULT '[]'::jsonb,
    uploaded_at timestamp without time zone DEFAULT now() NOT NULL,
    processed_at timestamp without time zone
);


--
-- Name: google_analytics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.google_analytics (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    customer_id text NOT NULL,
    session_count_30d integer NOT NULL,
    avg_session_duration_sec integer NOT NULL,
    last_visit_date timestamp without time zone NOT NULL,
    clicks_on_products integer DEFAULT 0 NOT NULL,
    campaigns_opened integer DEFAULT 0 NOT NULL,
    device_type text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: interactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interactions (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    customer_id character varying NOT NULL,
    type text NOT NULL,
    channel text,
    description text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: market_benchmarking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.market_benchmarking (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    product_type text NOT NULL,
    product_features text NOT NULL,
    avg_premium_market numeric(10,2) NOT NULL,
    avg_claim_settlement_days_market integer NOT NULL,
    churn_rate_market numeric(4,3) NOT NULL,
    competitor_top_offers text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: model_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.model_runs (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    model_type text NOT NULL,
    status text DEFAULT 'queued'::text NOT NULL,
    progress integer DEFAULT 0,
    records_processed integer DEFAULT 0,
    total_records integer DEFAULT 0,
    data_quality numeric(5,2) DEFAULT 0.00,
    performance jsonb DEFAULT '{}'::jsonb,
    error_message text,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: policy_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_details (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    policy_id text NOT NULL,
    customer_id text NOT NULL,
    product_type text NOT NULL,
    policy_start timestamp without time zone NOT NULL,
    premium_amount numeric(10,2) NOT NULL,
    policy_value numeric(12,2) NOT NULL,
    payment_frequency text NOT NULL,
    status text NOT NULL,
    num_claims integer DEFAULT 0 NOT NULL,
    tenure_months integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: product_benchmarking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_benchmarking (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    product text NOT NULL,
    company_avg_annual_premium numeric(10,2) NOT NULL,
    company_claims_ratio_pct numeric(4,1) NOT NULL,
    company_renewal_rate_pct numeric(4,1) NOT NULL,
    coverage_features_offered text NOT NULL,
    company_add_on_uptake_pct numeric(4,1) NOT NULL,
    competitor1_avg_premium numeric(10,2) NOT NULL,
    competitor1_renewal_rate_pct numeric(4,1) NOT NULL,
    competitor2_avg_premium numeric(10,2) NOT NULL,
    competitor2_renewal_rate_pct numeric(4,1) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: renewal_window_tracking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.renewal_window_tracking (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    customer_id text NOT NULL,
    policy_number text NOT NULL,
    renewal_date timestamp without time zone NOT NULL,
    property_address text,
    policy_type text NOT NULL,
    current_premium numeric(10,2) NOT NULL,
    days_to_renewal integer NOT NULL,
    renewal_status text DEFAULT 'pending'::text NOT NULL,
    last_contact_date timestamp without time zone,
    agent_notes text,
    priority text DEFAULT 'medium'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.campaigns (id, name, type, channel, priority, status, target_audience, content, scheduled_date, launch_date, estimated_reach, actual_reach, performance, created_at, updated_at) FROM stdin;
9201f37f-b4fd-4c32-9447-c9b5c0d28882	Renewal Boost	retention	email	high	active	{"tier": ["platinum", "gold"], "churnScore": {"min": 0.4}}	{"cta": "Renew Now", "body": "Dear {FirstName}, renew before {RenewalDate} to keep your {PolicyType} active and enjoy continued peace of mind.", "offer": "10% loyalty discount", "subject": "Stay Protected — Renew Today"}	2025-11-18 17:59:28.402	2025-11-21 17:59:28.402	1250	1180	{"openRate": 0.42, "clickRate": 0.18, "conversionRate": 0.12}	2025-11-25 17:59:30.03152	2025-11-25 17:59:30.03152
fc4c58c3-9d72-4ccb-8ee0-7c55eb643219	Bundle & Save	upsell	email	medium	active	{"tier": ["silver", "gold"], "propensity": {"umbrella_policy": {"min": 0.5}}}	{"cta": "Get Quote", "body": "Hi {FirstName}, we noticed you might benefit from adding umbrella coverage. Bundle now and save up to 15%!", "offer": "15% bundle discount", "subject": "Complete Your Coverage"}	2025-11-20 17:59:28.402	2025-11-18 17:59:28.402	850	790	{"openRate": 0.38, "clickRate": 0.15, "conversionRate": 0.08}	2025-11-25 17:59:30.03152	2025-11-25 17:59:30.03152
3564ba90-525c-4f1c-b036-6935d7bb112a	Win-Back Premium	winback	direct_mail	high	scheduled	{"status": "lapsed", "previousTier": ["gold", "platinum"]}	{"cta": "Reactivate Policy", "body": "Dear {FirstName}, we'd love to have you back. As a valued former customer, enjoy exclusive rates when you return.", "offer": "First year at previous rate", "subject": "We Miss You!"}	2025-12-04 17:59:28.402	\N	320	0	{}	2025-11-25 17:59:30.03152	2025-11-25 17:59:30.03152
307e5bc7-b374-45aa-bb42-49d498979ac2	Claims Prevention Tips	engagement	email	low	completed	{"tier": ["bronze", "silver"], "hasHomePolicy": true}	{"cta": "Read More", "body": "Hi {FirstName}, winter is coming! Here are essential tips to prevent common home insurance claims.", "offer": null, "subject": "5 Tips to Protect Your Home This Winter"}	2025-10-29 17:59:28.402	2025-10-31 17:59:28.402	2100	2050	{"openRate": 0.35, "clickRate": 0.22, "conversionRate": 0}	2025-11-25 17:59:30.03152	2025-11-25 17:59:30.03152
15d3e3c9-3c98-42ac-a7a2-2fbf8b8f721f	Referral Rewards	acquisition	sms	medium	active	{"tier": ["gold", "platinum"], "engagementScore": {"min": 7}}	{"cta": "Refer Now", "body": "Refer a friend and you both get $50! Use code FRIEND50.", "offer": "$50 credit per referral", "subject": "Share the Love"}	2025-11-13 17:59:28.402	2025-11-18 17:59:28.402	500	480	{"openRate": 0.55, "clickRate": 0.25, "conversionRate": 0.05}	2025-11-25 17:59:30.03152	2025-11-25 17:59:30.03152
11cb287f-8151-4658-9362-030c8fd14728	Annual Review Reminder	retention	phone	medium	active	{"tenureMonths": {"min": 12}, "lastReviewMonths": {"min": 10}}	{"cta": "Schedule Call", "body": "Schedule your free annual policy review to ensure you have the right coverage.", "offer": "Free coverage consultation", "subject": "Time for Your Annual Review"}	2025-11-25 17:59:28.402	2025-11-24 17:59:28.402	750	680	{"contactRate": 0.45, "appointmentRate": 0.28}	2025-11-25 17:59:30.03152	2025-11-25 17:59:30.03152
\.


--
-- Data for Name: credit_bureau; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credit_bureau (id, customer_id, credit_score, delinquency_12m, credit_utilization_pct, num_open_accounts, num_closed_accounts, credit_inquiries_6m, bankruptcies_flag, created_at, updated_at) FROM stdin;
30093d03-c487-482c-a123-2d13c5c8fde6	C001	633	3	0.681	8	4	3	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
b79f217f-b134-4d12-b350-cd1a42282674	C002	639	2	0.499	12	1	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
99c94f25-91a0-4bd6-9d45-ba8b55dfb8e4	C003	801	1	0.137	12	1	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
d8d6c293-9af9-46e5-bbaa-098b7eb2d9eb	C004	613	1	0.251	4	0	1	Yes	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
0f9d6d92-a0c3-4009-a376-3f4179e531ab	C005	759	0	0.596	11	5	4	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
d3e16f1e-ec46-4936-9935-663f37b7d11a	C006	771	0	0.464	5	2	1	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
7b5907d8-b36f-412d-87c3-8895aa568862	C007	602	2	0.683	2	0	4	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
25ebfa9e-b811-489e-ab16-51c0f124b553	C008	761	0	0.412	11	4	4	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
5a771b11-bcca-48f6-8d8e-9ef14007b3f3	C009	686	3	0.418	12	0	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
9ff59e29-aae0-4cec-a7c5-83c7e3fec5d0	C010	768	1	0.449	5	0	0	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
ccb2a4f9-fb5c-47a9-b155-f118d1ba37e1	C011	593	3	0.467	4	5	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
15abd256-4da7-4cd4-8bcc-b0db9a0acaab	C012	610	3	0.557	7	4	2	Yes	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
9c2521c2-e7c6-485e-b442-4232a7010f1d	C013	743	1	0.112	2	2	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
03b1b874-e46c-4f5e-95d5-d965306671fb	C014	695	2	0.664	2	1	3	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
c9900570-5789-4034-80c6-f69e9a636871	C015	785	0	0.724	11	2	3	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
84c59b0e-490d-4f0f-8645-f7965a325ee1	C016	618	3	0.780	12	5	4	Yes	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
f4b41f11-2ef2-4af1-bb42-4008fda25217	C017	746	1	0.559	9	5	0	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
738735df-bb16-46d0-a355-bccea7bf3675	C018	790	0	0.668	11	3	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
584432c2-68fe-4ece-b6a6-920100fe52ab	C019	833	1	0.306	12	2	2	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
a1463bf8-6594-417e-b7ec-cfcb76375739	C020	731	1	0.605	9	2	3	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
537c9fbd-3c10-4207-a9f0-528e53ba8dc1	C021	835	1	0.590	2	1	0	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
e8526e6f-0792-41d9-a7da-af61b3d77c76	C022	624	1	0.129	3	3	1	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
ee84da84-980b-4db2-8e13-9e058e32e6a0	C023	719	1	0.600	11	3	4	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
209e382b-2347-47f7-b182-49363e04844e	C024	611	3	0.772	3	1	0	No	2025-11-25 17:59:30.017198	2025-11-25 17:59:30.017198
\.


--
-- Data for Name: crm_customer_360; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.crm_customer_360 (id, customer_id, name, segment, sales_channel, join_date, age, gender, marital_status, zip_code, life_stage, created_at, updated_at) FROM stdin;
56e07596-d068-4b06-aaf9-3b2c911b2c92	C001	Jennifer Martinez	Value	Phone	2017-11-04 17:59:28.401	50	F	Single	62914	Pre-retirement	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
13a8fb5c-e9ff-4b17-8c43-0861463ba1cf	C002	William Robinson	Mass Market	Advisor	2020-11-03 17:59:28.401	49	M	Single	79109	Young Professional	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
388b0c11-f00e-4a27-b686-d327e31889f5	C003	Elizabeth Taylor	Mass Market	Advisor	2022-12-31 17:59:28.401	63	M	Divorced	25841	Young Family	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
ef3bb2b6-3d7e-4295-a455-6e65646faa6e	C004	James Hernandez	Mass Market	Online	2013-11-05 17:59:28.401	35	F	Divorced	37236	Pre-retirement	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
c1ccbed1-b23e-4f44-abb6-4b75e7fc04b3	C005	Ashley Wright	Mass Market	Advisor	2014-11-10 17:59:28.401	57	F	Single	90080	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
a7bda05d-cbb1-4707-a2af-e9c277704a2a	C006	Joshua Lewis	Value	Phone	2016-03-25 17:59:28.401	41	F	Single	55350	Young Professional	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
c425087d-1968-4bec-ade8-72badb9097ea	C007	Sarah White	Value	Advisor	2017-08-12 17:59:28.401	29	M	Widowed	54171	Young Family	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
82ebea07-851b-4084-a2ab-6abfa751df08	C008	William Thomas	Mass Market	Online	2025-10-10 17:59:28.401	50	M	Married	81336	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
00e24e6f-50d8-454e-9af4-e7a25f7990af	C009	Ashley Johnson	Value	Phone	2023-01-25 17:59:28.401	52	M	Married	44101	Young Professional	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
de25812c-9c5d-4530-b3a1-7f5393d9c257	C010	Nicole Anderson	Mass Market	Branch	2022-12-04 17:59:28.401	53	M	Married	39602	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
bef1ebc7-1ff4-4734-ae39-94dcc2c87249	C011	Jennifer White	Premium	Advisor	2021-08-12 17:59:28.401	31	M	Married	87872	Young Family	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
34ea6c22-2ffa-479b-af2f-66260d23a433	C012	Lisa Harris	Premium	Branch	2014-12-25 17:59:28.402	43	M	Widowed	26211	Mid-career	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
38caa80d-19b5-4189-94d5-b8afcbe25d5b	C013	Andrew Lopez	Value	Advisor	2013-05-27 17:59:28.402	46	F	Married	70615	Mid-career	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
26dbb2be-38cb-4ce6-bf9f-4c253c9c47c4	C014	Michael Martinez	Premium	Branch	2017-08-14 17:59:28.402	69	F	Single	33339	Young Professional	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
10fb8583-8751-4e4d-aaf6-898f0d2d7838	C015	Michael Miller	Value	Branch	2015-05-31 17:59:28.402	58	M	Widowed	11132	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
224daf52-09a4-496f-8fb7-37a2f9f7caea	C016	John Martinez	Mass Market	Online	2023-02-05 17:59:28.402	57	M	Divorced	24459	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
c8838cb9-2b94-43ad-ac09-1f39e76f3b2e	C017	Anthony Jackson	Affluent	Advisor	2020-05-10 17:59:28.402	50	F	Married	96267	Mid-career	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
959f9305-bfa0-4822-b05c-8e192bc1fad1	C018	Joshua Hall	Value	Branch	2023-10-07 17:59:28.402	44	F	Divorced	42908	Mid-career	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
4bb8461c-142d-4f95-8e26-7bc850fa69e9	C019	Laura Jackson	Premium	Online	2014-04-17 17:59:28.402	45	M	Single	33053	Young Family	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
4cd55c01-6c8f-4961-a26c-8b66b4a9e7b0	C020	Christopher Anderson	Value	Online	2020-02-05 17:59:28.402	39	M	Married	73181	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
6fd6281b-51d0-4cce-ac2b-cc2193447dc0	C021	Daniel Hernandez	Value	Online	2015-06-04 17:59:28.402	53	M	Married	44312	Mid-career	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
757c1c2c-c7ed-4811-9319-5edd8cb81f19	C022	John Hall	Mass Market	Advisor	2013-03-31 17:59:28.402	55	M	Divorced	22833	Young Professional	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
c0b115da-bde0-42ab-8fe6-17b67279fb6a	C023	Emily Martinez	Affluent	Online	2012-02-03 17:59:28.402	67	F	Married	27960	Retired	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
81592815-c79e-45a6-b9b7-820219f356d7	C024	Michael Clark	Mass Market	Advisor	2023-02-11 17:59:28.402	29	F	Married	77145	Young Family	2025-11-25 17:59:29.992437	2025-11-25 17:59:29.992437
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, crm_customer_id, first_name, last_name, email, phone, location, age, segment, tier, churn_score, clv_12_month, clv_lifetime, engagement_score, tenure_months, last_activity, propensity_scores, created_at, updated_at) FROM stdin;
dcf3358e-3fd4-4e0d-bffb-0be5e5320ec3	C001	Jennifer	Martinez	jennifer.martinez1@example.com	555-4566	Chicago, TX	50	Mass Market	gold	0.14	4998.22	25840.80	5.4	108	2025-10-26 17:59:28.401	{"auto_insurance": 0.77, "home_insurance": 0.32, "life_insurance": 0.28, "umbrella_policy": 0.42}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
02b87d55-ae84-490c-999a-d3f1fcca7ed7	C002	William	Robinson	william.robinson2@example.com	555-1873	San Diego, CA	49	Premium	bronze	0.20	2148.88	8402.12	4.8	72	2025-11-24 17:59:28.401	{"auto_insurance": 0.57, "home_insurance": 0.4, "life_insurance": 0.33, "umbrella_policy": 0.2}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
5191d233-a46a-4256-8402-d0a5d84d5e84	C003	Elizabeth	Taylor	elizabeth.taylor3@example.com	555-9869	Austin, NY	63	Value	silver	0.45	8648.89	52412.27	8.5	36	2025-11-03 17:59:28.401	{"auto_insurance": 0.23, "home_insurance": 0.87, "life_insurance": 0.34, "umbrella_policy": 0.28}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
456b2667-a154-4245-88ec-baefb32e92d8	C004	James	Hernandez	james.hernandez4@example.com	555-5268	Phoenix, PA	35	Value	platinum	0.41	8606.04	55767.14	5.1	156	2025-11-17 17:59:28.401	{"auto_insurance": 0.71, "home_insurance": 0.4, "life_insurance": 0.34, "umbrella_policy": 0.07}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
aedefefd-5930-4370-a870-e98f12b69844	C005	Ashley	Wright	ashley.wright5@example.com	555-6808	Chicago, CA	57	Mass Market	bronze	0.05	21994.38	145162.91	8.4	144	2025-11-23 17:59:28.401	{"auto_insurance": 0.64, "home_insurance": 0.66, "life_insurance": 0.65, "umbrella_policy": 0.18}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
ca00a9a7-5efc-44c1-a7f0-f0ace0b9d39a	C006	Joshua	Lewis	joshua.lewis6@example.com	555-3791	San Antonio, PA	41	Value	silver	0.66	14393.98	58583.50	5.5	120	2025-11-24 17:59:28.401	{"auto_insurance": 0.42, "home_insurance": 0.69, "life_insurance": 0.42, "umbrella_policy": 0.32}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
9e9d6606-e3d8-47c2-819a-0c7a3ca29027	C007	Sarah	White	sarah.white7@example.com	555-7729	San Diego, NY	29	Affluent	silver	0.32	24848.22	113059.40	7.6	108	2025-11-23 17:59:28.401	{"auto_insurance": 0.82, "home_insurance": 0.39, "life_insurance": 0.14, "umbrella_policy": 0.38}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
1fbf3ef4-a3b9-40f9-b135-d9e1e836203a	C008	William	Thomas	william.thomas8@example.com	555-4095	Austin, IL	50	Value	bronze	0.46	20472.53	83937.37	8.1	12	2025-10-28 17:59:28.401	{"auto_insurance": 0.58, "home_insurance": 0.32, "life_insurance": 0.33, "umbrella_policy": 0.56}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
234626f4-270d-4dd5-bce4-ec35a46f52ff	C009	Ashley	Johnson	ashley.johnson9@example.com	555-2572	Los Angeles, TX	52	Premium	bronze	0.74	9565.02	58729.22	7.9	36	2025-10-29 17:59:28.401	{"auto_insurance": 0.52, "home_insurance": 0.76, "life_insurance": 0.13, "umbrella_policy": 0.25}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
c87a5204-5509-4df1-823e-10fa639f1199	C010	Nicole	Anderson	nicole.anderson10@example.com	555-8529	Austin, PA	53	Mass Market	silver	0.13	14183.60	45671.19	6.5	36	2025-11-10 17:59:28.401	{"auto_insurance": 0.89, "home_insurance": 0.45, "life_insurance": 0.74, "umbrella_policy": 0.38}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
75e4dc73-ef2a-4cea-b898-fff71c842244	C011	Jennifer	White	jennifer.white11@example.com	555-1498	Chicago, CA	31	Value	bronze	0.61	12141.83	61559.08	2.6	60	2025-11-21 17:59:28.401	{"auto_insurance": 0.76, "home_insurance": 0.94, "life_insurance": 0.37, "umbrella_policy": 0.58}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
cfc275af-f90e-4e70-9eef-5c31b060d200	C012	Lisa	Harris	lisa.harris12@example.com	555-6121	Philadelphia, TX	43	Affluent	bronze	0.58	21639.54	153857.13	8.5	132	2025-10-28 17:59:28.402	{"auto_insurance": 0.75, "home_insurance": 0.87, "life_insurance": 0.74, "umbrella_policy": 0.15}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
62644071-2140-4d20-b4ca-d719f9e4fd5f	C013	Andrew	Lopez	andrew.lopez13@example.com	555-1724	Austin, TX	46	Value	platinum	0.49	23515.73	72193.29	7.5	156	2025-10-27 17:59:28.402	{"auto_insurance": 0.81, "home_insurance": 0.37, "life_insurance": 0.55, "umbrella_policy": 0.4}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
63f39018-20b8-405a-86bb-e31142b7d95e	C014	Michael	Martinez	michael.martinez14@example.com	555-3128	Philadelphia, AZ	69	Value	gold	0.77	15118.56	104015.69	6.3	108	2025-11-22 17:59:28.402	{"auto_insurance": 0.69, "home_insurance": 0.74, "life_insurance": 0.5, "umbrella_policy": 0.34}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
b07a99ad-3a1c-4ef7-b633-58541edbdd8a	C015	Michael	Miller	michael.miller15@example.com	555-3454	San Diego, CA	58	Mass Market	platinum	0.10	20580.96	160531.49	6.0	132	2025-11-13 17:59:28.402	{"auto_insurance": 0.27, "home_insurance": 0.86, "life_insurance": 0.3, "umbrella_policy": 0.15}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
d01e1b25-018a-4e87-a776-3be74a549668	C016	John	Martinez	john.martinez16@example.com	555-4168	Dallas, NY	57	Value	platinum	0.40	2472.27	8974.34	5.0	36	2025-11-17 17:59:28.402	{"auto_insurance": 0.21, "home_insurance": 0.85, "life_insurance": 0.18, "umbrella_policy": 0.4}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
a6a53876-f546-4857-88b5-baf834fcb1ca	C017	Anthony	Jackson	anthony.jackson17@example.com	555-3302	Dallas, AZ	50	Affluent	bronze	0.47	19752.92	113974.35	6.7	72	2025-11-20 17:59:28.402	{"auto_insurance": 0.77, "home_insurance": 0.43, "life_insurance": 0.35, "umbrella_policy": 0.28}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
5c915311-9912-424c-821a-0eec03c65297	C018	Joshua	Hall	joshua.hall18@example.com	555-6448	Dallas, IL	44	Mass Market	gold	0.80	2072.93	12002.26	3.8	36	2025-11-10 17:59:28.402	{"auto_insurance": 0.58, "home_insurance": 0.64, "life_insurance": 0.34, "umbrella_policy": 0.42}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
9ac445df-440f-485e-a742-7d0bc2a442ff	C019	Laura	Jackson	laura.jackson19@example.com	555-5200	San Diego, PA	45	Affluent	gold	0.63	8057.04	62603.20	3.4	144	2025-10-27 17:59:28.402	{"auto_insurance": 0.63, "home_insurance": 0.88, "life_insurance": 0.45, "umbrella_policy": 0.14}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
6bc2322f-78ce-43cb-ad5c-782a87f06312	C020	Christopher	Anderson	christopher.anderson20@example.com	555-6036	San Antonio, IL	39	Premium	gold	0.56	17946.21	71246.45	2.4	72	2025-10-30 17:59:28.402	{"auto_insurance": 0.25, "home_insurance": 0.35, "life_insurance": 0.56, "umbrella_policy": 0.24}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
b8177f81-02a7-4776-9060-e7f92cb2c3d4	C021	Daniel	Hernandez	daniel.hernandez21@example.com	555-8652	New York, CA	53	Mass Market	platinum	0.85	20763.35	115028.96	5.2	132	2025-11-07 17:59:28.402	{"auto_insurance": 0.26, "home_insurance": 0.65, "life_insurance": 0.11, "umbrella_policy": 0.39}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
dfea3468-5b16-428d-b404-23b9f4fe8278	C022	John	Hall	john.hall22@example.com	555-9012	Chicago, AZ	55	Premium	silver	0.61	16285.64	60094.01	8.5	156	2025-11-25 17:59:28.402	{"auto_insurance": 0.28, "home_insurance": 0.57, "life_insurance": 0.33, "umbrella_policy": 0.09}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
bc4fa26d-c998-4e51-91c3-21cf9e31bca0	C023	Emily	Martinez	emily.martinez23@example.com	555-6888	Philadelphia, NY	67	Premium	platinum	0.60	6385.70	33844.21	5.6	168	2025-11-23 17:59:28.402	{"auto_insurance": 0.49, "home_insurance": 0.53, "life_insurance": 0.28, "umbrella_policy": 0.38}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
c47255d1-8f5b-4e20-9f94-adc925551be1	C024	Michael	Clark	michael.clark24@example.com	555-9403	New York, AZ	29	Premium	gold	0.24	10343.20	63610.68	3.8	36	2025-11-09 17:59:28.402	{"auto_insurance": 0.73, "home_insurance": 0.74, "life_insurance": 0.48, "umbrella_policy": 0.47}	2025-11-25 17:59:29.958928	2025-11-25 17:59:29.958928
\.


--
-- Data for Name: data_uploads; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.data_uploads (id, file_name, file_type, data_type, file_size, record_count, column_count, status, error_message, uploaded_by, validation_results, quick_stats, sample_data, uploaded_at, processed_at) FROM stdin;
\.


--
-- Data for Name: google_analytics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.google_analytics (id, customer_id, session_count_30d, avg_session_duration_sec, last_visit_date, clicks_on_products, campaigns_opened, device_type, created_at, updated_at) FROM stdin;
6de38e1e-b75f-413b-8065-8f7f9842f89c	C001	16	360	2025-10-30 17:59:28.401	10	7	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
a88c596f-8a86-4a25-a519-2565b8a9da9a	C002	7	259	2025-11-16 17:59:28.401	7	6	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
5c790b2e-10f1-473a-91f9-5b26b5f9d0ff	C003	4	557	2025-11-16 17:59:28.401	13	4	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
2d868fd3-3ea6-45c5-93cb-1419505c2598	C004	5	158	2025-11-17 17:59:28.401	9	3	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
c9db24a5-ad0e-4998-b9db-97a0cef8f2d9	C005	2	254	2025-11-02 17:59:28.401	1	1	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
4546652f-5e9d-4d65-a13a-ae688b0d1f6c	C006	5	406	2025-11-19 17:59:28.401	14	8	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
d9a7e292-3446-4f55-99b2-c70476949c1f	C007	7	170	2025-11-09 17:59:28.401	8	8	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
a9384276-c2ad-42bf-bb6e-aba32b1a223c	C008	18	527	2025-11-20 17:59:28.401	13	7	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
e0b6bbf2-7ef5-405d-912c-8bc08539d1f4	C009	3	296	2025-10-27 17:59:28.401	3	7	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
715860e5-85d1-4981-b2a7-4c299eb120e3	C010	4	279	2025-11-15 17:59:28.401	6	0	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
5f1822de-436d-4989-994a-2eae984dd8cc	C011	23	361	2025-11-25 17:59:28.402	6	5	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
4165baa3-21c9-4d85-8e98-09c0a4e1cc38	C012	22	101	2025-10-31 17:59:28.402	12	5	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
4960ae06-f54a-4fd0-ad61-169922993556	C013	8	546	2025-11-01 17:59:28.402	11	8	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
18d9d480-4b78-4529-8db9-00c0191fa47a	C014	5	233	2025-11-08 17:59:28.402	1	0	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
9cfa76ea-45fd-4d9d-9d35-086b93b84795	C015	25	499	2025-11-13 17:59:28.402	6	5	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
4dfc3992-c2bd-42f8-8a45-be375df56e13	C016	6	497	2025-11-06 17:59:28.402	4	5	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
8510c909-2074-4dfd-82e2-0e0c419c8a25	C017	3	468	2025-10-29 17:59:28.402	15	6	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
ab8d4c52-9c97-4879-89ba-8ebaf3710b9e	C018	17	399	2025-11-15 17:59:28.402	4	3	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
7046299e-13ad-4ca3-8b15-7c5f248ad714	C019	22	404	2025-10-27 17:59:28.402	6	0	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
ee1db604-4512-4607-899c-7725c029d2e9	C020	21	418	2025-11-04 17:59:28.402	1	7	Mobile	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
ff2d63cd-3a85-4295-a1dc-97bcaf49a049	C021	15	474	2025-11-18 17:59:28.402	5	4	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
cbe99f74-24ab-4452-8b97-96e9542287ce	C022	21	156	2025-11-23 17:59:28.402	3	0	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
3749c7ca-4659-4964-b7ce-b1bd69bcd775	C023	8	390	2025-11-05 17:59:28.402	4	5	Tablet	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
ebe4e6b8-ccdc-4dac-bb89-c88f0b74632f	C024	1	361	2025-11-02 17:59:28.402	2	2	Desktop	2025-11-25 17:59:30.025174	2025-11-25 17:59:30.025174
\.


--
-- Data for Name: interactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.interactions (id, customer_id, type, channel, description, metadata, "timestamp") FROM stdin;
b7c9307f-6f11-4b40-b9d5-febfa2900a49	dcf3358e-3fd4-4e0d-bffb-0be5e5320ec3	support	web	Payment confirmation	{"duration": 5, "resolved": true}	2025-11-25 17:59:30.072178
bef4e8fe-87d4-40ca-8d28-64db3ba48d5a	dcf3358e-3fd4-4e0d-bffb-0be5e5320ec3	purchase	web	Address update	{"duration": 7, "resolved": true}	2025-11-25 17:59:30.072178
4b25d5c1-3602-4215-96ea-62072c7a605b	02b87d55-ae84-490c-999a-d3f1fcca7ed7	campaign	mobile	Claims status check	{"duration": 3, "resolved": false}	2025-11-25 17:59:30.072178
2a0ee7de-366f-4000-802a-bf7cbfbea443	02b87d55-ae84-490c-999a-d3f1fcca7ed7	call	email	Renewal discussion	{"duration": 14, "resolved": false}	2025-11-25 17:59:30.072178
d085b3c8-c908-4c38-8ec2-9036f89904e1	02b87d55-ae84-490c-999a-d3f1fcca7ed7	email	web	Claims status check	{"duration": 12, "resolved": false}	2025-11-25 17:59:30.072178
1b09e53f-e3b9-4d44-a523-988884e93c99	02b87d55-ae84-490c-999a-d3f1fcca7ed7	email	phone	Quote request	{"duration": 3, "resolved": true}	2025-11-25 17:59:30.072178
5f85a5c8-f2a2-440e-8f2b-1e5cf30f5c4a	5191d233-a46a-4256-8402-d0a5d84d5e84	email	web	Bundle inquiry	{"duration": 9, "resolved": true}	2025-11-25 17:59:30.072178
852c35f0-a1b4-4620-bab3-062cfdeed244	5191d233-a46a-4256-8402-d0a5d84d5e84	campaign	email	Bundle inquiry	{"duration": 15, "resolved": true}	2025-11-25 17:59:30.072178
219d1e9e-185a-4fca-b509-db655c6f225a	5191d233-a46a-4256-8402-d0a5d84d5e84	campaign	email	Bundle inquiry	{"duration": 13, "resolved": true}	2025-11-25 17:59:30.072178
f092ff65-78b7-4f6d-865f-962e6b180ebe	5191d233-a46a-4256-8402-d0a5d84d5e84	purchase	email	Address update	{"duration": 5, "resolved": true}	2025-11-25 17:59:30.072178
c3fcd32c-924c-4617-b885-f8178cafdd89	456b2667-a154-4245-88ec-baefb32e92d8	purchase	phone	Claims status check	{"duration": 12, "resolved": false}	2025-11-25 17:59:30.072178
3b49c5a0-bbaf-4f83-8e1f-79320e26c04c	aedefefd-5930-4370-a870-e98f12b69844	call	mobile	Quote request	{"duration": 8, "resolved": true}	2025-11-25 17:59:30.072178
05bb2b13-5769-4168-bf9b-84bd15cbe19f	ca00a9a7-5efc-44c1-a7f0-f0ace0b9d39a	purchase	mobile	Coverage question	{"duration": 2, "resolved": true}	2025-11-25 17:59:30.072178
c126ad9a-96ee-4363-8003-c1270668e01e	ca00a9a7-5efc-44c1-a7f0-f0ace0b9d39a	campaign	phone	Renewal discussion	{"duration": 9, "resolved": true}	2025-11-25 17:59:30.072178
3a37e5a9-efbf-494e-96ad-d7e87bf1492e	9e9d6606-e3d8-47c2-819a-0c7a3ca29027	call	phone	Bundle inquiry	{"duration": 11, "resolved": true}	2025-11-25 17:59:30.072178
e2f82683-da56-4084-938f-4cadcfb495df	9e9d6606-e3d8-47c2-819a-0c7a3ca29027	call	phone	Renewal discussion	{"duration": 12, "resolved": true}	2025-11-25 17:59:30.072178
b71f3846-3a8d-4009-a03f-9cfb6dadfb2c	9e9d6606-e3d8-47c2-819a-0c7a3ca29027	support	email	Payment confirmation	{"duration": 3, "resolved": true}	2025-11-25 17:59:30.072178
2ec7c1ba-f714-4dfa-9cd0-70e0c8b82985	9e9d6606-e3d8-47c2-819a-0c7a3ca29027	campaign	mobile	Coverage question	{"duration": 4, "resolved": false}	2025-11-25 17:59:30.072178
e517e17e-a165-4e66-a908-d7232575ca8e	1fbf3ef4-a3b9-40f9-b135-d9e1e836203a	purchase	mobile	Policy inquiry call	{"duration": 4, "resolved": true}	2025-11-25 17:59:30.072178
66ffaf7c-9c2a-4ea3-90c2-cc3fe31a4909	1fbf3ef4-a3b9-40f9-b135-d9e1e836203a	purchase	mobile	Address update	{"duration": 6, "resolved": true}	2025-11-25 17:59:30.072178
bf9be4a8-1688-4ea8-b40f-a16482cd3376	1fbf3ef4-a3b9-40f9-b135-d9e1e836203a	support	web	Coverage question	{"duration": 15, "resolved": true}	2025-11-25 17:59:30.072178
0990e4a1-6db7-44ad-9e9f-aa5fa8188c2e	1fbf3ef4-a3b9-40f9-b135-d9e1e836203a	call	email	Claims status check	{"duration": 7, "resolved": true}	2025-11-25 17:59:30.072178
e4118e98-dfa7-45d1-b94a-309be4cc738b	234626f4-270d-4dd5-bce4-ec35a46f52ff	purchase	phone	Quote request	{"duration": 15, "resolved": true}	2025-11-25 17:59:30.072178
662a65e5-9460-4f18-9b0a-149eeacb566d	234626f4-270d-4dd5-bce4-ec35a46f52ff	support	mobile	Quote request	{"duration": 15, "resolved": true}	2025-11-25 17:59:30.072178
5da37b32-8f8f-4012-8533-051008260849	234626f4-270d-4dd5-bce4-ec35a46f52ff	email	phone	Bundle inquiry	{"duration": 12, "resolved": true}	2025-11-25 17:59:30.072178
09caa16b-c165-40d9-a838-44773ab9b39b	234626f4-270d-4dd5-bce4-ec35a46f52ff	purchase	mobile	Renewal discussion	{"duration": 11, "resolved": true}	2025-11-25 17:59:30.072178
f857a748-e994-44ea-952e-4e40d3581dfd	c87a5204-5509-4df1-823e-10fa639f1199	support	phone	Policy inquiry call	{"duration": 10, "resolved": true}	2025-11-25 17:59:30.072178
def0e4aa-c155-4aff-99ca-818778fe2c95	c87a5204-5509-4df1-823e-10fa639f1199	call	web	Claims status check	{"duration": 4, "resolved": true}	2025-11-25 17:59:30.072178
b9627619-c4b0-4881-a6b4-facc3bb66f82	75e4dc73-ef2a-4cea-b898-fff71c842244	call	email	Address update	{"duration": 13, "resolved": true}	2025-11-25 17:59:30.072178
aee4cddf-37e2-4115-a3ed-00c2cd108759	cfc275af-f90e-4e70-9eef-5c31b060d200	email	mobile	Coverage question	{"duration": 3, "resolved": true}	2025-11-25 17:59:30.072178
01e6f879-2b56-490b-8db0-f195395e35bc	cfc275af-f90e-4e70-9eef-5c31b060d200	email	mobile	Address update	{"duration": 4, "resolved": false}	2025-11-25 17:59:30.072178
af366dbd-e63d-4f8d-8bc4-0b0dfd08344c	cfc275af-f90e-4e70-9eef-5c31b060d200	campaign	mobile	Bundle inquiry	{"duration": 7, "resolved": false}	2025-11-25 17:59:30.072178
3755672c-6483-4437-816e-a191212b502f	62644071-2140-4d20-b4ca-d719f9e4fd5f	support	phone	Bundle inquiry	{"duration": 5, "resolved": true}	2025-11-25 17:59:30.072178
7a9a319d-5e1c-4208-b687-df4512b2c1b4	62644071-2140-4d20-b4ca-d719f9e4fd5f	support	email	Address update	{"duration": 14, "resolved": true}	2025-11-25 17:59:30.072178
ee8485e0-7522-4c44-8e5d-9bab429677c0	62644071-2140-4d20-b4ca-d719f9e4fd5f	call	mobile	Claims status check	{"duration": 6, "resolved": true}	2025-11-25 17:59:30.072178
2a99207c-920a-49d3-8a8b-ec2844ccbda6	63f39018-20b8-405a-86bb-e31142b7d95e	support	phone	Bundle inquiry	{"duration": 6, "resolved": true}	2025-11-25 17:59:30.072178
b9a39167-28da-43f6-bcfd-54a72a0b79a8	63f39018-20b8-405a-86bb-e31142b7d95e	purchase	mobile	Renewal discussion	{"duration": 7, "resolved": false}	2025-11-25 17:59:30.072178
5d145e6e-641d-4973-ad57-b6023f54ba78	63f39018-20b8-405a-86bb-e31142b7d95e	call	email	Address update	{"duration": 11, "resolved": false}	2025-11-25 17:59:30.072178
4a0f8f9b-56e1-43c3-888c-3c6f8ac86464	b07a99ad-3a1c-4ef7-b633-58541edbdd8a	email	email	Claims status check	{"duration": 4, "resolved": true}	2025-11-25 17:59:30.072178
0c768ae3-3e22-44a5-9efb-71feaa385486	b07a99ad-3a1c-4ef7-b633-58541edbdd8a	campaign	email	Bundle inquiry	{"duration": 6, "resolved": true}	2025-11-25 17:59:30.072178
8db001e5-ce97-455f-abb5-923e105f89a2	b07a99ad-3a1c-4ef7-b633-58541edbdd8a	support	email	Renewal discussion	{"duration": 10, "resolved": true}	2025-11-25 17:59:30.072178
\.


--
-- Data for Name: market_benchmarking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.market_benchmarking (id, product_type, product_features, avg_premium_market, avg_claim_settlement_days_market, churn_rate_market, competitor_top_offers, created_at, updated_at) FROM stdin;
c36157c0-31ad-4c18-9340-cc3ef8032720	Home Insurance	Fire, Theft, Flood Rider, Liability	1150.00	21	0.160	Free smart home devices, Vanishing deductible	2025-11-25 17:59:30.037209	2025-11-25 17:59:30.037209
e2cd1beb-4148-47ce-9934-f255973f51d2	Auto Insurance	Collision, Comprehensive, Roadside, Rental	1450.00	14	0.180	Accident forgiveness, Safe driver discount	2025-11-25 17:59:30.037209	2025-11-25 17:59:30.037209
85b521e3-d978-42cb-abce-8f48c8d61eb8	Life Insurance	Term, Whole, Universal, Riders	850.00	45	0.080	No medical exam, Living benefits	2025-11-25 17:59:30.037209	2025-11-25 17:59:30.037209
695a4d65-dc0d-44fa-b2e7-962609d0d425	Umbrella Policy	Extended Liability, Legal Defense, Worldwide Coverage	350.00	30	0.120	Million dollar coverage from $15/month	2025-11-25 17:59:30.037209	2025-11-25 17:59:30.037209
1da599f3-30cb-4c99-9129-2aebd7c9cc18	Renters Insurance	Personal Property, Liability, Additional Living Expenses	180.00	10	0.250	Coverage from $5/month, Instant quotes	2025-11-25 17:59:30.037209	2025-11-25 17:59:30.037209
\.


--
-- Data for Name: model_runs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.model_runs (id, model_type, status, progress, records_processed, total_records, data_quality, performance, error_message, started_at, completed_at, created_at) FROM stdin;
\.


--
-- Data for Name: policy_details; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_details (id, policy_id, customer_id, product_type, policy_start, premium_amount, policy_value, payment_frequency, status, num_claims, tenure_months, created_at, updated_at) FROM stdin;
8e09d3cc-efc9-4a6c-9136-788db4334bd0	P0011	C001	Home Insurance	2025-10-05 17:59:28.401	2421.02	121051.00	Quarterly	Active	0	1	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
b70e18b3-8b63-4a23-99c6-d353f8819383	P0021	C002	Home Insurance	2023-06-27 17:59:28.401	2167.15	60680.20	Monthly	Active	2	29	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
3d947677-fd0d-4565-9f32-7b6965f1d55f	P0022	C002	Auto Insurance	2024-02-07 17:59:28.401	1183.39	37868.48	Quarterly	Active	1	21	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
5ff788fe-74ed-4cff-83cf-9ab02d75c9fe	P0031	C003	Home Insurance	2023-06-15 17:59:28.401	698.08	7678.88	Monthly	Lapsed	0	29	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
82c6ccaf-b205-4e60-a5cd-7f19d29f796b	P0032	C003	Auto Insurance	2023-03-26 17:59:28.401	795.71	31828.40	Quarterly	Lapsed	3	32	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
f7a9a83b-9c4e-4741-ad35-152a689490a0	P0041	C004	Home Insurance	2023-09-05 17:59:28.401	1845.69	53525.01	Monthly	Active	1	27	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
27221ed0-fab3-4af9-89f2-40744fd9675b	P0042	C004	Auto Insurance	2023-10-18 17:59:28.401	2507.02	62675.50	Annual	Active	1	25	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
1d7a17b4-f832-47da-b5cd-3f5cefb7e31f	P0043	C004	Life Insurance	2024-06-02 17:59:28.401	3371.76	148357.44	Quarterly	Pending Renewal	0	18	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
e6358e2c-5491-4132-b7bd-31a8c4c8807a	P0051	C005	Home Insurance	2023-09-17 17:59:28.401	3088.57	71037.11	Annual	Active	2	26	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
7911a6fe-8f71-4a1e-8e96-3e0f81c45a27	P0052	C005	Auto Insurance	2024-12-10 17:59:28.401	2166.90	21669.00	Monthly	Active	1	11	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
41320db8-0b47-4f08-a917-fc30a99b995d	P0061	C006	Home Insurance	2024-10-13 17:59:28.401	519.26	22328.18	Quarterly	Pending Renewal	0	13	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
c45e9507-c691-4739-875c-ad048405776b	P0062	C006	Auto Insurance	2024-12-13 17:59:28.401	976.33	25384.58	Quarterly	Lapsed	2	11	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
105f4823-8a38-4787-8eaa-44429afa15e4	P0063	C006	Life Insurance	2024-11-08 17:59:28.401	1933.67	27071.38	Annual	Pending Renewal	3	12	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
05b0935b-d1e4-4f2b-8b4b-959204f92038	P0071	C007	Home Insurance	2024-07-04 17:59:28.401	2963.60	139289.20	Monthly	Pending Renewal	1	16	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
adbe5738-ebec-45e5-b6af-07276cfb1e0f	P0072	C007	Auto Insurance	2024-05-26 17:59:28.401	1482.38	57812.82	Annual	Pending Renewal	0	18	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
faa51196-035f-4b74-8241-8e6d30e42cb9	P0073	C007	Life Insurance	2023-06-03 17:59:28.401	685.13	26720.07	Quarterly	Pending Renewal	3	30	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
c22bb772-4192-4fbe-b28a-fff2397f1fff	P0081	C008	Home Insurance	2023-03-02 17:59:28.401	1308.71	14395.81	Quarterly	Lapsed	2	33	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
cea93c19-e04f-4d54-988c-7542761c092f	P0091	C009	Home Insurance	2025-10-14 17:59:28.401	3471.27	34712.70	Monthly	Lapsed	3	1	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
66890083-7726-4d37-a31e-7aaf036c95ec	P0092	C009	Auto Insurance	2023-09-10 17:59:28.401	1346.83	44445.39	Monthly	Pending Renewal	3	26	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
c0c2d2ea-3fbf-4bd1-9e0f-2f3e587f7c9e	P0093	C009	Life Insurance	2023-02-23 17:59:28.401	2607.47	114728.68	Annual	Pending Renewal	0	33	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
d0b42618-cad2-4391-a921-035e25d84dba	P0101	C010	Home Insurance	2024-08-04 17:59:28.401	2480.66	32248.58	Annual	Active	0	15	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
129f3260-f89a-4630-b9c0-feec12d5ecae	P0102	C010	Auto Insurance	2022-12-02 17:59:28.401	3048.79	128049.18	Annual	Pending Renewal	1	36	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
c268d73d-5257-4a7c-beac-b6bd3421920f	P0111	C011	Home Insurance	2023-01-10 17:59:28.401	2720.96	117001.28	Annual	Pending Renewal	3	35	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
ac85de02-1c6f-4304-add3-2ff7e668bb85	P0112	C011	Auto Insurance	2023-01-10 17:59:28.402	1077.25	18313.25	Monthly	Active	3	35	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
77ea884b-7117-4cba-a5c2-67f04bc09efc	P0121	C012	Home Insurance	2024-07-23 17:59:28.402	1625.10	79629.90	Quarterly	Pending Renewal	3	16	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
116f77cc-ce5d-43f9-a010-93a9056aeab8	P0131	C013	Home Insurance	2023-03-23 17:59:28.402	1908.25	19082.50	Quarterly	Pending Renewal	2	32	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
52511eb8-7e13-4bdb-b9c2-cd0dd293064f	P0141	C014	Home Insurance	2024-05-15 17:59:28.402	2738.22	93099.48	Monthly	Lapsed	1	18	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
cbccca2b-a8f1-4172-bc2a-82855073f874	P0142	C014	Auto Insurance	2025-04-06 17:59:28.402	1476.91	47261.12	Quarterly	Pending Renewal	1	7	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
2f8e352f-9ec9-4add-85b5-c9ee9278d848	P0143	C014	Life Insurance	2025-02-02 17:59:28.402	593.07	23129.73	Monthly	Active	0	9	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
b4976842-5bdb-4ee1-8fd4-d77f0b389aae	P0151	C015	Home Insurance	2025-05-29 17:59:28.402	1541.52	24664.32	Quarterly	Pending Renewal	2	6	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
04985cb7-eff2-4afa-bbd4-bbe286dfdd12	P0161	C016	Home Insurance	2024-01-11 17:59:28.402	2836.24	62397.28	Annual	Lapsed	1	22	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
70cddf77-740b-4de4-b5ea-30f3f42fba82	P0162	C016	Auto Insurance	2024-01-06 17:59:28.402	2170.13	104166.24	Annual	Lapsed	2	22	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
64a689f1-d70c-4406-983e-01496d32975f	P0163	C016	Life Insurance	2025-05-26 17:59:28.402	1310.10	35372.70	Monthly	Lapsed	3	6	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
5a0be94e-c7c6-4fa7-976c-a51b7b2eb61e	P0171	C017	Home Insurance	2023-10-02 17:59:28.402	507.47	20298.80	Monthly	Pending Renewal	0	26	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
04ac8c95-258d-419a-9ee1-207c74da5c7a	P0181	C018	Home Insurance	2025-07-25 17:59:28.402	2311.89	78604.26	Quarterly	Active	0	4	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
e93246cd-0e8f-4db7-9c8d-34af00745538	P0182	C018	Auto Insurance	2024-07-20 17:59:28.402	1291.11	49062.18	Monthly	Active	3	16	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
e4184b1e-bd71-40cb-98cf-5761204afb3a	P0191	C019	Home Insurance	2023-06-14 17:59:28.402	2399.37	69581.73	Annual	Active	2	29	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
ce6a0ed2-8711-4f3c-b582-515a7d9bbd71	P0201	C020	Home Insurance	2025-07-19 17:59:28.402	2433.35	58400.40	Quarterly	Active	0	4	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
f8278139-12ad-45e7-b604-ff0669138244	P0202	C020	Auto Insurance	2024-02-23 17:59:28.402	664.69	11299.73	Monthly	Lapsed	0	21	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
01a8631d-798e-4c93-b8ab-791802df5d8e	P0211	C021	Home Insurance	2025-10-18 17:59:28.402	706.25	22600.00	Quarterly	Active	1	1	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
8ae94906-9b2f-4975-a581-021a44dcde9b	P0212	C021	Auto Insurance	2025-04-08 17:59:28.402	2142.53	53563.25	Monthly	Pending Renewal	2	7	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
6f64634b-beb6-40a4-81c9-debc70e0c41c	P0213	C021	Life Insurance	2023-12-07 17:59:28.402	2401.79	52839.38	Quarterly	Active	1	23	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
bc51dbf2-c9fe-4850-b04e-6ccf5612d349	P0221	C022	Home Insurance	2023-06-07 17:59:28.402	595.61	24420.01	Annual	Active	1	30	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
bb85cb47-393a-42a5-af35-76c044278d87	P0222	C022	Auto Insurance	2024-09-23 17:59:28.402	1612.80	24192.00	Annual	Pending Renewal	0	14	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
344d0863-0d22-48cf-8a9d-af126d0993c4	P0231	C023	Home Insurance	2025-09-24 17:59:28.402	3283.18	65663.60	Quarterly	Active	2	2	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
0a5503cd-f665-4691-8f88-5021ae9e9de7	P0241	C024	Home Insurance	2025-08-18 17:59:28.402	2480.52	57051.96	Annual	Lapsed	2	3	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
959ce7c9-8f4c-4b42-9da6-5b29b93877e0	P0242	C024	Auto Insurance	2023-05-04 17:59:28.402	1293.49	19402.35	Quarterly	Pending Renewal	3	31	2025-11-25 17:59:30.008506	2025-11-25 17:59:30.008506
\.


--
-- Data for Name: product_benchmarking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_benchmarking (id, product, company_avg_annual_premium, company_claims_ratio_pct, company_renewal_rate_pct, coverage_features_offered, company_add_on_uptake_pct, competitor1_avg_premium, competitor1_renewal_rate_pct, competitor2_avg_premium, competitor2_renewal_rate_pct, created_at, updated_at) FROM stdin;
c76fc5f7-0e79-4e6a-9860-b0483e9cedbf	Home Insurance	1200.00	62.0	84.0	Fire, Theft, Flood Rider, Liability	38.0	1050.00	79.0	1150.00	82.0	2025-11-25 17:59:30.044171	2025-11-25 17:59:30.044171
7ce6e808-8eb0-4a56-b3b3-4140fb4e40d0	Auto Insurance	1480.00	68.0	78.0	Collision, Comprehensive, Roadside Assistance, Rental Reimbursement	42.0	1380.00	75.0	1520.00	80.0	2025-11-25 17:59:30.044171	2025-11-25 17:59:30.044171
cfe60baa-55a6-44f1-960a-9b2453fef7aa	Life Insurance	920.00	45.0	92.0	Term Life, Whole Life, Accidental Death, Critical Illness Rider	28.0	880.00	90.0	950.00	91.0	2025-11-25 17:59:30.044171	2025-11-25 17:59:30.044171
dd145ac6-77ce-47e5-993b-877300bef6e6	Umbrella Policy	380.00	35.0	88.0	Extended Liability, Legal Defense, Worldwide Coverage	22.0	340.00	85.0	360.00	86.0	2025-11-25 17:59:30.044171	2025-11-25 17:59:30.044171
4e1b916f-0ef9-4449-94e6-0226c6e82044	Renters Insurance	195.00	52.0	72.0	Personal Property, Liability, Additional Living Expenses, Theft	18.0	165.00	68.0	180.00	70.0	2025-11-25 17:59:30.044171	2025-11-25 17:59:30.044171
\.


--
-- Data for Name: renewal_window_tracking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.renewal_window_tracking (id, customer_id, policy_number, renewal_date, property_address, policy_type, current_premium, days_to_renewal, renewal_status, last_contact_date, agent_notes, priority, created_at, updated_at) FROM stdin;
ec697740-b8d6-4e02-9ae1-007225d12cc2	dcf3358e-3fd4-4e0d-bffb-0be5e5320ec3	POL-C001-2988	2026-01-03 17:59:28.401	1612 Pine Ln	Renters Insurance	2375.58	38	renewed	\N	\N	low	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
c605333b-c9f5-4af7-9212-11727eabe469	02b87d55-ae84-490c-999a-d3f1fcca7ed7	POL-C002-2257	2025-12-03 17:59:28.401	9666 Elm Ave	Renters Insurance	2822.22	7	pending	2025-11-20 17:59:28.401	\N	low	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
684a901d-559c-4b0a-bec8-ab690861ee5f	5191d233-a46a-4256-8402-d0a5d84d5e84	POL-C003-7776	2026-02-18 17:59:28.401	7907 Cedar St	Home Insurance	2021.15	84	contacted	\N	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
363a0e0c-70b0-4884-8822-1a7ca94cd528	456b2667-a154-4245-88ec-baefb32e92d8	POL-C004-3642	2026-01-29 17:59:28.401	8010 Maple St	Umbrella Policy	1822.98	65	contacted	\N	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
3d0b80fa-c447-4bab-b55b-5327a0ffe1fc	aedefefd-5930-4370-a870-e98f12b69844	POL-C006-9457	2026-01-02 17:59:28.401	4296 Pine Ln	Life Insurance	2185.33	37	renewed	\N	High priority - discuss retention offer	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
02589c3c-f89a-4936-b3c0-d5528bb942d3	ca00a9a7-5efc-44c1-a7f0-f0ace0b9d39a	POL-C007-6704	2025-11-16 17:59:28.401	6217 Maple Ln	Umbrella Policy	2338.41	-10	expired	2025-11-20 17:59:28.401	\N	low	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
b6ca2e28-13a2-4546-b45d-c919876f6275	9e9d6606-e3d8-47c2-819a-0c7a3ca29027	POL-C008-1215	2025-11-25 17:59:28.401	4677 Pine St	Life Insurance	2932.86	0	renewed	2025-11-25 17:59:28.401	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
d93448ed-97b7-40c4-91cc-18eb90f9f8c3	1fbf3ef4-a3b9-40f9-b135-d9e1e836203a	POL-C009-9859	2025-12-28 17:59:28.401	5466 Oak Ln	Umbrella Policy	1323.62	33	contacted	\N	High priority - discuss retention offer	high	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
d46339e3-0584-48fc-8123-cae96eca4a63	234626f4-270d-4dd5-bce4-ec35a46f52ff	POL-C011-9387	2026-02-02 17:59:28.402	4084 Oak Ln	Umbrella Policy	2001.14	69	contacted	\N	High priority - discuss retention offer	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
afeeda55-2ae0-4794-80f0-9505053d7568	c87a5204-5509-4df1-823e-10fa639f1199	POL-C012-8565	2026-01-29 17:59:28.402	4459 Elm St	Umbrella Policy	1747.71	64	pending	\N	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
8b990ab6-f4a3-40ac-b94e-72162ae6d54e	75e4dc73-ef2a-4cea-b898-fff71c842244	POL-C013-5450	2026-02-03 17:59:28.402	4703 Maple Ln	Life Insurance	2578.74	70	pending	\N	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
f3c746f2-8023-4251-b688-a51fb1db7509	cfc275af-f90e-4e70-9eef-5c31b060d200	POL-C014-5418	2025-12-12 17:59:28.402	7722 Pine Ln	Umbrella Policy	1934.00	16	renewed	2025-11-25 17:59:28.402	High priority - discuss retention offer	high	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
74b40c4e-1618-460b-96ab-72eb8ff59320	62644071-2140-4d20-b4ca-d719f9e4fd5f	POL-C016-5263	2026-01-27 17:59:28.402	4157 Cedar Ln	Auto Insurance	2467.10	63	renewed	\N	\N	low	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
2da74f67-9c8b-4c63-bbd4-422d6edf4a38	63f39018-20b8-405a-86bb-e31142b7d95e	POL-C017-2102	2026-01-16 17:59:28.402	7779 Cedar Ln	Home Insurance	841.83	52	pending	\N	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
abbfe0ee-6f48-4e11-a3ea-5dc6b7f0cb59	b07a99ad-3a1c-4ef7-b633-58541edbdd8a	POL-C018-8341	2026-01-13 17:59:28.402	7611 Elm Blvd	Renters Insurance	898.51	48	contacted	\N	High priority - discuss retention offer	high	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
8b9dc317-8288-4dd7-8b4a-2ca8209457b0	d01e1b25-018a-4e87-a776-3be74a549668	POL-C019-4398	2025-11-26 17:59:28.402	1480 Elm Blvd	Life Insurance	822.51	0	pending	2025-11-23 17:59:28.402	High priority - discuss retention offer	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
6f089486-064f-4f1e-803e-95dadb95d439	a6a53876-f546-4857-88b5-baf834fcb1ca	POL-C020-5978	2026-02-04 17:59:28.402	1554 Pine Ln	Umbrella Policy	1502.21	70	renewed	\N	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
311867b2-6eca-44e1-8c12-f5a5a903ac9a	5c915311-9912-424c-821a-0eec03c65297	POL-C021-1786	2026-02-03 17:59:28.402	577 Pine St	Home Insurance	1910.49	70	contacted	\N	High priority - discuss retention offer	high	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
5010bdfb-d033-4f00-a946-dc26dbaf5fb6	9ac445df-440f-485e-a742-7d0bc2a442ff	POL-C022-7796	2025-11-16 17:59:28.402	6179 Cedar St	Auto Insurance	1304.91	-9	expired	2025-11-25 17:59:28.402	High priority - discuss retention offer	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
2d99cdf2-35f1-4691-8ff9-052f4cd1ef23	6bc2322f-78ce-43cb-ad5c-782a87f06312	POL-C023-5728	2025-12-16 17:59:28.402	8112 Cedar Blvd	Life Insurance	2967.48	20	pending	2025-11-13 17:59:28.402	\N	medium	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
0e811cab-db61-40ab-a28b-124824f6d5f6	b8177f81-02a7-4776-9060-e7f92cb2c3d4	POL-C024-5397	2025-12-23 17:59:28.402	6614 Cedar Ave	Auto Insurance	2676.66	28	contacted	2025-11-11 17:59:28.402	\N	low	2025-11-25 17:59:30.052779	2025-11-25 17:59:30.052779
\.


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: credit_bureau credit_bureau_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credit_bureau
    ADD CONSTRAINT credit_bureau_pkey PRIMARY KEY (id);


--
-- Name: crm_customer_360 crm_customer_360_customer_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.crm_customer_360
    ADD CONSTRAINT crm_customer_360_customer_id_unique UNIQUE (customer_id);


--
-- Name: crm_customer_360 crm_customer_360_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.crm_customer_360
    ADD CONSTRAINT crm_customer_360_pkey PRIMARY KEY (id);


--
-- Name: customers customers_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_unique UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: data_uploads data_uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_uploads
    ADD CONSTRAINT data_uploads_pkey PRIMARY KEY (id);


--
-- Name: google_analytics google_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.google_analytics
    ADD CONSTRAINT google_analytics_pkey PRIMARY KEY (id);


--
-- Name: interactions interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT interactions_pkey PRIMARY KEY (id);


--
-- Name: market_benchmarking market_benchmarking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_benchmarking
    ADD CONSTRAINT market_benchmarking_pkey PRIMARY KEY (id);


--
-- Name: model_runs model_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_runs
    ADD CONSTRAINT model_runs_pkey PRIMARY KEY (id);


--
-- Name: policy_details policy_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_details
    ADD CONSTRAINT policy_details_pkey PRIMARY KEY (id);


--
-- Name: policy_details policy_details_policy_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_details
    ADD CONSTRAINT policy_details_policy_id_unique UNIQUE (policy_id);


--
-- Name: product_benchmarking product_benchmarking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_benchmarking
    ADD CONSTRAINT product_benchmarking_pkey PRIMARY KEY (id);


--
-- Name: renewal_window_tracking renewal_window_tracking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.renewal_window_tracking
    ADD CONSTRAINT renewal_window_tracking_pkey PRIMARY KEY (id);


--
-- Name: interactions interactions_customer_id_customers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interactions
    ADD CONSTRAINT interactions_customer_id_customers_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: renewal_window_tracking renewal_window_tracking_customer_id_customers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.renewal_window_tracking
    ADD CONSTRAINT renewal_window_tracking_customer_id_customers_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- PostgreSQL database dump complete
--

\unrestrict egBHtDeHq2ddkA5L0zXDrbxEVLgKC5c7qPYJozH5e1QE8RIE3O529IaVwD1nGoH

