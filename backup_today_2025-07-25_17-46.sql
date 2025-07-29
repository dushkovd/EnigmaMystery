SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', '57956ad1-44af-48e4-87a4-f515fcf687d6', '{"action":"user_confirmation_requested","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 09:30:22.386697+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b78e9ef3-3e58-4833-bf14-115cac4bbefb', '{"action":"user_signedup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"team"}', '2025-06-10 09:31:02.551054+00', ''),
	('00000000-0000-0000-0000-000000000000', '7fa5f283-2c5d-4434-9676-5a4baab16eaa', '{"action":"logout","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-10 09:31:15.301521+00', ''),
	('00000000-0000-0000-0000-000000000000', '3fd748f4-dbb0-4595-8988-59ef1f88564a', '{"action":"login","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-10 09:31:21.005985+00', ''),
	('00000000-0000-0000-0000-000000000000', '588bcde6-1f84-4ff0-b5ae-514708e30e32', '{"action":"logout","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-10 09:31:24.918534+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bdb88da2-111c-4684-8aad-6f19346d3053', '{"action":"user_confirmation_requested","actor_id":"07ba4a45-e71c-4499-8366-ef239350a2a9","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 14:13:31.769515+00', ''),
	('00000000-0000-0000-0000-000000000000', '9aa320aa-e77d-400b-954f-266079c0a847', '{"action":"user_confirmation_requested","actor_id":"07ba4a45-e71c-4499-8366-ef239350a2a9","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 14:15:27.802783+00', ''),
	('00000000-0000-0000-0000-000000000000', '9a78cdb1-4d12-4db7-8a85-92abc9256f85', '{"action":"user_confirmation_requested","actor_id":"07ba4a45-e71c-4499-8366-ef239350a2a9","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 14:46:10.714166+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cdb77f94-b4f9-48f6-9372-49668e860099', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 14:52:15.509475+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d2a5e49-3a8b-4915-863a-cb23f00b2671', '{"action":"user_signedup","actor_id":"07ba4a45-e71c-4499-8366-ef239350a2a9","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"team"}', '2025-06-10 14:53:06.366525+00', ''),
	('00000000-0000-0000-0000-000000000000', '23b2693d-ebfd-4576-981a-15ac9b1bc939', '{"action":"user_confirmation_requested","actor_id":"b77eb296-aac0-4be4-8eee-2d3ab9ffe238","actor_username":"speechsaver@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 14:56:33.82204+00', ''),
	('00000000-0000-0000-0000-000000000000', '5f044188-acef-4e1a-9b7e-e5bc50e8e421', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 17:32:37.364913+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e61d9a22-fde4-4d0d-a487-5537add549bc', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 17:41:12.868794+00', ''),
	('00000000-0000-0000-0000-000000000000', '9a0831cb-09c5-4e54-8b33-6f249492dd08', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-10 17:44:53.762719+00', ''),
	('00000000-0000-0000-0000-000000000000', '3db7fddc-825b-4d4b-8083-e6dcbeebc24a', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 11:45:44.981456+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ba36d145-2478-4fd2-8292-c01773256460', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 11:51:07.315115+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ebdc1070-efe0-44c2-9fe9-c88d684a19d3', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 11:54:10.24614+00', ''),
	('00000000-0000-0000-0000-000000000000', '340804e2-ddc4-4f3d-9fa3-94a536118490', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 11:59:06.370818+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dcda1dc7-9bcf-4de1-b85f-6e693c59e454', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 12:45:35.799614+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f0e95b1-179b-4db1-94d4-a9fb27ef73b9', '{"action":"login","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 12:48:33.172171+00', ''),
	('00000000-0000-0000-0000-000000000000', '0349a6a2-9390-496b-832b-2aee8dd726da', '{"action":"logout","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-11 12:48:49.477368+00', ''),
	('00000000-0000-0000-0000-000000000000', '9c7cf859-ec46-49f7-a13a-1598dd5d023a', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 12:49:04.023481+00', ''),
	('00000000-0000-0000-0000-000000000000', '9956e6fa-6f52-4274-b93f-78be43542d85', '{"action":"login","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 12:51:59.253572+00', ''),
	('00000000-0000-0000-0000-000000000000', '2ded474d-5285-4f76-8841-c1199f051543', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 12:54:00.07572+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a95f3ff0-9548-4ae6-a63e-b1ca40b7f898', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 12:56:47.752155+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e079365d-7053-4ecf-a3d8-1105a5ee2e2e', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 12:59:23.431572+00', ''),
	('00000000-0000-0000-0000-000000000000', '0ec4f57a-f622-4832-9531-82433cb6621a', '{"action":"login","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 13:01:42.394896+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b1810ab1-d7af-4fe3-b7cc-83dd5dcc3673', '{"action":"login","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 13:42:43.48759+00', ''),
	('00000000-0000-0000-0000-000000000000', '6e4273b6-451a-4d9e-b18b-21700a73bc50', '{"action":"logout","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-11 13:43:00.920491+00', ''),
	('00000000-0000-0000-0000-000000000000', '03b98900-65b3-4026-b71c-d089e6371863', '{"action":"user_confirmation_requested","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 13:43:33.436312+00', ''),
	('00000000-0000-0000-0000-000000000000', '1e1a1c6f-8e25-4753-a1a5-2b8555b4ad37', '{"action":"user_signedup","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"team"}', '2025-06-11 13:49:06.77404+00', ''),
	('00000000-0000-0000-0000-000000000000', 'caed7811-c52d-4680-9b79-7d89617f692b', '{"action":"login","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 13:52:34.985179+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ac2f895a-6223-4c2e-a839-a61a08ffc5ae', '{"action":"login","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 13:55:10.391674+00', ''),
	('00000000-0000-0000-0000-000000000000', '85f308d1-cd8d-493c-b29f-f924b98f5417', '{"action":"logout","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-11 14:02:37.765469+00', ''),
	('00000000-0000-0000-0000-000000000000', 'af6b263a-1f6e-483e-93e4-599a59a64902', '{"action":"login","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 14:02:45.973199+00', ''),
	('00000000-0000-0000-0000-000000000000', '9650a1bd-b692-457d-9e63-67c8325d6f7e', '{"action":"token_refreshed","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-11 15:02:19.444886+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd02d76d2-5646-490d-884e-2c707cc6189c', '{"action":"token_revoked","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-11 15:02:19.446571+00', ''),
	('00000000-0000-0000-0000-000000000000', '05f116db-15f8-43a5-9a1a-7ffa08e218e4', '{"action":"logout","actor_id":"d34665c7-ff2c-4463-b71c-a824e0eea077","actor_username":"djlabs93@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-11 15:20:35.784406+00', ''),
	('00000000-0000-0000-0000-000000000000', 'df8dc507-ea93-4a3a-8ebc-9d9f29b2a828', '{"action":"user_repeated_signup","actor_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 15:20:52.193742+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd27f5ff7-8630-4a98-b0c4-7d8a0fe25bd2', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"dushkovd@gmail.com","user_id":"b8bbf9c3-4fd4-4471-a06d-10a7e88bc462","user_phone":""}}', '2025-06-11 15:30:09.698551+00', ''),
	('00000000-0000-0000-0000-000000000000', 'afff5698-6731-4d05-911d-28d18f05c690', '{"action":"user_confirmation_requested","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 15:31:40.802221+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f123ee85-fbea-49c7-9db5-277c6763e169', '{"action":"user_confirmation_requested","actor_id":"188243b0-6355-4eb2-af0a-44f5ee9b242b","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 15:34:15.087942+00', ''),
	('00000000-0000-0000-0000-000000000000', '6c7bb4f2-f8ea-4b22-8ee8-e6c6673cd7dd', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"darkdevil115@abv.bg","user_id":"188243b0-6355-4eb2-af0a-44f5ee9b242b","user_phone":""}}', '2025-06-11 15:43:14.305641+00', ''),
	('00000000-0000-0000-0000-000000000000', '92b19c18-460d-423c-9273-c2f3df1e2985', '{"action":"user_confirmation_requested","actor_id":"4b99f9e4-a30a-438a-ad26-bd550f0acdd4","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-11 15:44:04.378963+00', ''),
	('00000000-0000-0000-0000-000000000000', '2f8c9a25-569b-4580-8334-67b654a96f2a', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"darkdevil115@abv.bg","user_id":"4b99f9e4-a30a-438a-ad26-bd550f0acdd4","user_phone":""}}', '2025-06-11 16:07:25.231081+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd9a0ad3f-6a6a-4afc-b6c0-cc64415782b2', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"darkdevil15@abv.bg","user_id":"07ba4a45-e71c-4499-8366-ef239350a2a9","user_phone":""}}', '2025-06-11 16:07:58.287459+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fad763df-1579-4c03-a786-ec3e4da133cc', '{"action":"user_signedup","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-11 16:08:27.103949+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ca4e5886-7448-48c5-85e2-bfe6948466fc', '{"action":"login","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 16:08:27.107244+00', ''),
	('00000000-0000-0000-0000-000000000000', '90b5af82-3250-4f49-8114-a0bc4f489cd6', '{"action":"logout","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-11 16:08:53.225442+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc54252c-e070-4a49-8dca-54033b62d881', '{"action":"user_signedup","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-11 16:09:25.136934+00', ''),
	('00000000-0000-0000-0000-000000000000', '03a59f7b-4f7a-4823-a437-c14ccea6b7a1', '{"action":"login","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 16:09:25.140646+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ad0a9b45-c438-4ae7-b816-7eac6f676d96', '{"action":"logout","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-11 16:57:16.146239+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bae69ef1-2fcd-44d4-bd63-60e1fc5f8cb0', '{"action":"login","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-11 16:57:34.468277+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f7d2a722-5017-422a-91df-0cc88ad56f29', '{"action":"token_refreshed","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 07:28:06.600062+00', ''),
	('00000000-0000-0000-0000-000000000000', '43d21b09-ca16-44d3-9bc7-ad1488c1d8cd', '{"action":"token_revoked","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 07:28:06.607755+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c53923eb-0ca5-46f9-8bb2-0005e72c9bca', '{"action":"token_refreshed","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 08:39:44.567405+00', ''),
	('00000000-0000-0000-0000-000000000000', '028abec8-d280-4d6f-a216-292c20a987e0', '{"action":"token_revoked","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 08:39:44.572979+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e03048ef-a411-46c7-bb6e-90268c57e23d', '{"action":"logout","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-12 08:49:54.24725+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd6cd58b0-96cf-49bb-94fa-80a747ae039e', '{"action":"login","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-12 08:50:04.004767+00', ''),
	('00000000-0000-0000-0000-000000000000', '633f4a60-62b3-4234-aa80-ff44ddf8acd1', '{"action":"logout","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-12 08:50:14.265506+00', ''),
	('00000000-0000-0000-0000-000000000000', '34177c8a-bdd3-4cb2-9a68-8613c4a6a038', '{"action":"login","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-12 08:50:23.367269+00', ''),
	('00000000-0000-0000-0000-000000000000', '955be6fb-cac8-44db-baeb-218b2ec1fe04', '{"action":"token_refreshed","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 10:22:13.696553+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a24e1958-db24-4906-8e52-b69b0512f3ec', '{"action":"token_revoked","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 10:22:13.697919+00', ''),
	('00000000-0000-0000-0000-000000000000', '2dbfdcef-a66b-4373-a8dc-b5d33965bfc6', '{"action":"user_repeated_signup","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-12 11:22:06.76532+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd88ecd37-a321-42b9-ae99-98a7fa401d07', '{"action":"login","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-12 11:22:23.899649+00', ''),
	('00000000-0000-0000-0000-000000000000', 'be03a964-4ae3-4df2-935e-1c97caac7d0f', '{"action":"token_refreshed","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 11:30:42.704594+00', ''),
	('00000000-0000-0000-0000-000000000000', '1eec9f15-1e6f-4485-8099-d3b26063cec4', '{"action":"token_revoked","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 11:30:42.706275+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f194ceed-c3f9-4425-ac76-85a441d0d089', '{"action":"token_refreshed","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 17:55:59.525579+00', ''),
	('00000000-0000-0000-0000-000000000000', '7c41c5d2-7d57-4e80-ad4c-a85d0d24745f', '{"action":"token_revoked","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-12 17:55:59.531012+00', ''),
	('00000000-0000-0000-0000-000000000000', '8f94f33a-2f70-4281-a5d9-b27e67aa0120', '{"action":"token_refreshed","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-13 14:24:31.387948+00', ''),
	('00000000-0000-0000-0000-000000000000', '09a9cf37-a9c9-42e4-8166-9df96b623310', '{"action":"token_revoked","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-13 14:24:31.395066+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f3398650-8338-407d-a9c4-4b5b2fb57834', '{"action":"token_refreshed","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-13 15:26:45.737748+00', ''),
	('00000000-0000-0000-0000-000000000000', '4db04ce4-a502-4a02-a65e-27857764a060', '{"action":"token_revoked","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-13 15:26:45.739771+00', ''),
	('00000000-0000-0000-0000-000000000000', '6c434ef9-0844-48ee-a6cf-4027c878dd1c', '{"action":"logout","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-13 15:43:53.838493+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b7588220-d7e5-4861-9278-91e162a4648c', '{"action":"user_signedup","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-13 15:57:37.683687+00', ''),
	('00000000-0000-0000-0000-000000000000', '3951507e-67ca-4bcd-be8b-4d1d651fda72', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-13 15:57:37.704925+00', ''),
	('00000000-0000-0000-0000-000000000000', '0d65cb1b-d098-4d36-9240-73fc2ebead53', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-14 05:55:38.43592+00', ''),
	('00000000-0000-0000-0000-000000000000', '1f89e43d-54dc-4289-bda2-36e9da0481f2', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-14 05:55:38.446398+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb0d7430-c1c3-434c-bf84-b74ce86c8ba3', '{"action":"logout","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-14 05:55:52.061381+00', ''),
	('00000000-0000-0000-0000-000000000000', '85c559db-fe22-4d7d-8d56-3cc01c548da1', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-15 19:45:54.605516+00', ''),
	('00000000-0000-0000-0000-000000000000', '1910e0da-36d9-4d77-858d-d9650b811c39', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 11:49:26.833384+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f8f09beb-7ba9-4dfd-ab49-d79bc4b0c825', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 11:49:26.846622+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a4eb7098-fa85-4d61-a506-93d363523ab5', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 12:49:36.15929+00', ''),
	('00000000-0000-0000-0000-000000000000', '808f57bf-d010-49a8-bfc3-b5a585c9d674', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 12:49:36.172934+00', ''),
	('00000000-0000-0000-0000-000000000000', '55db3632-6943-4570-84a1-f2b7a5add18d', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 14:14:31.60022+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ace20366-5166-4f94-94cf-40496b60f66c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 14:14:31.606028+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bf8f03f7-a3e4-4e0e-8693-8f546ddbaebb', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 15:17:42.917692+00', ''),
	('00000000-0000-0000-0000-000000000000', '8bd68628-44d1-4548-970b-0152e8538645', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-16 15:17:42.923666+00', ''),
	('00000000-0000-0000-0000-000000000000', '43401dbe-dfc5-465d-9625-f7cdff64c10c', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 08:21:25.304912+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd3c387f3-1e8d-4ab8-8a7f-71cca643e847', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 08:21:25.313724+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e40d4812-ff6a-4426-a9e9-f4fb1ff67bbb', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 12:06:17.640354+00', ''),
	('00000000-0000-0000-0000-000000000000', '27d3d64f-0c3d-455b-a901-7d82be79dbc5', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 12:06:17.643662+00', ''),
	('00000000-0000-0000-0000-000000000000', '1b300968-e518-4b03-b9fc-7e4cd149f1ea', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 13:27:06.016039+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a352aba5-8d22-4147-8240-77da28970e62', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 13:27:06.018284+00', ''),
	('00000000-0000-0000-0000-000000000000', '05ab9db5-b062-4b76-9b30-8c25eb597763', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 14:33:02.78557+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dbd9d78e-a183-4206-abfd-c3ec12bc7e19', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 14:33:02.78977+00', ''),
	('00000000-0000-0000-0000-000000000000', '5eff0545-d099-4b76-b262-8693e5ab0b8b', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 15:31:14.123213+00', ''),
	('00000000-0000-0000-0000-000000000000', '19eba275-337e-4c15-834f-071d62969f31', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-17 15:31:14.125702+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a7e2ca21-1b44-4d51-843a-40a8ae3625ba', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 06:31:08.833211+00', ''),
	('00000000-0000-0000-0000-000000000000', '363b0f8a-7fc8-4c6d-be6d-e0ac2bd096cc', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 06:31:08.842742+00', ''),
	('00000000-0000-0000-0000-000000000000', '0cb9caa7-8f97-414f-86e2-85f621f4bc61', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 07:29:37.960527+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee561d16-add5-4358-b116-adb162dd9ab8', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 07:29:37.962257+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b2ab1174-0d4b-4a56-bf6c-f0fd9b89b801', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 11:39:09.300357+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e3252ee4-bba3-40e8-bf29-55e835f1de3c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 11:39:09.305752+00', ''),
	('00000000-0000-0000-0000-000000000000', 'efa9fa0b-8153-41ad-b0a7-315d293eb0db', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 13:26:08.067768+00', ''),
	('00000000-0000-0000-0000-000000000000', '9695efc7-3bd1-45d8-bc2d-39c9a546a9ed', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 13:26:08.069317+00', ''),
	('00000000-0000-0000-0000-000000000000', '28a841d3-0402-4a26-9a82-ab9d06f8729f', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 14:25:03.475671+00', ''),
	('00000000-0000-0000-0000-000000000000', '0f3e6658-09d7-4833-a0b4-344a78f39d74', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 14:25:03.477532+00', ''),
	('00000000-0000-0000-0000-000000000000', '4fd146d1-d64f-43d4-9ddb-5f670f8e6bc5', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 15:29:09.771827+00', ''),
	('00000000-0000-0000-0000-000000000000', '6f8715f5-ca01-466d-8725-5308bf99d66c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 15:29:09.773735+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a3d8fa2f-60aa-4d28-a2e2-e1f0b1b6abd4', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 16:32:22.013754+00', ''),
	('00000000-0000-0000-0000-000000000000', 'da693004-0d50-4099-b992-58952ebc49aa', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-18 16:32:22.01574+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb0592cf-9613-4316-9c2e-7cb34abed703', '{"action":"user_repeated_signup","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-18 16:50:24.136078+00', ''),
	('00000000-0000-0000-0000-000000000000', '99ac968e-f908-4d1b-8b3f-fb2d3785eb62', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-18 16:50:30.580654+00', ''),
	('00000000-0000-0000-0000-000000000000', '87c9d963-4973-4322-b5f5-00552dc313d7', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-18 16:57:20.488047+00', ''),
	('00000000-0000-0000-0000-000000000000', '0dce8bae-2a02-485f-87f7-4d86bd2474a5', '{"action":"user_signedup","actor_id":"bee45fd2-1445-4d8e-b8fc-d5c74c256b39","actor_username":"emkal@abv.bg","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-19 09:10:22.419432+00', ''),
	('00000000-0000-0000-0000-000000000000', '68002722-1e8a-4d73-8c08-5d4b66031ec2', '{"action":"login","actor_id":"bee45fd2-1445-4d8e-b8fc-d5c74c256b39","actor_username":"emkal@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-19 09:10:22.433089+00', ''),
	('00000000-0000-0000-0000-000000000000', '2fa67c17-68cf-4022-966d-d7ba0f2821d4', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 09:30:31.715185+00', ''),
	('00000000-0000-0000-0000-000000000000', '1ac2aeba-ffb4-4373-b2f2-a7aec219034e', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 09:30:31.71847+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e770bb43-a263-4769-bf10-afb48d2a2f28', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 10:34:59.773351+00', ''),
	('00000000-0000-0000-0000-000000000000', '4fee71ae-eaa6-4b82-aa84-6afe8ad7601c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 10:34:59.77532+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e5a9a0b-5b54-4121-b70a-7ce35da11196', '{"action":"token_refreshed","actor_id":"bee45fd2-1445-4d8e-b8fc-d5c74c256b39","actor_username":"emkal@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-19 10:35:41.369746+00', ''),
	('00000000-0000-0000-0000-000000000000', '17ddb551-0316-4f8f-9488-6336debc3560', '{"action":"token_revoked","actor_id":"bee45fd2-1445-4d8e-b8fc-d5c74c256b39","actor_username":"emkal@abv.bg","actor_via_sso":false,"log_type":"token"}', '2025-06-19 10:35:41.370316+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cb8738e8-5cd0-4757-b708-8be0f177793e', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 11:36:39.470789+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b667ef5b-0042-42fd-a385-7e245845e0cd', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 11:36:39.474711+00', ''),
	('00000000-0000-0000-0000-000000000000', '51365728-3ed7-491a-b0b5-e516ba9a3a9d', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 11:36:45.015475+00', ''),
	('00000000-0000-0000-0000-000000000000', '1475f269-d670-44ad-a936-95a28f61c553', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 11:36:45.016019+00', ''),
	('00000000-0000-0000-0000-000000000000', '8fc246a2-16cc-4b0d-9eec-3c916c6ed761', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 11:42:48.165285+00', ''),
	('00000000-0000-0000-0000-000000000000', '9be21df4-0e12-44c2-8bf0-a79058103322', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 11:42:48.167098+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f5cebb30-eeae-40c8-a3aa-5273f15bb27c', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 12:56:30.781652+00', ''),
	('00000000-0000-0000-0000-000000000000', '7d5c5a59-a2c4-4c0e-8bf6-74d1542296ec', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 12:56:30.788241+00', ''),
	('00000000-0000-0000-0000-000000000000', '0c049451-7bc4-41f9-9bd7-4b5a101d9149', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 13:56:32.126507+00', ''),
	('00000000-0000-0000-0000-000000000000', '32e0132c-fde0-45f7-9c83-921f0efa37f8', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 13:56:32.129354+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a713c2f4-6527-42cc-9c9b-62bb247fa158', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 15:03:53.118178+00', ''),
	('00000000-0000-0000-0000-000000000000', '52383b80-071c-4840-adf1-1600d8810421', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 15:03:53.121383+00', ''),
	('00000000-0000-0000-0000-000000000000', '963ecb35-a1c9-4f3a-a888-b413f9ade7d3', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 15:05:22.204799+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f35cd2e8-0102-4879-aba7-a7a9d093b886', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 15:05:22.205576+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a4979b3b-5d5a-45a2-89e4-8bcd109d6c57', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 16:14:35.550769+00', ''),
	('00000000-0000-0000-0000-000000000000', '3042cd0b-4511-40ad-b383-79964becd2ce', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 16:14:35.552569+00', ''),
	('00000000-0000-0000-0000-000000000000', '09cba899-31ec-4a7c-bb11-9f503779812b', '{"action":"logout","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-19 16:24:14.673783+00', ''),
	('00000000-0000-0000-0000-000000000000', '1927fdb9-78d6-4e56-acec-02cfb322a44e', '{"action":"login","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-19 16:24:25.84695+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ebb3a3b9-92d1-4c4d-89d0-3611402dfbd2', '{"action":"logout","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-19 16:24:31.857148+00', ''),
	('00000000-0000-0000-0000-000000000000', '7d2dacfd-8f0d-478e-b3a9-cf554636c313', '{"action":"login","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-19 16:24:38.499132+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e257d5ba-ced3-4c22-8cd5-d3fdce332a4a', '{"action":"logout","actor_id":"1799495b-666e-4163-9284-db99463e4bb7","actor_username":"darkdevil115@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-06-19 16:24:45.394909+00', ''),
	('00000000-0000-0000-0000-000000000000', '3ecb4828-f473-461a-ba82-fabcc959f22d', '{"action":"user_signedup","actor_id":"96fc2b71-1dc8-41ec-84bb-5adfcb151da2","actor_username":"dushkovddushkovd@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-19 16:26:07.199344+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5cab980-5076-47b7-880b-7ec53b4972e8', '{"action":"login","actor_id":"96fc2b71-1dc8-41ec-84bb-5adfcb151da2","actor_username":"dushkovddushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-19 16:26:07.205742+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd90900d-b0a4-4ecf-b047-bb7ec0bfd7d2', '{"action":"logout","actor_id":"96fc2b71-1dc8-41ec-84bb-5adfcb151da2","actor_username":"dushkovddushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-19 16:56:50.51267+00', ''),
	('00000000-0000-0000-0000-000000000000', '92908a0a-1799-44ba-9b06-c9cbea39a1ae', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-19 16:56:56.499042+00', ''),
	('00000000-0000-0000-0000-000000000000', '3eb3f49a-2172-44e3-ab6b-ad006c4b328f', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 19:48:15.658497+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f530fdb2-101d-4f2f-9b4b-a25b57e361e9', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 19:48:15.661849+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cb8e31a0-0840-467f-bbde-dfb90e5804f7', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 21:13:51.13083+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd679a2ea-5e68-4dd5-a339-b26deffa632e', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-19 21:13:51.133295+00', ''),
	('00000000-0000-0000-0000-000000000000', '66bbbc2a-34d9-4d1a-83ee-d545adbbcaee', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 09:37:05.246291+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e309ed29-154c-4368-96e2-f27fd141d048', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 09:37:05.25605+00', ''),
	('00000000-0000-0000-0000-000000000000', '777a71a6-6da2-4f57-9761-05e1b84aa786', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 10:35:18.014492+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5810f3c-378c-4f75-be9c-74ee0a14c747', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 10:35:18.020487+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e974a91-7f8c-4444-9a50-e85d1b3469e3', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 11:46:40.247827+00', ''),
	('00000000-0000-0000-0000-000000000000', '70638109-cfac-48a1-9c46-0148594b5697', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 11:46:40.25275+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b31e002c-9808-4721-a986-5c2a78edd46a', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 13:01:55.982585+00', ''),
	('00000000-0000-0000-0000-000000000000', '5bba5483-1ade-4c14-a09b-29f35e6b3fff', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 13:01:55.987709+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b1e5d2eb-c582-4124-83dd-cfe04e8fbe98', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 14:07:41.929222+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bd65df9c-d74a-43ff-8ded-c2db7b25f6ee', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 14:07:41.934171+00', ''),
	('00000000-0000-0000-0000-000000000000', '7005fd69-907e-4a3f-9f09-b430db195e0c', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 15:08:48.293763+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e00f179-86a0-4afe-bd6f-e4d7235d8a5c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 15:08:48.296941+00', ''),
	('00000000-0000-0000-0000-000000000000', '95b8b1eb-bd6d-4625-8f5d-e75abcd230f1', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 18:11:05.291255+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f83a37aa-57a7-4410-a5d0-8ce0877ab202', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-20 18:11:05.304368+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b0bb63db-1f29-4fe8-ae23-fc83ad326e2e', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 15:36:18.593576+00', ''),
	('00000000-0000-0000-0000-000000000000', '3e042871-1c17-4b19-9d17-67296c7105f1', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 15:36:18.610505+00', ''),
	('00000000-0000-0000-0000-000000000000', '31e98a4a-0900-4133-a2c0-72917f6e2572', '{"action":"user_signedup","actor_id":"64c3fd45-7c2f-466e-bc4c-c66aab216979","actor_username":"ivan.markov13@yahoo.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-06-22 16:09:36.641231+00', ''),
	('00000000-0000-0000-0000-000000000000', '2d7bb0a9-9d51-4c3d-bf9c-bc37b8eb79aa', '{"action":"login","actor_id":"64c3fd45-7c2f-466e-bc4c-c66aab216979","actor_username":"ivan.markov13@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 16:09:36.66618+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a63232b1-8f1e-4317-96d0-313279e3bd77', '{"action":"user_repeated_signup","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-22 16:11:06.573826+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fae4b329-f0be-44db-b547-b0fa81eaf58c', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 16:11:09.809626+00', ''),
	('00000000-0000-0000-0000-000000000000', '6680f241-b497-414c-a053-8ba01bf41271', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-23 06:58:26.600692+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f387a8ba-f808-44d7-81a5-3c11ffeaf96d', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 07:00:16.542381+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b15620d1-bea2-4734-9cbe-0235b89c4ed0', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 07:00:16.544534+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bed68645-2c8a-42cd-99d7-272eff65d057', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 08:06:03.247482+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c31606f2-858d-4ba6-bbe2-a5b7e2f10da1', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 08:06:03.248804+00', ''),
	('00000000-0000-0000-0000-000000000000', '250cd524-3cbe-43a1-8094-c428f0e1d9e4', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 11:40:26.558135+00', ''),
	('00000000-0000-0000-0000-000000000000', '05c1f36a-c43c-4e9a-a1a0-6cdb4b89b47c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 11:40:26.57191+00', ''),
	('00000000-0000-0000-0000-000000000000', '1034560e-4e06-40dc-a11d-1ec2f82b36a4', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-25 14:53:10.41816+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5fc4256-d36a-44b2-9db8-132c604e256e', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-25 14:53:10.431874+00', ''),
	('00000000-0000-0000-0000-000000000000', '44ec33ab-08f0-4392-8bcf-4a4987524915', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-08 13:11:56.610219+00', ''),
	('00000000-0000-0000-0000-000000000000', '48d4e2b8-0e8c-427d-b97a-734c18aba026', '{"action":"logout","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-08 13:15:38.075044+00', ''),
	('00000000-0000-0000-0000-000000000000', '528030c6-a41d-4366-8ac5-d0ce089f3402', '{"action":"user_signedup","actor_id":"05b02cac-a6bb-445d-ab72-d49282960440","actor_username":"hddobrev@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-08 19:30:53.832932+00', ''),
	('00000000-0000-0000-0000-000000000000', '17c88786-f389-4268-b176-489692d9c347', '{"action":"login","actor_id":"05b02cac-a6bb-445d-ab72-d49282960440","actor_username":"hddobrev@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-08 19:30:53.83966+00', ''),
	('00000000-0000-0000-0000-000000000000', '50678e3a-7fc2-4010-a727-1fc0ce5c5859', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-08 20:24:12.320978+00', ''),
	('00000000-0000-0000-0000-000000000000', '9d5df98c-0c50-474f-9292-8dc26f4047d9', '{"action":"token_refreshed","actor_id":"05b02cac-a6bb-445d-ab72-d49282960440","actor_username":"hddobrev@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-08 20:30:36.146131+00', ''),
	('00000000-0000-0000-0000-000000000000', '2070bf80-82bc-46ad-9c5a-e921ca015857', '{"action":"token_revoked","actor_id":"05b02cac-a6bb-445d-ab72-d49282960440","actor_username":"hddobrev@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-08 20:30:36.148272+00', ''),
	('00000000-0000-0000-0000-000000000000', '88d1ae96-b9f3-4881-a062-d488b48b0e9c', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-09 13:17:23.712446+00', ''),
	('00000000-0000-0000-0000-000000000000', '8df6a315-3597-46b3-b701-81c6c0e9215d', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-09 17:13:21.443307+00', ''),
	('00000000-0000-0000-0000-000000000000', '8ad5bcbf-971c-40e9-a0d4-cc977d893729', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-09 17:13:21.444905+00', ''),
	('00000000-0000-0000-0000-000000000000', '30ed06c2-f4e5-4a96-8b65-cab195c78d1a', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-11 14:46:17.969897+00', ''),
	('00000000-0000-0000-0000-000000000000', '5b11aec2-bbc6-4146-b36b-3874f5e0738c', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-11 15:08:26.799984+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f0a42096-0f84-4dd8-bfdd-edc5240942d3', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 15:48:07.468125+00', ''),
	('00000000-0000-0000-0000-000000000000', '509b7c26-4e36-4937-b4b6-e2fe2f25fa58', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 15:48:07.483074+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c631d3be-7211-4fdb-9ac9-8d86b424f0f5', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 15:58:39.838774+00', ''),
	('00000000-0000-0000-0000-000000000000', '7088c698-d207-42f7-8550-c7e58819daa9', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 15:58:39.840945+00', ''),
	('00000000-0000-0000-0000-000000000000', '137b9a38-7193-4a43-a56c-bdb9512cb5c3', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-11 16:04:32.194463+00', ''),
	('00000000-0000-0000-0000-000000000000', '536f5800-9cde-4690-8f20-8f95ebe1275c', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 16:06:56.593676+00', ''),
	('00000000-0000-0000-0000-000000000000', '9a27be09-c3d6-4eb2-9900-689a7298df40', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 16:06:56.59635+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e2b4ac30-902b-4bd4-95e3-db070c87a878', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 16:57:39.778221+00', ''),
	('00000000-0000-0000-0000-000000000000', '34211a37-7b3a-47ff-8aa1-c46a4a7dbf3c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 16:57:39.783076+00', ''),
	('00000000-0000-0000-0000-000000000000', '7a3981f9-b693-4e69-be85-a99fedbfbb50', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 17:56:05.298438+00', ''),
	('00000000-0000-0000-0000-000000000000', '5f1bca16-febb-438b-a5de-e7a88fc6a6be', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-11 17:56:05.301736+00', ''),
	('00000000-0000-0000-0000-000000000000', '7aa17efb-3db1-4d19-a196-566f1ee2dd29', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 11:43:06.266665+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ebbbd546-f0fd-48a6-9cb6-d53d5c26d1b5', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 11:43:06.27434+00', ''),
	('00000000-0000-0000-0000-000000000000', '7180d4ce-3572-4567-850b-c10ebc8cd7c8', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 11:45:35.000239+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b4afdfaf-3be7-478b-8bf3-f79304a22fea', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 11:45:35.001157+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cca6dc87-db18-4773-a5e6-d91d6cdf162d', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 12:47:13.251765+00', ''),
	('00000000-0000-0000-0000-000000000000', '7786d9a4-700b-4d37-9b45-d7f4470f2099', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 12:47:13.261794+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff82621a-1d39-410c-9e57-7fd28bf69b14', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:08:07.740112+00', ''),
	('00000000-0000-0000-0000-000000000000', '592b36b9-ce00-4c28-9536-3806052b7b77', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:08:07.747026+00', ''),
	('00000000-0000-0000-0000-000000000000', '0f56dd9f-853a-47f3-a538-66d76df2186c', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:15:29.732075+00', ''),
	('00000000-0000-0000-0000-000000000000', '7efcdd9f-d09d-405f-a219-a7f282ead885', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:15:29.734465+00', ''),
	('00000000-0000-0000-0000-000000000000', '1af8282e-dfd1-4fbd-b9c3-8b20f70f46fd', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:15:31.183545+00', ''),
	('00000000-0000-0000-0000-000000000000', '4ef626c5-1567-4704-9827-15a61c9928d8', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:15:31.184339+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c2052078-21ac-4767-b20d-083d504ba5ea', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:15:38.276732+00', ''),
	('00000000-0000-0000-0000-000000000000', '70204a5c-21d2-4a83-ad41-0656db83a718', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 14:15:38.277385+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cd8e255d-f7c7-477c-99a2-68c012fcc5ba', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 15:06:27.517182+00', ''),
	('00000000-0000-0000-0000-000000000000', '082bbbf0-cf74-43c4-aab5-1f5692eea47d', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-14 15:06:27.527597+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd44ae06d-85dd-4896-9c5f-9fbad58b6379', '{"action":"logout","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-14 15:14:19.742523+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5a50b69-93a6-4ce5-bfd9-b895375c19aa', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-16 15:14:54.908873+00', ''),
	('00000000-0000-0000-0000-000000000000', '121eeac2-4349-4c91-beef-e8434f2558ee', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-17 07:56:51.013573+00', ''),
	('00000000-0000-0000-0000-000000000000', '5a5b61c7-bdd1-436d-8359-c31f146b2370', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-17 07:56:51.031558+00', ''),
	('00000000-0000-0000-0000-000000000000', '1afd6ea8-4661-4947-b014-f6d587c2d95a', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-17 14:13:15.092215+00', ''),
	('00000000-0000-0000-0000-000000000000', '798f3c07-1392-474f-a5d4-991219988c84', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-17 14:13:15.099014+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dfb4bfd8-529f-4181-a075-71d847d03f10', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 07:07:19.316275+00', ''),
	('00000000-0000-0000-0000-000000000000', '36ca33f2-2b09-47c5-b22f-bdd42c7c8b79', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 07:07:19.325473+00', ''),
	('00000000-0000-0000-0000-000000000000', '7cf74aef-b998-4658-9bd7-8f77a4f629d7', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 08:06:00.620433+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a0ec151a-7278-438f-848e-c819f4d277d9', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 08:06:00.627717+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e7ba5c1-a748-4820-a81d-311ec96d4cfd', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 09:04:02.731335+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f1ea6906-dde9-4f92-8b77-bdab4157970c', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 09:04:02.740053+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e3acb7ec-2788-4ffa-bf36-f8d899f32902', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 10:13:52.718071+00', ''),
	('00000000-0000-0000-0000-000000000000', '518fec38-0589-41a0-830f-d76594937982', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-18 10:13:52.725221+00', ''),
	('00000000-0000-0000-0000-000000000000', '67e1b1b7-004e-490c-b530-76f04d8d26d3', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-22 09:26:47.85826+00', ''),
	('00000000-0000-0000-0000-000000000000', '2950a200-1e59-4d99-ac1a-d0ab1e0773c9', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-22 09:26:47.86891+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a8543f89-d1c3-4cd5-89f8-afe4f2af7ca4', '{"action":"logout","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-22 09:27:17.905882+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c0ab2a8d-74d8-4e87-8a4c-a76ef397ea6e', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-22 14:10:59.651973+00', ''),
	('00000000-0000-0000-0000-000000000000', '9544dd84-95fe-41e2-956a-27d19a0b5d46', '{"action":"token_refreshed","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-23 08:35:52.601338+00', ''),
	('00000000-0000-0000-0000-000000000000', 'edb0fc76-e2b3-4a06-a409-53d0318980b5', '{"action":"token_revoked","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-07-23 08:35:52.610934+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cee3de93-44cf-4e0c-8b31-8dcd90ffed7d', '{"action":"logout","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-23 08:51:52.505186+00', ''),
	('00000000-0000-0000-0000-000000000000', '89df40ed-dff6-417e-a8e3-bfff2bb3b083', '{"action":"login","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-25 13:17:45.135848+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd4f94940-40a3-4763-a463-79beab62921d', '{"action":"logout","actor_id":"c2430400-f839-4258-96c8-3c98c2cb2d21","actor_username":"darkdevil15@abv.bg","actor_via_sso":false,"log_type":"account"}', '2025-07-25 13:18:38.414697+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5c90e20-7c20-4653-af3a-0999fe5f6e01', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-25 13:18:46.04261+00', ''),
	('00000000-0000-0000-0000-000000000000', '5daac1f2-1fca-4843-ab30-c4b1e3767133', '{"action":"login","actor_id":"1547d5f6-6d28-4669-a470-842031db5f96","actor_username":"dushkovd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-25 14:04:49.875645+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '96fc2b71-1dc8-41ec-84bb-5adfcb151da2', 'authenticated', 'authenticated', 'dushkovddushkovd@gmail.com', '$2a$10$FwYoJbIMqn3/q19RlMlzYuOxQ5wGrXy2aeUrLcGJpEqd4mugdK8Gi', '2025-06-19 16:26:07.19984+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-19 16:26:07.206276+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "96fc2b71-1dc8-41ec-84bb-5adfcb151da2", "email": "dushkovddushkovd@gmail.com", "email_verified": true, "phone_verified": false}', NULL, '2025-06-19 16:26:07.179456+00', '2025-06-19 16:26:07.208765+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '64c3fd45-7c2f-466e-bc4c-c66aab216979', 'authenticated', 'authenticated', 'ivan.markov13@yahoo.com', '$2a$10$S3s5/QVjPcXHbbUFjhboJ.hQ1.lBuNYrLL7GVPa5byy0Ol/JCD7n.', '2025-06-22 16:09:36.650188+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-22 16:09:36.666715+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "64c3fd45-7c2f-466e-bc4c-c66aab216979", "email": "ivan.markov13@yahoo.com", "email_verified": true, "phone_verified": false}', NULL, '2025-06-22 16:09:36.558185+00', '2025-06-22 16:09:36.70772+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'b77eb296-aac0-4be4-8eee-2d3ab9ffe238', 'authenticated', 'authenticated', 'speechsaver@gmail.com', '$2a$10$FGyiHlrxs/L.v0382Mezr..6LvQAWuxq7jKLZ3trzSTLciYM.Rhsu', NULL, NULL, 'bf8f15c5fdaeda22fa7c1bfb2321596d546182e03368e013177d5451', '2025-06-10 14:56:33.822665+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"sub": "b77eb296-aac0-4be4-8eee-2d3ab9ffe238", "email": "speechsaver@gmail.com", "email_verified": false, "phone_verified": false}', NULL, '2025-06-10 14:56:33.81575+00', '2025-06-10 14:56:34.783531+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd34665c7-ff2c-4463-b71c-a824e0eea077', 'authenticated', 'authenticated', 'djlabs93@gmail.com', '$2a$10$Cf.SzuWA68OjuUhYHqryNuXgair582yzwEb/jaOHy1Dwm/RoA3Zu6', '2025-06-11 13:49:06.779852+00', NULL, '', '2025-06-11 13:43:33.436829+00', '', NULL, '', '', NULL, '2025-06-11 14:02:45.973884+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "d34665c7-ff2c-4463-b71c-a824e0eea077", "email": "djlabs93@gmail.com", "email_verified": true, "phone_verified": false}', NULL, '2025-06-11 13:43:33.418258+00', '2025-06-11 15:02:19.451988+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'bee45fd2-1445-4d8e-b8fc-d5c74c256b39', 'authenticated', 'authenticated', 'emkal@abv.bg', '$2a$10$CNNYo6K1lvtxKqBT3zg6zeNfHAchs0cSsMCdQVCdfLTNkGuUAxI0C', '2025-06-19 09:10:22.423781+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-19 09:10:22.433595+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "bee45fd2-1445-4d8e-b8fc-d5c74c256b39", "email": "emkal@abv.bg", "email_verified": true, "phone_verified": false}', NULL, '2025-06-19 09:10:22.363907+00', '2025-06-19 10:35:41.37327+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '1799495b-666e-4163-9284-db99463e4bb7', 'authenticated', 'authenticated', 'darkdevil115@abv.bg', '$2a$10$UbUVrrJiL9q5Ux9DKRs2SeuZNDLOBtM2HF9fQ4q5QhDldrIoO.zLC', '2025-06-11 16:09:25.137444+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-19 16:24:38.499818+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "1799495b-666e-4163-9284-db99463e4bb7", "email": "darkdevil115@abv.bg", "email_verified": true, "phone_verified": false}', NULL, '2025-06-11 16:09:25.125226+00', '2025-06-19 16:24:38.501566+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'c2430400-f839-4258-96c8-3c98c2cb2d21', 'authenticated', 'authenticated', 'darkdevil15@abv.bg', '$2a$10$FEWWyLBa2A1tTjCp3T6gAu7uu1Uz5tH5FoH7zePiw9xRq41WQ4Q.6', '2025-06-11 16:08:27.104388+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-25 13:17:45.15071+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "c2430400-f839-4258-96c8-3c98c2cb2d21", "email": "darkdevil15@abv.bg", "email_verified": true, "phone_verified": false}', NULL, '2025-06-11 16:08:27.092484+00', '2025-07-25 13:17:45.174885+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '1547d5f6-6d28-4669-a470-842031db5f96', 'authenticated', 'authenticated', 'dushkovd@gmail.com', '$2a$10$V5kSB/SFrZ8g7MiykjAly.516BIO7YBh1YJ7VFeh/tt66ZwQ.Olhm', '2025-06-13 15:57:37.690208+00', NULL, '', '2025-06-11 15:31:40.804467+00', '', NULL, '', '', NULL, '2025-07-25 14:04:49.880137+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "1547d5f6-6d28-4669-a470-842031db5f96", "email": "dushkovd@gmail.com", "email_verified": true, "phone_verified": false}', NULL, '2025-06-11 15:31:40.791316+00', '2025-07-25 14:04:49.887506+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '05b02cac-a6bb-445d-ab72-d49282960440', 'authenticated', 'authenticated', 'hddobrev@gmail.com', '$2a$10$zq1ZlTsEhfM15SCFmYgtU.T6LpWLZbKEQIF4o.GPmQKVp3aARX3WW', '2025-07-08 19:30:53.833761+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-08 19:30:53.840336+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "05b02cac-a6bb-445d-ab72-d49282960440", "email": "hddobrev@gmail.com", "email_verified": true, "phone_verified": false}', NULL, '2025-07-08 19:30:53.802924+00', '2025-07-08 20:30:36.151805+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('b77eb296-aac0-4be4-8eee-2d3ab9ffe238', 'b77eb296-aac0-4be4-8eee-2d3ab9ffe238', '{"sub": "b77eb296-aac0-4be4-8eee-2d3ab9ffe238", "email": "speechsaver@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-10 14:56:33.819653+00', '2025-06-10 14:56:33.8197+00', '2025-06-10 14:56:33.8197+00', 'a1799daa-f023-48ed-909e-1b7e364c7a03'),
	('d34665c7-ff2c-4463-b71c-a824e0eea077', 'd34665c7-ff2c-4463-b71c-a824e0eea077', '{"sub": "d34665c7-ff2c-4463-b71c-a824e0eea077", "email": "djlabs93@gmail.com", "email_verified": true, "phone_verified": false}', 'email', '2025-06-11 13:43:33.430598+00', '2025-06-11 13:43:33.430647+00', '2025-06-11 13:43:33.430647+00', '3d205b0a-5110-4f6b-9e7e-1f741ebc1254'),
	('1547d5f6-6d28-4669-a470-842031db5f96', '1547d5f6-6d28-4669-a470-842031db5f96', '{"sub": "1547d5f6-6d28-4669-a470-842031db5f96", "email": "dushkovd@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-11 15:31:40.797675+00', '2025-06-11 15:31:40.797726+00', '2025-06-11 15:31:40.797726+00', 'bc2d2918-a314-4788-97c1-571b29f05075'),
	('c2430400-f839-4258-96c8-3c98c2cb2d21', 'c2430400-f839-4258-96c8-3c98c2cb2d21', '{"sub": "c2430400-f839-4258-96c8-3c98c2cb2d21", "email": "darkdevil15@abv.bg", "email_verified": false, "phone_verified": false}', 'email', '2025-06-11 16:08:27.101499+00', '2025-06-11 16:08:27.101564+00', '2025-06-11 16:08:27.101564+00', 'ad51432f-38a5-4add-bf09-162c00ee8683'),
	('1799495b-666e-4163-9284-db99463e4bb7', '1799495b-666e-4163-9284-db99463e4bb7', '{"sub": "1799495b-666e-4163-9284-db99463e4bb7", "email": "darkdevil115@abv.bg", "email_verified": false, "phone_verified": false}', 'email', '2025-06-11 16:09:25.128247+00', '2025-06-11 16:09:25.128294+00', '2025-06-11 16:09:25.128294+00', '5427b770-9afd-453f-8cc7-c709ec4407b9'),
	('bee45fd2-1445-4d8e-b8fc-d5c74c256b39', 'bee45fd2-1445-4d8e-b8fc-d5c74c256b39', '{"sub": "bee45fd2-1445-4d8e-b8fc-d5c74c256b39", "email": "emkal@abv.bg", "email_verified": false, "phone_verified": false}', 'email', '2025-06-19 09:10:22.410269+00', '2025-06-19 09:10:22.410331+00', '2025-06-19 09:10:22.410331+00', '7fd39348-7dfe-4d16-afd2-e965d94a823c'),
	('96fc2b71-1dc8-41ec-84bb-5adfcb151da2', '96fc2b71-1dc8-41ec-84bb-5adfcb151da2', '{"sub": "96fc2b71-1dc8-41ec-84bb-5adfcb151da2", "email": "dushkovddushkovd@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-19 16:26:07.193711+00', '2025-06-19 16:26:07.193768+00', '2025-06-19 16:26:07.193768+00', 'e86d7563-4f9b-440a-aa62-0177404670fc'),
	('64c3fd45-7c2f-466e-bc4c-c66aab216979', '64c3fd45-7c2f-466e-bc4c-c66aab216979', '{"sub": "64c3fd45-7c2f-466e-bc4c-c66aab216979", "email": "ivan.markov13@yahoo.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-22 16:09:36.622547+00', '2025-06-22 16:09:36.623149+00', '2025-06-22 16:09:36.623149+00', 'cc9e3f28-e579-4540-8536-3c5751c8f473'),
	('05b02cac-a6bb-445d-ab72-d49282960440', '05b02cac-a6bb-445d-ab72-d49282960440', '{"sub": "05b02cac-a6bb-445d-ab72-d49282960440", "email": "hddobrev@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-07-08 19:30:53.827876+00', '2025-07-08 19:30:53.82794+00', '2025-07-08 19:30:53.82794+00', '2846fa04-184d-4c3b-8ed9-5cff22bc3a6c');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") VALUES
	('5dec5ae9-e84a-406e-af6b-6998944f7442', '64c3fd45-7c2f-466e-bc4c-c66aab216979', '2025-06-22 16:09:36.666799+00', '2025-06-22 16:09:36.666799+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '172.225.224.82', NULL),
	('67b34598-9d40-43ec-b19b-26db72dd4284', 'bee45fd2-1445-4d8e-b8fc-d5c74c256b39', '2025-06-19 09:10:22.433672+00', '2025-06-19 10:35:41.374209+00', NULL, 'aal1', NULL, '2025-06-19 10:35:41.374133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '130.204.76.72', NULL),
	('0a32ad37-3210-490e-a9f8-ec85083f0bf3', '05b02cac-a6bb-445d-ab72-d49282960440', '2025-07-08 19:30:53.841073+00', '2025-07-08 20:30:36.154069+00', NULL, 'aal1', NULL, '2025-07-08 20:30:36.153983', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '95.43.103.76', NULL),
	('a1557f88-64f8-4332-a51a-a27725bf6789', '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:18:46.043388+00', '2025-07-25 13:18:46.043388+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '46.232.157.146', NULL),
	('484b8def-1bd8-4321-afe7-3b9530fd8628', '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 14:04:49.880239+00', '2025-07-25 14:04:49.880239+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '46.232.157.146', NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('67b34598-9d40-43ec-b19b-26db72dd4284', '2025-06-19 09:10:22.461526+00', '2025-06-19 09:10:22.461526+00', 'password', '3c7d5982-df27-4712-9bc4-b2fd8f89fd92'),
	('5dec5ae9-e84a-406e-af6b-6998944f7442', '2025-06-22 16:09:36.708281+00', '2025-06-22 16:09:36.708281+00', 'password', '0fc9f0da-fd7d-490e-8bb4-ce7971a81e35'),
	('0a32ad37-3210-490e-a9f8-ec85083f0bf3', '2025-07-08 19:30:53.848076+00', '2025-07-08 19:30:53.848076+00', 'password', 'd5283446-63df-4b47-8b1f-10fa35210037'),
	('a1557f88-64f8-4332-a51a-a27725bf6789', '2025-07-25 13:18:46.046686+00', '2025-07-25 13:18:46.046686+00', 'password', '1c6c5330-aec3-4fb6-989f-ae986c9764ed'),
	('484b8def-1bd8-4321-afe7-3b9530fd8628', '2025-07-25 14:04:49.888234+00', '2025-07-25 14:04:49.888234+00', 'password', '43a3c4da-93c4-46be-81d8-57f4c535c484');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") VALUES
	('99635f0d-e2cf-4b1b-bf14-ac93e5d23112', 'b77eb296-aac0-4be4-8eee-2d3ab9ffe238', 'confirmation_token', 'bf8f15c5fdaeda22fa7c1bfb2321596d546182e03368e013177d5451', 'speechsaver@gmail.com', '2025-06-10 14:56:34.785337', '2025-06-10 14:56:34.785337');


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 47, 'cs76cdnlrhty', 'bee45fd2-1445-4d8e-b8fc-d5c74c256b39', true, '2025-06-19 09:10:22.443264+00', '2025-06-19 10:35:41.370787+00', NULL, '67b34598-9d40-43ec-b19b-26db72dd4284'),
	('00000000-0000-0000-0000-000000000000', 50, 'hr5o7z3ajg5m', 'bee45fd2-1445-4d8e-b8fc-d5c74c256b39', false, '2025-06-19 10:35:41.371088+00', '2025-06-19 10:35:41.371088+00', 'cs76cdnlrhty', '67b34598-9d40-43ec-b19b-26db72dd4284'),
	('00000000-0000-0000-0000-000000000000', 73, 'jql7amlwwcyc', '64c3fd45-7c2f-466e-bc4c-c66aab216979', false, '2025-06-22 16:09:36.683443+00', '2025-06-22 16:09:36.683443+00', NULL, '5dec5ae9-e84a-406e-af6b-6998944f7442'),
	('00000000-0000-0000-0000-000000000000', 113, '22wtcuhle2cg', '1547d5f6-6d28-4669-a470-842031db5f96', false, '2025-07-25 13:18:46.044097+00', '2025-07-25 13:18:46.044097+00', NULL, 'a1557f88-64f8-4332-a51a-a27725bf6789'),
	('00000000-0000-0000-0000-000000000000', 114, 'n4hfz6kz2s7v', '1547d5f6-6d28-4669-a470-842031db5f96', false, '2025-07-25 14:04:49.882888+00', '2025-07-25 14:04:49.882888+00', NULL, '484b8def-1bd8-4321-afe7-3b9530fd8628'),
	('00000000-0000-0000-0000-000000000000', 81, '7w7rvm7qgkwq', '05b02cac-a6bb-445d-ab72-d49282960440', true, '2025-07-08 19:30:53.842843+00', '2025-07-08 20:30:36.148838+00', NULL, '0a32ad37-3210-490e-a9f8-ec85083f0bf3'),
	('00000000-0000-0000-0000-000000000000', 83, 'hx326ur3qrjz', '05b02cac-a6bb-445d-ab72-d49282960440', false, '2025-07-08 20:30:36.150544+00', '2025-07-08 20:30:36.150544+00', '7w7rvm7qgkwq', '0a32ad37-3210-490e-a9f8-ec85083f0bf3');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: Games; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Games" ("game_id", "title", "description", "setting", "price", "is_active", "subtitle", "image", "difficulty", "players", "duration", "featured", "title_bg", "subtitle_bg", "description_bg", "difficulty_bg", "victim", "victim_bg", "setting_bg", "image_path") VALUES
	(1, 'Death at the Rosewood Estate', 'Immerse yourself in the glamorous 1920s as you attend a lavish dinner party at the Rosewood Estate. When the wealthy host is found dead, it''s up to you and your fellow guests to solve the mystery before the killer strikes again.
Figure out who had motive, means, and opportunity to poison Harold.', 'A lavish 1920s dinner party at the Rosewood Estate, hosted by the wealthy yet secretive Harold Langston. The occasion? A charity fundraiser… or so it seemed.', 14.99, false, 'A 1920s Dinner Party Murder', NULL, 'Medium', '6-10', '2-3', true, 'Смърт в имението Роузууд', 'Убийство на вечеря от 20-те години', 'Потопете се в 20-те години на миналия век, докато присъствате на разкошна вечеря в имението Роузууд. Богатият домакин е открит мъртъв, а вие и останалите гости трябва да разкриете извършителя, преди убиецът да удари отново.
Открийте кой е имал мотив и възможност да отрови Харолд.', 'Средна', 'Harold Langston', 'Харолд Лангстън', 'Пищна вечеря през 20-те години на миналия век в имението Роузууд, организирана от богатия, но потаен Харолд Лангстън. Поводът? Благотворителна акция за набиране на средства... или поне така изглеждаше.', '1/Rosewood.jpeg'),
	(3, 'Murder on the Orient Express', 'The Orient Express, the most luxurious train in Europe, has been stopped by a snowdrift in the middle of the night. When morning comes, the wealthy Bulgarian industrialist Viktor Petrov is found dead in his locked compartment. With the train stranded and no way for the killer to escape, the murderer must be among the passengers. But who had the motive, means, and opportunity to commit this brutal crime?', '1970s luxury train, Sofia → Paris, stranded in snow', 14.99, true, 'A 1970s Luxury Train Mystery', 'null', 'Hard', '6-10', '1-3 hours', true, 'Убийство в Ориент Експрес', 'Мистерия в луксозен влак от 70-те години на 20-ти век', 'Ориент Експрес, най-луксозният влак в Европа, е спрян от снежен занос в средата на нощта. Когато настъпва сутринта, богатият български индустриалец Виктор Петров е намерен мъртъв в заключеното си купе. При спрян влак и без възможност убиецът да избяга, той трябва да е сред пътниците. Но кой е имал мотив, средства и възможност да извърши това брутално престъпление?', 'Средна', 'Viktor Petrov', 'Виктор Петров', 'Луксозен влак, пътуващ София-Париж през 1970-та, блокиран заради обилен снеговалеж ', '3/Orient_express.jpg'),
	(2, 'Murder on the Midnight Express', 'A powerful aristocrat, Lord Crowthorne, has disappeared. Blood is found in his private cabin, a ceremonial dagger on the floor, and the window open to the icy plains. It appears he was murdered and thrown from the train. Or was he? The goal: uncover what really happened, who is behind it, and why.', '1960s luxury train, Paris → Istanbul', 14.99, false, 'A 1960s Train Mystery', NULL, 'Medium', '6-10', '2-3', false, 'Убийство в Полунощния Експрес', 'Мистерия във влак от 60-те', 'Влиятелен аристократ, лорд Кроуторн, е изчезнал. Кръв е открита в личната му кабина, церемониален кинжал на пода и прозорецът е отворен към ледените полета. Изглежда, че е убит и изхвърлен от влака. Или не? Целта: разкрийте какво наистина се е случило, кой стои зад това и защо.', 'Средна', 'Lord Crowthorne', 'Лорд Кроуторн', 'Луксозен влак от 60-те, пътуващ от Париж към Истанбул.', '2/Midnight_express.jpeg'),
	(4, 'The Last Bachelorette Party', 'What was supposed to be the perfect bachelorette party turned into a night of terror when the hired male dancer, "Diamond" Dave Martinez, was found dead in the VIP lounge. With everyone having secrets and motives, it''s up to the bridal party to uncover who killed the entertainer before the police arrive. Was it jealousy, revenge, or something more sinister?', 'A luxurious penthouse suite in downtown Miami, transformed into the ultimate bachelorette party venue. The night is filled with champagne, dancing, and secrets that some would kill to keep hidden.', 14.99, true, 'A Miami Bachelorette Party Gone Wrong', 'https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Medium', '6-10', '2-3 hours', false, 'Последното моминско парти', 'Моминско парти в Маями, което завършва трагично', 'Моминско парти се превръща в нощ на разпити и подозрения, когато наетият танцьор "Даймънд" Дейв Мартинес е намерен мъртъв във VIP залата. Всички присъстващи на притежават дълбоко пазени тайни, някои от които ще бъдат разкрити в опит да бъде разкрит убиецът, още преди полицията да е пристигнала. Дали става въпрос за ревност, отмъщение или нещо още по-неочаквано?', 'Средна', 'Diamond (Dave Martinez)', 'Даймънд (Дейв Мартинес)', 'Луксозен пентхаус в центъра на Маями, превърнат в перфекното място за моминско парти. Нощта е изпълнена с шампанско, танци и тайни, които някои биха убили, за да запазят скрити.', '4/bachelorette_party.png');


--
-- Data for Name: Game_Variations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Game_Variations" ("variation_id", "game_id", "num_players", "variation_title", "notes", "variation_title_bg", "notes_bg") VALUES
	(1, 1, 8, 'Standard 8-Player Version', 'Includes all 8 characters with their unique secrets and roles', 'Стандартна версия за 8 играчи', 'Включва всички 8 персонажа с техните уникални тайни и роли'),
	(2, 1, 6, 'Compact 6-Player Version', 'A streamlined version with 6 key characters, perfect for smaller groups', 'Компактна версия за 6 играчи', 'Опростена версия с 6 ключови персонажа — перфектна за по-малки групи'),
	(3, 1, 7, 'Extended 7-Player Version', 'Includes 7 key characters, adding the butler for additional intrigue', 'Разширена версия за 7 играчи', 'Включва 7 ключови персонажа, включително иконома за допълнителна интрига'),
	(4, 1, 9, 'Deluxe 9-Player Version', 'Includes all original characters plus an additional guest', 'Делукс версия за 9 играчи', 'Включва всички оригинални персонажи плюс допълнителен гост'),
	(5, 1, 10, 'Complete 10-Player Version', 'The full experience with all characters and additional subplots', 'Пълна версия за 10 играчи', 'Пълното изживяване с всички персонажи и допълнителни сюжетни линии'),
	(6, 2, 10, '10 Players', '-', '10 играчи', '-'),
	(7, 2, 6, '6 Players', 'Compact version with core characters only', '6 играчи', 'Компактна версия само с основните герои'),
	(8, 2, 7, '7 Players', 'Balanced version with key characters', '7 играчи', 'Балансирана версия с ключови герои'),
	(9, 2, 8, '8 Players', 'Extended version with additional suspects', '8 играчи', 'Разширена версия с допълнителни заподозрени'),
	(10, 2, 9, '9 Players', 'Nearly complete version with most characters', '9 играчи', 'Почти пълна версия с повечето герои'),
	(11, 3, 6, '6 Players', 'Core mystery with essential characters', '6 играчи', 'Основна мистерия с основни герои'),
	(12, 3, 7, '7 Players', '-', '7 играчи', '-'),
	(13, 3, 8, '8 Players', '-', '8 играчи', '-'),
	(14, 3, 9, '9 Players', '-', '9 играчи', '-'),
	(15, 3, 10, '10 Players', '-', '10 играчи', '-'),
	(16, 4, 6, '6-Player Version', '-', 'версия за 6 играчи', '-'),
	(17, 4, 7, '7-Player Version', '-', 'версия за 7 играчи', '-'),
	(18, 4, 8, '8-Player Version', '-', 'версия за 8 играчи', '-'),
	(19, 4, 9, '9-Player Version', '-', 'версия за 9 играчи', '-'),
	(20, 4, 10, '10-Player Version', '-', 'версия за 10 играчи', '-');


--
-- Data for Name: Characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Characters" ("character_id", "variation_id", "name", "description", "secret", "name_bg", "description_bg", "secret_bg", "connection", "connection_bg", "circumstances", "circumstances_bg") VALUES
	(1, 1, 'Evelyn Langston', 'The host''s wife', 'Was about to be cut out of the will.', 'Евелин Лангстън', 'Съпругата на домакина', 'Щеше да бъде изключена от завещанието.', NULL, NULL, NULL, NULL),
	(2, 1, 'Dr. Lionel Graves', 'The family physician', 'Prescribed Harold sedatives that could mask poisoning symptoms.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(3, 1, 'Catherine Blake', 'A business associate', 'Forged Harold''s signature on several documents, including a check.', 'Катрин Блейк', 'Бизнес партньор', 'Фалшифицирала е подписа на Харалд върху няколко документа, включително чек.', NULL, NULL, NULL, NULL),
	(4, 1, 'Lord Reginald Ashcroft', 'A wealthy aristocrat', 'Owed Harold a massive gambling debt.', 'Лорд Реджиналд Ашкрофт', 'Богат аристократ', 'Дължи огромен дълг на Харалд от хазарт.', NULL, NULL, NULL, NULL),
	(5, 1, 'Beatrice Langston', 'Harold''s sister', 'Knew Harold planned to marry again and write her out of the will.', 'Беатрис Лангстън', 'Сестрата на Харалд', 'Знаела е, че Харалд възнамерява да се ожени отново и да я изключи от завещанието.', NULL, NULL, NULL, NULL),
	(6, 1, 'Marcus Reed', 'A family friend', 'Had a romantic affair with Evelyn.', 'Маркус Рийд', 'Семеен приятел', 'Имал е романтична връзка с Евелин.', NULL, NULL, NULL, NULL),
	(7, 1, 'James the Butler', 'The estate''s butler', 'Overheard blackmail material and has been eavesdropping for weeks.', 'Джеймс Двореца', 'Икономът на имението', 'Подслушвал е седмици и е чул компрометираща информация.', NULL, NULL, NULL, NULL),
	(8, 1, 'Anna the Maid', 'The estate''s maid', 'Saw someone sneaking into the study the night before the murder.', 'Анна Камериерката', 'Камериерката на имението', 'Видяла е някой да се промъква в кабинета вечерта преди убийството.', NULL, NULL, NULL, NULL),
	(9, 2, 'Evelyn Langston', 'The host''s wife', 'Was about to be cut out of the will.', 'Евелин Лангстън', 'Съпругата на домакина', 'Щеше да бъде изключена от завещанието.', NULL, NULL, NULL, NULL),
	(12, 2, 'Lord Reginald Ashcroft', 'A wealthy aristocrat', 'Owed Harold a massive gambling debt.', 'Лорд Реджиналд Ашкрофт', 'Богат аристократ', 'Дължи огромен дълг на Харалд от хазарт.', NULL, NULL, NULL, NULL),
	(22, 4, 'Evelyn Langston', 'The host''s wife', 'Was about to be cut out of the will.', 'Анна Камериерката', 'Камериерката на имението', 'Видяла е някой да се промъква в кабинета вечерта преди убийството.', NULL, NULL, NULL, NULL),
	(24, 4, 'Catherine Blake', 'A business associate', 'Forged Harold''s signature on several documents, including a check.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(25, 4, 'Lord Reginald Ashcroft', 'A wealthy aristocrat', 'Owed Harold a massive gambling debt.', 'Катрин Блейк', 'Бизнес партньор', 'Фалшифицирала е подписа на Харалд върху няколко документа, включително чек.', NULL, NULL, NULL, NULL),
	(26, 4, 'Beatrice Langston', 'Harold''s sister', 'Knew Harold planned to marry again and write her out of the will.', 'Лорд Реджиналд Ашкрофт', 'Богат аристократ', 'Дължи огромен дълг на Харалд от хазарт.', NULL, NULL, NULL, NULL),
	(27, 4, 'Marcus Reed', 'A family friend', 'Had a romantic affair with Evelyn.', 'Беатрис Лангстън', 'Сестрата на Харалд', 'Знаела е, че Харалд възнамерява да се ожени отново и да я изключи от завещанието.', NULL, NULL, NULL, NULL),
	(28, 4, 'James the Butler', 'The estate''s butler', 'Overheard blackmail material and has been eavesdropping for weeks.', 'Маркус Рийд', 'Семеен приятел', 'Имал е романтична връзка с Евелин.', NULL, NULL, NULL, NULL),
	(29, 4, 'Anna the Maid', 'The estate''s maid', 'Saw someone sneaking into the study the night before the murder.', 'Джеймс Лорд', 'Икономът на имението', 'Подслушвал е седмици и е чул компрометираща информация.', NULL, NULL, NULL, NULL),
	(10, 2, 'Dr. Lionel Graves', 'The family physician', 'Prescribed Harold sedatives that could mask poisoning symptoms.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(11, 2, 'Catherine Blake', 'A business associate', 'Forged Harold''s signature on several documents, including a check.', 'Катрин Блейк', 'Бизнес партньор', 'Фалшифицирала е подписа на Харалд върху няколко документа, включително чек.', NULL, NULL, NULL, NULL),
	(13, 2, 'Beatrice Langston', 'Harold''s sister', 'Knew Harold planned to marry again and write her out of the will.', 'Беатрис Лангстън', 'Сестрата на Харалд', 'Знаела е, че Харалд възнамерява да се ожени отново и да я изключи от завещанието.', NULL, NULL, NULL, NULL),
	(14, 2, 'Marcus Reed', 'A family friend', 'Had a romantic affair with Evelyn.', 'Маркус Рийд', 'Семеен приятел', 'Имал е романтична връзка с Евелин.', NULL, NULL, NULL, NULL),
	(15, 3, 'Evelyn Langston', 'The host''s wife', 'Was about to be cut out of the will.', 'Евелин Лангстън', 'Съпругата на домакина', 'Щеше да бъде изключена от завещанието.', NULL, NULL, NULL, NULL),
	(16, 3, 'Dr. Lionel Graves', 'The family physician', 'Prescribed Harold sedatives that could mask poisoning symptoms.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(17, 3, 'Catherine Blake', 'A business associate', 'Forged Harold''s signature on several documents, including a check.', 'Катрин Блейк', 'Бизнес партньор', 'Фалшифицирала е подписа на Харалд върху няколко документа, включително чек.', NULL, NULL, NULL, NULL),
	(18, 3, 'Lord Reginald Ashcroft', 'A wealthy aristocrat', 'Owed Harold a massive gambling debt.', 'Лорд Реджиналд Ашкрофт', 'Богат аристократ', 'Дължи огромен дълг на Харалд от хазарт.', NULL, NULL, NULL, NULL),
	(19, 3, 'Beatrice Langston', 'Harold''s sister', 'Knew Harold planned to marry again and write her out of the will.', 'Беатрис Лангстън', 'Сестрата на Харалд', 'Знаела е, че Харалд възнамерява да се ожени отново и да я изключи от завещанието.', NULL, NULL, NULL, NULL),
	(20, 3, 'Marcus Reed', 'A family friend', 'Had a romantic affair with Evelyn.', 'Маркус Рийд', 'Семеен приятел', 'Имал е романтична връзка с Евелин.', NULL, NULL, NULL, NULL),
	(21, 3, 'James the Butler', 'The estate''s butler', 'Overheard blackmail material and has been eavesdropping for weeks.', 'Джеймс Двореца', 'Икономът на имението', 'Подслушвал е седмици и е чул компрометираща информация.', NULL, NULL, NULL, NULL),
	(30, 4, 'Lady Victoria Blackwood', 'A society matron', 'Was being blackmailed by Harold about her husband''s gambling debts.', 'Анна Камериерката', 'Камериерката на имението', 'Видяла е някой да се промъква в кабинета вечерта преди убийството.', NULL, NULL, NULL, NULL),
	(31, 5, 'Evelyn Langston', 'The host''s wife', 'Was about to be cut out of the will.', 'Евелин Лангстън', 'Съпругата на домакина', 'Щеше да бъде изключена от завещанието.', NULL, NULL, NULL, NULL),
	(32, 5, 'Dr. Lionel Graves', 'The family physician', 'Prescribed Harold sedatives that could mask poisoning symptoms.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(33, 5, 'Catherine Blake', 'A business associate', 'Forged Harold''s signature on several documents, including a check.', 'Катрин Блейк', 'Бизнес партньор', 'Фалшифицирала е подписа на Харалд върху няколко документа, включително чек.', NULL, NULL, NULL, NULL),
	(34, 5, 'Lord Reginald Ashcroft', 'A wealthy aristocrat', 'Owed Harold a massive gambling debt.', 'Лорд Реджиналд Ашкрофт', 'Богат аристократ', 'Дължи огромен дълг на Харалд от хазарт.', NULL, NULL, NULL, NULL),
	(35, 5, 'Beatrice Langston', 'Harold''s sister', 'Knew Harold planned to marry again and write her out of the will.', 'Беатрис Лангстън', 'Сестрата на Харалд', 'Знаела е, че Харалд възнамерява да се ожени отново и да я изключи от завещанието.', NULL, NULL, NULL, NULL),
	(36, 5, 'Marcus Reed', 'A family friend', 'Had a romantic affair with Evelyn.', 'Маркус Рийд', 'Семеен приятел', 'Имал е романтична връзка с Евелин.', NULL, NULL, NULL, NULL),
	(37, 5, 'James the Butler', 'The estate''s butler', 'Overheard blackmail material and has been eavesdropping for weeks.', 'Джеймс Лорд', 'Икономът на имението', 'Подслушвал е седмици и е чул компрометираща информация.', NULL, NULL, NULL, NULL),
	(38, 5, 'Anna the Maid', 'The estate''s maid', 'Saw someone sneaking into the study the night before the murder.', 'Анна Камериерката', 'Камериерката на имението', 'Видяла е някой да се промъква в кабинета вечерта преди убийството.', NULL, NULL, NULL, NULL),
	(39, 5, 'Lady Victoria Blackwood', 'A society matron', 'Was being blackmailed by Harold about her husband''s gambling debts.', 'Евелин Лангстън', 'Съпругата на домакина', 'Щеше да бъде изключена от завещанието.', NULL, NULL, NULL, NULL),
	(40, 5, 'Inspector Charles Whitmore', 'A police inspector', 'Was investigating Harold''s business dealings and had evidence of fraud.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(41, 6, 'Dr. Lisette Marchand', 'Worldly physician', 'She once attempted to poison another man who escaped justice.', 'Д-р Лизет Маршан', 'Опитен лекар', 'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.', NULL, NULL, NULL, NULL),
	(42, 6, 'Anton Novik', 'Mysterious chess master', 'He is a fugitive using a false identity.', 'Антон Новик', 'Тайнствен шахматен майстор', 'Той е беглец с фалшива самоличност.', NULL, NULL, NULL, NULL),
	(43, 6, 'Margot Leclair', 'Investigative journalist. ', 'She is secretly Crowthorne''s illegitimate daughter.', 'Марго Леклер', 'Разследващ журналист', 'Тя е тайнa незаконна дъщеря на Кроуторн.', NULL, NULL, NULL, NULL),
	(44, 6, 'Julian Everett', 'Incognito railway detective', 'He was hired to kill Crowthorne—but chose not to.', 'Джулиан Евърет', 'Инкогнито железопътен детектив', 'Бил е нает да убие Кроуторн, но е отказал.', NULL, NULL, NULL, NULL),
	(45, 6, 'Clara Von Stein', 'Retired opera diva', 'She once attempted blackmail and fears it''s connected.', 'Клара фон Щайн', 'Пенсионирана оперна дива', 'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.', NULL, NULL, NULL, NULL),
	(46, 6, 'Franz Bauer', 'Conductor with a past', 'He has been smuggling items across borders.', 'Франц Бауер', 'Кондуктор с минало', 'Той е пренасял контрабандни стоки през граници.', NULL, NULL, NULL, NULL),
	(47, 6, 'Isadora Wren', 'Spiritualist medium', 'She plants evidence and fabricates "visions."', 'Исадора Урен', 'Медиум спиритуалист', 'Тя подхвърля улики и измисля "видения"."', NULL, NULL, NULL, NULL),
	(48, 6, 'Hassan Al-Khatib', 'Antique dealer', 'He forged the ceremonial dagger found at the scene.', 'Хасан Ал-Хатиб', 'Търговец на антики', 'Той е фалшифицирал церемониалния кинжал, намерен на местопрестъплението.', NULL, NULL, NULL, NULL),
	(49, 6, 'Eliot Quayle', 'Radical student', 'He forged a threatening letter planted in the victim''s room.', 'Елиът Куейл', 'Радикален студент', 'Той е фалшифицирал заплашително писмо, оставено в стаята на жертвата.', NULL, NULL, NULL, NULL),
	(50, 6, 'Celeste Duval', 'Socialite heiress', 'She lost everything gambling and is desperate.', 'Селест Дювал', 'Светска наследница', 'Тя е загубила всичко от хазарт и е отчаяна.', NULL, NULL, NULL, NULL),
	(51, 7, 'Dr. Lisette Marchand', 'Worldly physician', 'She once attempted to poison another man who escaped justice.', 'Д-р Лизет Маршан', 'Опитен лекар', 'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.', NULL, NULL, NULL, NULL),
	(52, 7, 'Anton Novik', 'Mysterious chess master', 'He is a fugitive using a false identity.', 'Антон Новик', 'Тайнствен шахматен майстор', 'Той е беглец с фалшива самоличност.', NULL, NULL, NULL, NULL),
	(53, 7, 'Margot Leclair', 'Investigative journalist', 'She is secretly Crowthorne''s illegitimate daughter.', 'Марго Леклер', 'Разследващ журналист', 'Тя е тайнa незаконна дъщеря на Кроуторн.', NULL, NULL, NULL, NULL),
	(54, 7, 'Julian Everett', 'Incognito railway detective', 'He was hired to kill Crowthorne—but chose not to.', 'Джулиан Евърет', 'Инкогнито железопътен детектив', 'Бил е нает да убие Кроуторн, но е отказал.', NULL, NULL, NULL, NULL),
	(55, 7, 'Clara Von Stein', 'Retired opera diva', 'She once attempted blackmail and fears it''s connected.', 'Клара фон Щайн', 'Пенсионирана оперна дива', 'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.', NULL, NULL, NULL, NULL),
	(56, 7, 'Franz Bauer', 'Conductor with a past', 'He has been smuggling items across borders.', 'Франц Бауер', 'Кондуктор с минало', 'Той е пренасял контрабандни стоки през граници.', NULL, NULL, NULL, NULL),
	(57, 8, 'Dr. Lisette Marchand', 'Worldly physician', 'She once attempted to poison another man who escaped justice.', 'Д-р Лизет Маршан', 'Опитен лекар', 'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.', NULL, NULL, NULL, NULL),
	(58, 8, 'Anton Novik', 'Mysterious chess master', 'He is a fugitive using a false identity.', 'Антон Новик', 'Тайнствен шахматен майстор', 'Той е беглец с фалшива самоличност.', NULL, NULL, NULL, NULL),
	(59, 8, 'Margot Leclair', 'Investigative journalist', 'She is secretly Crowthorne''s illegitimate daughter.', 'Марго Леклер', 'Разследващ журналист', 'Тя е тайнa незаконна дъщеря на Кроуторн.', NULL, NULL, NULL, NULL),
	(60, 8, 'Julian Everett', 'Incognito railway detective', 'He was hired to kill Crowthorne—but chose not to.', 'Джулиан Евърет', 'Инкогнито железопътен детектив', 'Бил е нает да убие Кроуторн, но е отказал.', NULL, NULL, NULL, NULL),
	(61, 8, 'Clara Von Stein', 'Retired opera diva', 'She once attempted blackmail and fears it''s connected.', 'Клара фон Щайн', 'Пенсионирана оперна дива', 'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.', NULL, NULL, NULL, NULL),
	(62, 8, 'Franz Bauer', 'Conductor with a past', 'He has been smuggling items across borders.', 'Франц Бауер', 'Кондуктор с минало', 'Той е пренасял контрабандни стоки през граници.', NULL, NULL, NULL, NULL),
	(63, 8, 'Isadora Wren', 'Spiritualist medium', 'She plants evidence and fabricates \"visions.\"', 'Исадора Урен', 'Медиум спиритуалист', 'Тя подхвърля улики и измисля \"видения.\"', NULL, NULL, NULL, NULL),
	(64, 9, 'Dr. Lisette Marchand', 'Worldly physician', 'She once attempted to poison another man who escaped justice.', 'Д-р Лизет Маршан', 'Опитен лекар', 'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.', NULL, NULL, NULL, NULL),
	(65, 9, 'Anton Novik', 'Mysterious chess master', 'He is a fugitive using a false identity.', 'Антон Новик', 'Тайнствен шахматен майстор', 'Той е беглец с фалшива самоличност.', NULL, NULL, NULL, NULL),
	(66, 9, 'Margot Leclair', 'Investigative journalist', 'She is secretly Crowthorne''s illegitimate daughter.', 'Марго Леклер', 'Разследващ журналист', 'Тя е тайнa незаконна дъщеря на Кроуторн.', NULL, NULL, NULL, NULL),
	(67, 9, 'Julian Everett', 'Incognito railway detective', 'He was hired to kill Crowthorne—but chose not to.', 'Джулиан Евърет', 'Инкогнито железопътен детектив', 'Бил е нает да убие Кроуторн, но е отказал.', NULL, NULL, NULL, NULL),
	(68, 9, 'Clara Von Stein', 'Retired opera diva', 'She once attempted blackmail and fears it''s connected.', 'Клара фон Щайн', 'Пенсионирана оперна дива', 'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.', NULL, NULL, NULL, NULL),
	(69, 9, 'Franz Bauer', 'Conductor with a past', 'He has been smuggling items across borders.', 'Франц Бауер', 'Кондуктор с минало', 'Той е пренасял контрабандни стоки през граници.', NULL, NULL, NULL, NULL),
	(70, 9, 'Isadora Wren', 'Spiritualist medium', 'She plants evidence and fabricates \"visions.\"', 'Исадора Урен', 'Медиум спиритуалист', 'Тя подхвърля улики и измисля \"видения.\"', NULL, NULL, NULL, NULL),
	(71, 9, 'Hassan Al-Khatib', 'Antique dealer', 'He forged the ceremonial dagger found at the scene.', 'Хасан Ал-Хатиб', 'Търговец на антики', 'Той е фалшифицирал церемониалния кинжал, намерен на местопрестъплението.', NULL, NULL, NULL, NULL),
	(72, 10, 'Dr. Lisette Marchand', 'Worldly physician', 'She once attempted to poison another man who escaped justice.', 'Д-р Лизет Маршан', 'Опитен лекар', 'Тя веднъж се опита да отрови друг мъж, който избяга от правосъдието.', NULL, NULL, NULL, NULL),
	(73, 10, 'Anton Novik', 'Mysterious chess master', 'He is a fugitive using a false identity.', 'Антон Новик', 'Тайнствен шахматен майстор', 'Той е беглец с фалшива самоличност.', NULL, NULL, NULL, NULL),
	(74, 10, 'Margot Leclair', 'Investigative journalist', 'She is secretly Crowthorne''s illegitimate daughter.', 'Марго Леклер', 'Разследващ журналист', 'Тя е тайнa незаконна дъщеря на Кроуторн.', NULL, NULL, NULL, NULL),
	(75, 10, 'Julian Everett', 'Incognito railway detective', 'He was hired to kill Crowthorne—but chose not to.', 'Джулиан Евърет', 'Инкогнито железопътен детектив', 'Бил е нает да убие Кроуторн, но е отказал.', NULL, NULL, NULL, NULL),
	(76, 10, 'Clara Von Stein', 'Retired opera diva', 'She once attempted blackmail and fears it''s connected.', 'Клара фон Щайн', 'Пенсионирана оперна дива', 'Тя веднъж е опитала изнудване и се страхува, че може да бъде свързано с това убийство.', NULL, NULL, NULL, NULL),
	(77, 10, 'Franz Bauer', 'Conductor with a past', 'He has been smuggling items across borders.', 'Франц Бауер', 'Кондуктор с минало', 'Той е пренасял контрабандни стоки през граници.', NULL, NULL, NULL, NULL),
	(78, 10, 'Isadora Wren', 'Spiritualist medium', 'She plants evidence and fabricates \"visions.\"', 'Исадора Урен', 'Медиум спиритуалист', 'Тя подхвърля улики и измисля \"видения.\"', NULL, NULL, NULL, NULL),
	(79, 10, 'Hassan Al-Khatib', 'Antique dealer', 'He forged the ceremonial dagger found at the scene.', 'Хасан Ал-Хатиб', 'Търговец на антики', 'Той е фалшифицирал церемониалния кинжал, намерен на местопрестъплението.', NULL, NULL, NULL, NULL),
	(80, 10, 'Eliot Quayle', 'Radical student', 'He forged a threatening letter planted in the victim''s room.', 'Елиът Куейл', 'Радикален студент', 'Той е фалшифицирал заплашително писмо, оставено в стаята на жертвата.', NULL, NULL, NULL, NULL),
	(23, 4, 'Dr. Lionel Graves', 'The family physician', 'Prescribed Harold sedatives that could mask poisoning symptoms.', 'Д-р Лайънъл Грейвс', 'Семейният лекар', 'Предписал е седативи, които могат да прикрият симптомите на отравяне.', NULL, NULL, NULL, NULL),
	(100, NULL, 'Elena Markova', 'Former fiancée of Viktor', 'She almost commited a suicide after being blackmailed by Viktor over a family scandal', 'Елена Маркова', 'Бивша годеница на Виктор', 'Тя прави неуспешен опит за самоубийство заради Виктор, който я изнудва за семееен скандал', 'Viktor broke off their engagement after discovering her family''s criminal past', 'Виктор развали годежа им след като откри престъпното минало на семейството ѝ', 'Traveling to Paris for a new life', 'Пътува за Париж в търсене на нов живот'),
	(104, NULL, 'Sofia Dimitrova', 'Famous opera singer, Viktor''s former lover', 'She is addicted to laudanum and fears her addiction will be exposed', 'София Димитрова', 'Известна оперна певица, бивша любовница на Виктор', 'Тя е пристрастена към лауданум и се страхува, че пристрастността ѝ ще бъде разкрита', 'Viktor abandoned her when she became pregnant and refused to acknowledge the child', 'Виктор я изостави, когато забременя и отказа да признае детето', 'On tour, but her ticket was paid for by Viktor', 'На турне, но билетът ѝ е платен от Виктор'),
	(105, NULL, 'Petar Kolev', 'Train conductor', 'He has a duplicate key to all compartments', 'Петър Колев', 'Кондуктор на влака', 'Той има резервен ключ за всички купета', 'Viktor bribed him to ensure privacy and security during his journey', 'Виктор го подкупи да осигури поверителност и сигурност по време на пътуването си', 'Working the train', 'Работи във влака'),
	(106, NULL, 'Irina Vasileva', 'Personal assistant of Viktor', 'She has been stealing money from Viktor''s accounts for months', 'Ирина Василева', 'Лична асистентка на Виктор', 'Тя краде пари от сметките на Виктор от месеци', 'Viktor was planning to fire her and replace her with his daughter Maria', 'Виктор планираше да я уволни и да я замени с дъщеря си Мария', 'Claims to be seeking work in Paris', 'Твърди, че търси работа в Париж'),
	(107, NULL, 'Mihail Todorov', 'Rival industrialist', 'He bribed someone on the train for information about Viktor', 'Михаил Тодоров', 'Конкуриращ индустриалец', 'Той е подкупил някой във влака за информация за Виктор', 'Viktor was about to expose Mihail''s illegal business practices in court', 'Виктор беше на път да разкрие незаконните бизнес практики на Михаил в съда', 'Claims to be traveling for business to Paris', 'Твърди, че пътува за бизнес за Париж'),
	(108, NULL, 'Vesela Georgieva', 'Investigative journalist', 'She fabricated some of the evidence in her investigation to make it more sensational', 'Весела Георгиева', 'Разследващ журналист', 'Тя е фалшифицирала част от доказателствата в разследването си, за да го направи по-сензационно', 'Viktor was blackmailing her to prevent publication of her investigation into his factory accidents', 'Виктор я изнудваше, за да предотврати публикуването на разследването ѝ за инцидентите във фабриката му', 'Traveling incognito to Paris', 'Пътува инкогнито за Париж'),
	(109, NULL, 'Stefan Dimitrov', 'Estranged husband of Sofia', 'He was seen arguing with Viktor the night of the murder', 'Стефан Димитров', 'Отчужден съпруг на София', 'Той е видян да се кара с Виктор в нощта на убийството', 'Viktor was trying to convince Sofia to leave Stefan and return to him', 'Виктор се опитваше да убеди София да напусне Стефан и да се върне при него', 'Claims to be following Sofia to Paris', 'Твърди, че следва София за Париж'),
	(102, NULL, 'Maria Petrova', 'Estranged daughter of Viktor', 'She threatened Viktor in a letter found by the police', 'Мария Петрова', 'Отчуждена дъщеря на Виктор', 'Тя е заплашила Виктор в писмо, намерено от полицията', 'Viktor disinherited her partially after she refused to marry a strategic business partner', 'Виктор я лиши частично от наследство след като тя отказа да се омъжи за негов стратегически бизнес партньор', 'Traveling under a false name to Paris', 'Пътува под фалшиво име за Париж'),
	(101, NULL, 'Nikolai Ivanov', 'Business partner of Viktor', 'He was embezzling money from Viktor''s company', 'Николай Иванов', 'Бизнес партньор на Виктор', 'Той е присвоявал пари от компанията на Виктор', 'Viktor and Nikolai were childhood friends who started the business together, but Viktor gradually took control and pushed Nikolai aside', 'Виктор и Николай са приятели от детството, които са започнали бизнеса заедно, но Виктор постепенно е поел цялостен контрол над фирмата', 'Claims to be on a business trip to Paris', 'Твърди, че е на бизнес пътуване до Париж'),
	(103, NULL, 'Georgi Stoyanov', 'Former bodyguard of Viktor', 'He was paid by an unknown person to "watch" Viktor', 'Георги Стоянов', 'Бивш телохранител на Виктор', 'Той е получил пари от неизвестен човек за да "наблюдава" Виктор', 'Viktor fired him after he failed to prevent the kidnapping of his son, that costed him a ton of money', 'Виктор го уволни след като не успя да предотврати отвличане на сина му, което му коства цяло състояние', 'Claims to be traveling to Paris to find new work', 'Твърди, че пътува за Париж да намери нова работа'),
	(1003, NULL, 'Jessica "Jess" Rodriguez', 'The Maid of Honor', 'Had a one-night stand with Dave and feared he would expose her', 'Джесика "Джес" Родригез', 'Кумата', 'Имала е еднократна връзка с Дейв и се страхуваше, че той може да я разкрие', 'She is the wife of the best man of the wedding (best friend of the groom)', 'Тя е жената на кума (най-добрият приятел на младоженеца)', 'Was seen entering the VIP lounge around 10:50 PM', 'Видяна е да влиза във VIP залата около 22:50'),
	(1004, NULL, 'Sarah Mitchell', 'The Bride-to-Be', 'She secretly hired Dave for private performances and was being blackmailed by him', 'Сара Митчъл', 'Бъдещата булка', 'Тя тайно е наемала Дейв за частни представления и той я изнудваше за да не разпространява историята', 'Was questioning whether she should call off the wedding due to financial pressure', 'Обмисляше дали да отмени сватбата поради финансови затруднения', 'Found Dave''s body at 11:30 PM and immediately called security', 'Намерила е тялото на Дейв в 23:30 и веднага е извикала охраната'),
	(1005, NULL, 'Amanda Chen', 'The Best Friend', 'She was secretly pregnant and considering an abortion', 'Аманда Чен', 'Най-добрата приятелка', 'Тя крие бременност и тайно обмисля аборт', 'Dave knew about her secret and was threatening to tell everyone', 'Дейв знаеше за тайната ѝ и я заплашваше да каже на всички', 'Has been acting strangely all night', 'Държеше се странно цялата нощ'),
	(1006, NULL, 'Rachel Thompson', 'The Sister', 'She was secretly in debt and had borrowed money from Dave', 'Рейчъл Томпсън', 'Сестрата', 'Тя дължи пари на Дейв', 'Dave was lecturing her about because of her gambling addiction', 'Дейв я упрекна за пристрастяването ѝ към хазарта', 'Was seen arguing with Dave earlier in the evening', 'Видяна е да се кара с Дейв по-рано през вечерта'),
	(1007, NULL, 'Maya Patel', 'The Cousin', 'She was secretly dating Dave and thought they were exclusive', 'Мая Пател', 'Братовчедката', 'Тя тайно се срещаше с Дейв и мислеше, че са ексклузивни', 'Saw Dave making out with a woman during the party and became furious', 'Видя Дейв да се целува с жена по време на партито и побесня', 'Was seen following both Sarah and Dave throughout the evening', 'Видяна е да следва и Сара, и Дейв на няколко пъти през вечер'),
	(1008, NULL, 'Sophie Williams', 'The College Roommate', 'She was secretly a private investigator hired by the groom''s family', 'Софи Уилямс', 'Съквартирантка от университета', 'Тя е частен детектив, нает от семейството на младоженеца', 'Has been seen reading a notebook with Dave''s name on one of the pages', 'Видяна е да чете ръкописна тетрадка, в която фигурираше името на Дейв', 'Was taking photos of Dave throughout the evening', 'Правеше снимки на Дейв през цялата вечер'),
	(1009, NULL, 'Isabella "Bella" Martinez', 'The Wedding Planner', 'She was secretly Dave''s sister and knew about his criminal activities', 'Изабела "Бела" Мартинес', 'Организаторката на сватбата', 'Тя сестра на Дейв и знае за престъпните му дейности', 'Was trying to stop Dave from doing unlawful things during the party', 'Опитваше се да спре Дейв да прави незаконни неща по време на партито', 'Has been making mysterious phone calls all evening', 'Правеше тайнствени телефонни обаждания през цялата вечер'),
	(1010, NULL, 'Victoria "Vicky" Anderson', 'Friend from School', 'She was Dave''s ex-girlfriend and still obsessed with him', 'Виктория "Вики" Андерсън', 'Приятелка от училище', 'Тя е бивша приятелка на Дейв и все още е обсебена от него', 'Was stalking Dave and jealous of his relationships with other women', 'Преследваше Дейв и ревнуваше от връзките му с други жени', 'Was seen lurking around the venue earlier', 'Видяна е да търси скришни места около къщата в ранната част на вечерта'),
	(1011, NULL, 'Nicole "Nikki" Foster', 'The Party Planner', 'She was secretly working with the police to bust Dave''s drug operation', 'Никол "Ники" Фостър', 'Организаторката на партито', 'Тя работи под прикритие за да разкрие наркотрафикантската банда на Дейв', 'She was recommended by Sophie, as she''s been the organizer of her bachelorette party', 'Тя е препоръчана от Софи, тъй като е била организаторка на нейното моминско парти', 'Was the only one not wearing a swimsuit', 'Беше единствената, която не носеше бански костюм'),
	(1012, NULL, 'Ashley "Ash" Johnson', 'The Security Guard', 'She was secretly Dave''s business partner in his illegal activities', 'Ашли "Аш" Джонсън', 'Охранителката', 'Тя помагаше на Дейв за незаконните му операции', 'Was trying to cover up video evidence of illegal activities during the party', 'Опитваше се да изтрие видео записи от партито', 'Has been monitoring the security cameras all evening', 'Наблюдаваше охранителните камери през цялата вечер');


--
-- Data for Name: Character_Variations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Character_Variations" ("character_id", "variation_id") VALUES
	(16, 3),
	(71, 9),
	(58, 8),
	(73, 10),
	(20, 3),
	(69, 9),
	(32, 5),
	(18, 3),
	(55, 7),
	(1, 1),
	(59, 8),
	(14, 2),
	(44, 6),
	(5, 1),
	(75, 10),
	(40, 5),
	(36, 5),
	(25, 4),
	(54, 7),
	(39, 5),
	(30, 4),
	(64, 9),
	(46, 6),
	(4, 1),
	(37, 5),
	(19, 3),
	(80, 10),
	(35, 5),
	(79, 10),
	(51, 7),
	(63, 8),
	(49, 6),
	(48, 6),
	(70, 9),
	(7, 1),
	(11, 2),
	(26, 4),
	(65, 9),
	(42, 6),
	(10, 2),
	(3, 1),
	(76, 10),
	(33, 5),
	(27, 4),
	(74, 10),
	(22, 4),
	(12, 2),
	(17, 3),
	(21, 3),
	(68, 9),
	(61, 8),
	(56, 7),
	(29, 4),
	(60, 8),
	(78, 10),
	(31, 5),
	(72, 10),
	(34, 5),
	(2, 1),
	(23, 4),
	(6, 1),
	(52, 7),
	(43, 6),
	(57, 8),
	(45, 6),
	(9, 2),
	(67, 9),
	(62, 8),
	(77, 10),
	(15, 3),
	(50, 6),
	(53, 7),
	(41, 6),
	(28, 4),
	(8, 1),
	(24, 4),
	(47, 6),
	(38, 5),
	(13, 2),
	(66, 9),
	(100, 11),
	(101, 11),
	(102, 11),
	(103, 11),
	(104, 11),
	(105, 11),
	(100, 12),
	(101, 12),
	(102, 12),
	(103, 12),
	(104, 12),
	(105, 12),
	(106, 12),
	(100, 13),
	(101, 13),
	(102, 13),
	(103, 13),
	(104, 13),
	(105, 13),
	(106, 13),
	(107, 13),
	(100, 14),
	(101, 14),
	(102, 14),
	(103, 14),
	(104, 14),
	(105, 14),
	(106, 14),
	(107, 14),
	(108, 14),
	(100, 15),
	(101, 15),
	(102, 15),
	(103, 15),
	(104, 15),
	(105, 15),
	(106, 15),
	(107, 15),
	(108, 15),
	(109, 15),
	(1003, 16),
	(1004, 16),
	(1005, 16),
	(1006, 16),
	(1007, 16),
	(1008, 16),
	(1003, 17),
	(1004, 17),
	(1005, 17),
	(1006, 17),
	(1007, 17),
	(1008, 17),
	(1009, 17),
	(1003, 18),
	(1004, 18),
	(1005, 18),
	(1006, 18),
	(1007, 18),
	(1008, 18),
	(1009, 18),
	(1010, 18),
	(1003, 19),
	(1004, 19),
	(1005, 19),
	(1006, 19),
	(1007, 19),
	(1008, 19),
	(1009, 19),
	(1010, 19),
	(1011, 19),
	(1003, 20),
	(1004, 20),
	(1005, 20),
	(1006, 20),
	(1007, 20),
	(1008, 20),
	(1009, 20),
	(1010, 20),
	(1011, 20),
	(1012, 20);


--
-- Data for Name: Rounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Rounds" ("round_id", "variation_id", "round_number", "title", "description", "title_bg", "description_bg") VALUES
	(1, 1, 1, 'Initial Discovery', 'The first clues are discovered at the scene of the crime', 'Първоначално откритие', 'Първите улики са открити на мястото на престъплението'),
	(2, 1, 2, 'Interrogations Begin', 'The investigation deepens as more secrets are revealed', 'Започват разпитите', 'Разследването се задълбочава, разкриват се още тайни'),
	(3, 1, 3, 'The Web Untangles', 'The final pieces of the puzzle come together', 'Пъзелът се разплита', 'Последните части от пъзела се подреждат'),
	(4, 2, 1, 'Initial Discovery', 'The first clues are discovered at the scene of the crime', 'Първоначално откритие', 'Първите улики са открити на мястото на престъплението'),
	(5, 2, 2, 'Interrogations Begin', 'The investigation deepens as more secrets are revealed', 'Започват разпитите', 'Разследването се задълбочава, разкриват се още тайни'),
	(6, 2, 3, 'The Web Untangles', 'The final pieces of the puzzle come together', 'Пъзелът се разплита', 'Последните части от пъзела се подреждат'),
	(7, 3, 1, 'Initial Discovery', 'The first clues are discovered at the scene of the crime', 'Първоначално откритие', 'Първите улики са открити на мястото на престъплението'),
	(8, 3, 2, 'Interrogations Begin', 'The investigation deepens as more secrets are revealed', 'Започват разпитите', 'Разследването се задълбочава, разкриват се още тайни'),
	(9, 3, 3, 'The Web Untangles', 'The final pieces of the puzzle come together', 'Пъзелът се разплита', 'Последните части от пъзела се подреждат'),
	(10, 4, 1, 'Initial Discovery', 'The first clues are discovered at the scene of the crime', 'Първоначално откритие', 'Първите улики са открити на мястото на престъплението'),
	(11, 4, 2, 'Interrogations Begin', 'The investigation deepens as more secrets are revealed', 'Започват разпитите', 'Разследването се задълбочава, разкриват се още тайни'),
	(12, 4, 3, 'The Web Untangles', 'The final pieces of the puzzle come together', 'Пъзелът се разплита', 'Последните части от пъзела се подреждат'),
	(13, 5, 1, 'Initial Discovery', 'The first clues are discovered at the scene of the crime', 'Първоначално откритие', 'Първите улики са открити на мястото на престъплението'),
	(14, 5, 2, 'Interrogations Begin', 'The investigation deepens as more secrets are revealed', 'Започват разпитите', 'Разследването се задълбочава, разкриват се още тайни'),
	(15, 5, 3, 'The Web Untangles', 'The final pieces of the puzzle come together', 'Пъзелът се разплита', 'Последните части от пъзела се подреждат'),
	(19, 7, 1, 'Crime Scene', 'Initial investigation of the cabin', 'Мястото на престъплението', 'Първоначално разследване на кабината'),
	(20, 7, 2, 'Hidden Motives', 'Uncovering character secrets', 'Скрити мотиви', 'Разкриване на тайните на героите'),
	(21, 7, 3, 'Final Threads', 'Connecting all evidence', 'Последни нишки', 'Свързване на всички улики'),
	(16, 6, 1, 'Crime Scene', 'Initial investigation of the cabin', 'Мястото на престъплението', 'Първоначално разследване на кабината'),
	(18, 6, 3, 'Final Threads', 'Connecting all evidence', 'Последни нишки', 'Свързване на всички улики'),
	(17, 6, 2, 'Hidden Motives', 'Uncovering character secrets', 'Скрити мотиви', 'Разкриване на тайните на героите'),
	(22, 8, 1, 'Crime Scene', 'Initial investigation of the cabin', 'Мястото на престъплението', 'Първоначално разследване на кабината'),
	(23, 8, 2, 'Hidden Motives', 'Uncovering character secrets', 'Скрити мотиви', 'Разкриване на тайните на героите'),
	(24, 8, 3, 'Final Threads', 'Connecting all evidence', 'Последни нишки', 'Свързване на всички улики'),
	(25, 9, 1, 'Crime Scene', 'Initial investigation of the cabin', 'Мястото на престъплението', 'Първоначално разследване на кабината'),
	(26, 9, 2, 'Hidden Motives', 'Uncovering character secrets', 'Скрити мотиви', 'Разкриване на тайните на героите'),
	(27, 9, 3, 'Final Threads', 'Connecting all evidence', 'Последни нишки', 'Свързване на всички улики'),
	(28, 10, 1, 'Crime Scene', 'Initial investigation of the cabin', 'Мястото на престъплението', 'Първоначално разследване на кабината'),
	(29, 10, 2, 'Hidden Motives', 'Uncovering character secrets', 'Скрити мотиви', 'Разкриване на тайните на героите'),
	(30, 10, 3, 'Final Threads', 'Connecting all evidence', 'Последни нишки', 'Свързване на всички улики'),
	(31, 11, 1, 'Crime Scene Investigation', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character’s secret you want to reveal in the next round. ', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(32, 11, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(33, 11, 3, 'Deeper Investigation', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено разследване', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(34, 11, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(35, 11, 5, 'Final Evidence', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
	(36, 12, 1, 'Crime Scene Investigation', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(37, 12, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(38, 12, 3, 'Deeper Investigation', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено разследване', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(39, 12, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(40, 12, 5, 'Final Evidence', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
	(41, 13, 1, 'Crime Scene Investigation', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(42, 13, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(43, 13, 3, 'Deeper Investigation', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено разследване', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(44, 13, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(45, 13, 5, 'Final Evidence', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
	(46, 14, 1, 'Crime Scene Investigation', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(47, 14, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(48, 14, 3, 'Deeper Investigation', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено разследване', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(49, 14, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(50, 14, 5, 'Final Evidence', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
	(51, 15, 1, 'Crime Scene Investigation', 'Initial examination of the locked compartment. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round. ', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенoтo купе. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(52, 15, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(53, 15, 3, 'Deeper Investigation', 'Further examination of evidence and alibis. It''s time to start speculating!', 'По-задълбочено разследване', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(54, 15, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайна', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(55, 15, 5, 'Final Evidence', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%. '),
	(60, 16, 1, 'Crime Scene Investigation', 'Initial examination of the locked vip lounge. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round.', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенaтa вип зала. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(61, 16, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(62, 16, 3, 'Evidence Analysis', 'Further examination of evidence and alibis. It''s time to start speculating!', 'Анализ на доказателствата', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(63, 16, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(64, 16, 5, 'Final Set of Clues', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%.'),
	(65, 17, 1, 'Crime Scene Investigation', 'Initial examination of the locked vip lounge. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round.', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенaтa вип зала. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(66, 17, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(67, 17, 3, 'Evidence Analysis', 'Further examination of evidence and alibis. It''s time to start speculating!', 'Анализ на доказателствата', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(68, 17, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(69, 17, 5, 'Final Set of Clues', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%.'),
	(70, 18, 1, 'Crime Scene Investigation', 'Initial examination of the locked vip lougne. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round.', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенaтa вип зала. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(71, 18, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(72, 18, 3, 'Evidence Analysis', 'Further examination of evidence and alibis. It''s time to start speculating!', 'Анализ на доказателствата', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(73, 18, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(74, 18, 5, 'Final Set of Clues', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%.'),
	(75, 19, 1, 'Crime Scene Investigation', 'Initial examination of the locked vip lounge. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round.', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенaтa вип зала. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(76, 19, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(77, 19, 3, 'Evidence Analysis', 'Further examination of evidence and alibis. It''s time to start speculating!', 'Анализ на доказателствата', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(78, 19, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(79, 19, 5, 'Final Set of Clues', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%.'),
	(80, 20, 1, 'Crime Scene Investigation', 'Initial examination of the locked vip lounge. Review the available clues and discuss what insights you can gather from them, so you can decide which character''s secret you want to reveal in the next round.', 'Разследване на местопрестъплението', 'Първоначално преглеждане на заключенaтa вип зала. Разгледайте откритите улики и обсъдете каква информация ви предоставят. Стигнете до заключение чия тайна бихте искали да разкриете през следващия рунд.'),
	(81, 20, 2, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(82, 20, 3, 'Evidence Analysis', 'Further examination of evidence and alibis. It''s time to start speculating!', 'Анализ на доказателствата', 'По-задълбочено преглеждане на улики и обсоятелства. Нека спекулациите започнат сега!'),
	(83, 20, 4, 'Secret Revelation', 'Cast your vote to uncover a character''s secret. Once a majority is reached through verbal voting, reveal the chosen character''s secret.', 'Разкриване на тайни', 'Гласувайте, за да разкриете тайната на един от героите. След като се достигне мнозинство чрез вербално гласуване, разкрийте тайната на избрания герой.'),
	(84, 20, 5, 'Final Set of Clues', 'Connecting all evidence and motives. Time to put your heads together and decide who the murderer is. Required majority of at least 51%.', 'Финални улики', 'Свързване на всички улики и мотиви. Време е да достигнете до заключение кой е убиецът с мнозинство от поне 51%.');


--
-- Data for Name: Clues; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Clues" ("clue_id", "round_id", "clue_number", "content", "content_bg", "hidden") VALUES
	(8, 3, 2, 'Love letters between Marcus and Evelyn.', 'Любовни писма между Маркус и Евелин.', false),
	(5, 2, 2, 'Maid Anna saw Evelyn sneaking into the study around 8 PM.', 'Прислужницата Анна видя Евелин да се промъква в кабинета около 20:00 ч.', false),
	(64, 16, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло', false),
	(67, 16, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината', false),
	(68, 17, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито', false),
	(69, 17, 2, 'Hassan''s customs tag', 'Митническият етикет на Хасан', false),
	(70, 17, 3, 'Celeste''s ruined financial papers', 'Унищожените финансови документи на Селест', false),
	(71, 17, 4, 'Eliot''s political leaflet', 'Политическата листовка на Елиът', false),
	(72, 18, 1, 'Blackmail letter traced to Eliot''s typewriter', 'Писмото за изнудване е проследено до пишещата машина на Елиът', false),
	(73, 18, 2, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн', false),
	(74, 18, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът', false),
	(75, 18, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград', false),
	(76, 19, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло', false),
	(77, 19, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем', false),
	(78, 19, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора', false),
	(79, 20, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито', false),
	(80, 20, 2, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн', false),
	(81, 20, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът', false),
	(82, 21, 1, 'Blackmail letter traced to Clara''s handwriting', 'Писмото за изнудване е проследено до почерка на Клара', false),
	(83, 21, 2, 'Anton''s chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината', false),
	(84, 21, 3, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград', false),
	(66, 16, 3, 'Spare conductor key is missing', 'Резервният ключ на кондуктора липсва', false),
	(65, 16, 2, 'Teacup with bitter almond scent', 'Чаша за чай с аромат на горчив бадем', false),
	(85, 22, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло', false),
	(86, 22, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем', false),
	(87, 22, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора', false),
	(88, 22, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината', false),
	(89, 23, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито', false),
	(90, 23, 2, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн', false),
	(91, 23, 3, 'Isadora''s \"vision\" about the murder', 'Видението на Исадора за убийството', false),
	(92, 24, 1, 'Blackmail letter traced to Clara''s handwriting', 'Писмото за изнудване е проследено до почерка на Клара', false),
	(93, 24, 2, 'Anton''s chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината', false),
	(94, 24, 3, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград', false),
	(95, 25, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло', false),
	(96, 25, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем', false),
	(97, 25, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора', false),
	(98, 25, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината', false),
	(1, 1, 1, 'Smell of bitter almonds on his lips (suggests cyanide).', 'Мирис на горчиви бадеми по устните му (подсказва цианид).', false),
	(2, 1, 2, 'Harold drank alone in the study before joining the party.', 'Харолд пиеше сам в кабинета, преди да се присъедини към партито.', false),
	(3, 1, 3, 'Only a few guests knew Harold drank brandy, not wine.', 'Само няколко гости знаеха, че Харолд пие бренди, а не вино.', false),
	(4, 2, 1, 'Crumpled note in the study trash bin – "If you don''t confess, I will."', 'Смачкана бележка в кошчето за боклук в кабинета – „Ако не признаеш, аз ще го направя.“', false),
	(6, 2, 3, 'Empty cyanide vial found in Dr. Graves'' bag (he claims it''s for medical use).', 'Празен флакон с цианид, намерен в чантата на д-р Грейвс (той твърди, че е за медицинска употреба).', false),
	(7, 3, 1, 'Forged Will found in Catherine''s drawer, dated last week.', 'Фалшиво завещание, намерено в чекмеджето на Катрин, датирано от миналата седмица.', false),
	(9, 3, 3, 'Financial ledger showing Reginald owed over £100,000, and Harold planned to expose him.', 'Финансов отчет, показващ, че Реджиналд е дължал над £100 000, и Харолд е планирал да го изобличи.', false),
	(10, 4, 1, 'Smell of bitter almonds on his lips (suggests cyanide).', 'Мирис на горчиви бадеми по устните му (подсказва цианид).', false),
	(11, 4, 2, 'Harold drank alone in the study before joining the party.', 'Харолд пиеше сам в кабинета, преди да се присъедини към партито.', false),
	(12, 4, 3, 'Only a few guests knew Harold drank brandy, not wine.', 'Само няколко гости знаеха, че Харолд пие бренди, а не вино.', false),
	(13, 5, 1, 'Crumpled note in the study trash bin – "If you don''t confess, I will."', 'Смачкана бележка в кошчето за боклук в кабинета – „Ако не признаеш, аз ще го направя.“', false),
	(15, 5, 3, 'Empty cyanide vial found in Dr. Graves'' bag (he claims it''s for medical use).', 'Празен флакон с цианид, намерен в чантата на д-р Грейвс (той твърди, че е за медицинска употреба).', false),
	(16, 6, 1, 'Forged Will found in Catherine''s drawer, dated last week.', 'Фалшиво завещание, намерено в чекмеджето на Катрин, датирано от миналата седмица.', false),
	(18, 6, 3, 'Financial ledger showing Reginald owed over £100,000, and Harold planned to expose him.', 'Финансов отчет, показващ, че Реджиналд е дължал над £100 000, и Харолд е планирал да го изобличи.', false),
	(19, 7, 4, 'The butler noticed the brandy decanter was moved from its usual position.', 'Икономът забеляза, че гарафата с бренди е преместена от обичайното си място.', false),
	(20, 7, 3, 'Only a few guests knew Harold drank brandy, not wine.', 'Само няколко гости знаеха, че Харолд пие бренди, а не вино.', false),
	(21, 7, 2, 'Harold drank alone in the study before joining the party.', 'Харолд пиеше сам в кабинета, преди да се присъедини към партито.', false),
	(22, 7, 1, 'Smell of bitter almonds on his lips (suggests cyanide).', 'Мирис на горчиви бадеми по устните му (подсказва цианид).', false),
	(23, 8, 4, 'James the butler was seen entering the study shortly before dinner.', 'Икономът Джеймс е видян да влиза в кабинета малко преди вечеря.', false),
	(24, 8, 3, 'Empty cyanide vial found in Dr. Graves'' bag (he claims it''s for medical use).', 'Празен флакон с цианид, намерен в чантата на д-р Грейвс (той твърди, че е за медицинска употреба).', false),
	(26, 8, 1, 'Crumpled note in the study trash bin – "If you don''t confess, I will."', 'Смачкана бележка в кошчето за боклук в кабинета – „Ако не признаеш, аз ще го направя.“', false),
	(27, 9, 4, 'The butler''s diary reveals he knew about Harold''s plans to change his will.', 'Дневникът на иконома разкрива, че той е знаел за плановете на Харолд да промени завещанието си.', false),
	(28, 9, 3, 'Financial ledger showing Reginald owed over £100,000, and Harold planned to expose him.', 'Финансов отчет, показващ, че Реджиналд е дължал над £100 000, и Харолд е планирал да го изобличи.', false),
	(30, 9, 1, 'Forged Will found in Catherine''s drawer, dated last week.', 'Фалшиво завещание, намерено в чекмеджето на Катрин, датирано от миналата седмица.', false),
	(31, 10, 5, 'Anna the maid saw Lady Victoria entering the study earlier that day.', 'Прислужницата Анна видя лейди Виктория да влиза в кабинета по-рано същия ден.', false),
	(32, 10, 4, 'The butler noticed the brandy decanter was moved from its usual position.', 'Икономът забеляза, че гарафата с бренди е преместена от обичайното си място.', false),
	(33, 10, 3, 'Only a few guests knew Harold drank brandy, not wine.', 'Само няколко гости знаеха, че Харолд пие бренди, а не вино.', false),
	(34, 10, 2, 'Harold drank alone in the study before joining the party.', 'Харолд пиеше сам в кабинета, преди да се присъедини към партито.', false),
	(35, 10, 1, 'Smell of bitter almonds on his lips (suggests cyanide).', 'Мирис на горчиви бадеми по устните му (подсказва цианид).', false),
	(36, 11, 5, 'Lady Victoria''s husband''s gambling debts were much larger than anyone knew.', 'Хазартните дългове на съпруга на лейди Виктория бяха много по-големи, отколкото някой подозираше.', false),
	(37, 11, 4, 'James the butler was seen entering the study shortly before dinner.', 'Икономът Джеймс е видян да влиза в кабинета малко преди вечеря.', false),
	(38, 11, 3, 'Empty cyanide vial found in Dr. Graves'' bag (he claims it''s for medical use).', 'Празен флакон с цианид, намерен в чантата на д-р Грейвс (той твърди, че е за медицинска употреба).', false),
	(17, 6, 2, 'Love letters between Marcus and Evelyn.', 'Любовни писма между Маркус и Евелин.', false),
	(25, 8, 2, 'The butler overheard a heated argument between Harold and Evelyn earlier that day.', 'Икономът подслуша ожесточен спор между Харолд и Евелин по-рано същия ден.', false),
	(29, 9, 2, 'Love letters between Marcus and Evelyn.', 'Любовни писма между Маркус и Евелин.', false),
	(40, 11, 1, 'Crumpled note in the study trash bin – "If you don''t confess, I will."', 'Смачкана бележка в кошчето за боклук в кабинета – „Ако не признаеш, аз ще го направя.“', false),
	(41, 12, 5, 'Lady Victoria was seen burning documents in the fireplace the morning of the murder.', 'Лейди Виктория е видяна да изгаря документи в камината сутринта на убийството.', false),
	(42, 12, 4, 'The butler''s diary reveals he knew about Harold''s plans to change his will.', 'Дневникът на иконома разкрива, че той е знаел за плановете на Харолд да промени завещанието си.', false),
	(43, 12, 3, 'Financial ledger showing Reginald owed over £100,000, and Harold planned to expose him.', 'Финансов отчет, показващ, че Реджиналд е дължал над £100 000, и Харолд е планирал да го изобличи.', false),
	(45, 12, 1, 'Forged Will found in Catherine''s drawer, dated last week.', 'Фалшиво завещание, намерено в чекмеджето на Катрин, датирано от миналата седмица.', false),
	(46, 13, 6, 'Inspector Whitmore''s notebook contains detailed observations about Harold''s business dealings.', 'Бележникът на инспектор Уитмор съдържа подробни наблюдения за бизнес сделките на Харолд.', false),
	(47, 13, 5, 'Anna the maid saw Lady Victoria entering the study earlier that day.', 'Прислужницата Анна видя лейди Виктория да влиза в кабинета по-рано същия ден.', false),
	(48, 13, 4, 'The butler noticed the brandy decanter was moved from its usual position.', 'Икономът забеляза, че гарафата с бренди е преместена от обичайното си място.', false),
	(49, 13, 3, 'Only a few guests knew Harold drank brandy, not wine.', 'Само няколко гости знаеха, че Харолд пие бренди, а не вино.', false),
	(50, 13, 2, 'Harold drank alone in the study before joining the party.', 'Харолд пиеше сам в кабинета, преди да се присъедини към партито.', false),
	(51, 13, 1, 'Smell of bitter almonds on his lips (suggests cyanide).', 'Мирис на горчиви бадеми по устните му (подсказва цианид).', false),
	(52, 14, 6, 'The Inspector had evidence that Harold was involved in insurance fraud.', 'Инспекторът е имал доказателства, че Харолд е замесен в застрахователна измама.', false),
	(53, 14, 5, 'Lady Victoria''s husband''s gambling debts were much larger than anyone knew.', 'Хазартните дългове на съпруга на лейди Виктория бяха много по-големи, отколкото някой подозираше.', false),
	(54, 14, 4, 'James the butler was seen entering the study shortly before dinner.', 'Икономът Джеймс е видян да влиза в кабинета малко преди вечеря.', false),
	(55, 14, 3, 'Empty cyanide vial found in Dr. Graves'' bag (he claims it''s for medical use).', 'Празен флакон с цианид, намерен в чантата на д-р Грейвс (той твърди, че е за медицинска употреба).', false),
	(57, 14, 1, 'Crumpled note in the study trash bin – "If you don''t confess, I will."', 'Смачкана бележка в кошчето за боклук в кабинета – „Ако не признаеш, аз ще го направя.“', false),
	(58, 15, 6, 'The Inspector''s investigation file reveals Harold was about to be arrested for fraud.', 'Разследващият файл на инспектора разкрива, че Харолд е щял да бъде арестуван за измама.', false),
	(59, 15, 5, 'Lady Victoria was seen burning documents in the fireplace the morning of the murder.', 'Лейди Виктория е видяна да изгаря документи в камината сутринта на убийството.', false),
	(60, 15, 4, 'The butler''s diary reveals he knew about Harold''s plans to change his will.', 'Дневникът на иконома разкрива, че той е знаел за плановете на Харолд да промени завещанието си.', false),
	(61, 15, 3, 'Financial ledger showing Reginald owed over £100,000, and Harold planned to expose him.', 'Финансов отчет, показващ, че Реджиналд е дължал над £100 000, и Харолд е планирал да го изобличи.', false),
	(63, 15, 1, 'Forged Will found in Catherine''s drawer, dated last week.', 'Фалшиво завещание, намерено в чекмеджето на Катрин, датирано от миналата седмица.', false),
	(14, 5, 2, 'A witness saw Evelyn sneaking into the study around 8 PM.', 'Свидетел е видял Евелин да се промъква в кабинета около 20:00 ч.', false),
	(39, 11, 2, 'The butler overheard a heated argument between Harold and Evelyn earlier that day.', 'Икономът подслуша ожесточен спор между Харолд и Евелин по-рано същия ден.', false),
	(44, 12, 2, 'Love letters between Marcus and Evelyn.', 'Любовни писма между Маркус и Евелин.', false),
	(56, 14, 2, 'The butler overheard a heated argument between Harold and Evelyn earlier that day.', 'Икономът подслуша ожесточен спор между Харолд и Евелин по-рано същия ден.', false),
	(62, 15, 2, 'Love letters between Marcus and Evelyn.', 'Любовни писма между Маркус и Евелин.', false),
	(99, 26, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито', false),
	(100, 26, 2, 'Hassan''s customs tag', 'Митническият етикет на Хасан', false),
	(101, 26, 3, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн', false),
	(102, 26, 4, 'Isadora''s \"vision\" about the murder', 'Видението на Исадора за убийството', false),
	(103, 27, 1, 'Blackmail letter traced to Clara''s handwriting', 'Писмото за изнудване е проследено до почерка на Клара', false),
	(104, 27, 2, 'Anton''s chess piece found in the cabin', 'Шахматна фигура на Антон е намерена в кабината', false),
	(105, 27, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът', false),
	(106, 27, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград', false),
	(107, 28, 1, 'Dagger in cabin floor, blood but no body', 'Кинжал на пода в кабината, кръв, но няма тяло', false),
	(108, 28, 2, 'Teacup with bitter almond scent', 'Чаша с аромат на горчив бадем', false),
	(109, 28, 3, 'Spare conductor key is missing', 'Липсва резервен ключ на кондуктора', false),
	(110, 28, 4, 'Necklace fragment found outside cabin', 'Открит е фрагмент от колие извън кабината', false),
	(111, 29, 1, 'Dr. Marchand''s past revealed', 'Миналото на д-р Маршан е разкрито', false),
	(112, 29, 2, 'Hassan''s customs tag', 'Митническият етикет на Хасан', false),
	(113, 29, 3, 'Eliot''s political leaflet', 'Политическата листовка на Елиът', false),
	(114, 29, 4, 'Isadora''s \"vision\" about the murder', 'Видението на Исадора за убийството', false),
	(115, 30, 1, 'Blackmail letter traced to Eliot''s typewriter', 'Писмото за изнудване е проследено до пишещата машина на Елиът', false),
	(116, 30, 2, 'Clara''s debt ledger found in Crowthorne''s luggage', 'Дневникът с дългове на Клара е намерен в багажа на Кроуторн', false),
	(117, 30, 3, 'Franz seen near the rear car where the window opens', 'Франц е видян близо до задния вагон, където се отваря прозорецът', false),
	(118, 30, 4, 'Telegram received that Crowthorne was spotted alive in Belgrade', 'Получена е телеграма, че Кроуторн е забелязан жив в Белград', false),
	(200, NULL, NULL, 'Victim found stabbed 12 times in locked compartment', 'Жертвата е намерена с 12 прободни рани в заключено купе', false),
	(201, NULL, NULL, 'Murder weapon - ceremonial dagger with initials "E.M." engraved', 'Оръжие на убийството - церемониален кинжал с избродирани инициали "Е.М."', false),
	(202, NULL, NULL, 'Train stopped for 2 hours due to snowdrift (12:30 AM - 2:30 AM)', 'Влакът е спрян за 2 часа поради снежен занос (12:30 - 2:30 сутринта)', false),
	(203, NULL, NULL, 'Torn-up letter found in wastebasket, pieces missing', 'Разкъсано писмо намерено в кошчето, липсват парчета', false),
	(204, NULL, NULL, 'Compartment key found under victim''s body', 'Ключът на купето е намерен под тялото на жертвата', false),
	(206, NULL, NULL, 'Missing pieces of torn letter reveal it''s signed "Maria" and mentions "father"', 'Липсващите парчета от разкъсаното писмо разкриват, че е подписано "Мария" и споменава "татко"', false),
	(207, NULL, NULL, 'Viktor''s will was recently changed, cutting out Nikolai Ivanov completely', 'Завещанието на Виктор беше наскоро променено, като Николай Иванов е напълно изключен', false),
	(208, NULL, NULL, 'Viktor had traces of sedative in his system, likely administered 1-2 hours before death', 'Виктор имаше следи от успокоително в организма, вероятно приложено 1-2 часа преди смъртта', false),
	(210, NULL, NULL, 'Georgi claims he was in dining car, but dining car was closed after midnight', 'Георги твърди, че е бил в ресторант вагона, но ресторант вагонът беше затворен след полунощ', false),
	(212, NULL, NULL, 'Multiple fingerprints on dagger: victim''s, Elena''s, Maria''s, and one unidentified', 'Множество пръстови отпечатъци по кинжала: на жертвата, на Елена, на Мария и един неидентифициран', false),
	(213, NULL, NULL, 'Medical examiner confirms death between 1:30-2:00 AM based on body temperature', 'Съдебно-медицинският експерт потвърждава смъртта между 1:30-2:00 сутринта въз основа на телесната температура', false),
	(215, NULL, NULL, 'Second letter found in Viktor''s pocket mentions "exposing the truth about the factory accident"', 'Второ писмо намерено в джоба на Виктор споменава за "разкриване на истината за фабричния инцидент"', false),
	(216, NULL, NULL, 'Compartment door was locked from inside, and window was found slightly open with fresh snow on windowsill', 'Вратата на купето беше заключена отвътре, а прозорецът беше намерен леко отворен със свеж сняг на перваза', false),
	(220, NULL, NULL, 'Sofia was seen leaving her compartment at 1:00 AM, returning at 1:30 AM', 'София беше видяна да напуска купето си в 1:00 сутринта, връщайки се в 1:30 сутринта', false),
	(222, NULL, NULL, 'Elena was seen crying in her compartment at 1:10 AM, but refused to explain why', 'Елена беше видяна да плаче в купето си в 1:10 сутринта, но отказва да обясни защо', false),
	(230, NULL, NULL, 'Gold earring matching Irina''s found near victim''s compartment', 'Златната гривна на Ирина, намерена близо до купето на жертвата', false),
	(231, NULL, NULL, 'Witness saw Irina leaving Viktor''s compartment late at night, clutching a document', 'Свидетел видя Ирина да напуска купето на Виктор късно през нощта, държейки документ', false),
	(232, NULL, NULL, 'Business card of Mihail Todorov found in victim''s pocket', 'Визитка на Михаил Тодоров намерена в джоба на жертвата', false),
	(233, NULL, NULL, 'Conductor overheard Mihail asking about Viktor''s travel plans', 'Кондукторът дочу Михаил да се интересува от пътуването на Виктор', false),
	(234, NULL, NULL, 'Press credentials found in Vesela''s compartment under false name', 'Журналистически акредитации намерени в купето на Весела под фалшиво име', false),
	(235, NULL, NULL, 'Vesela was seen taking photographs of other passengers secretly', 'Весела беше видяна да прави тайни снимки на други пътници', false),
	(236, NULL, NULL, 'Stefan''s ticket shows he boarded at last minute, same station as Sofia', 'Билетът на Стефан показва, че се е качил в последния момент, от същата гара като София', false),
	(237, NULL, NULL, 'Stefan was seen arguing with Viktor in dining car before midnight', 'Стефан беше видян да се кара с Виктор в ресторант вагона преди полунощ', false),
	(205, NULL, NULL, 'Conductor saw someone in corridor at 1:45 AM wearing dark coat', 'Кондукторът видя някой в коридора в 1:45 сутринта, носещ тъмно палто', true),
	(211, NULL, NULL, 'Secret compartment in Viktor''s luggage contains blackmail photos of several passengers', 'Тайно отделение в багажа на Виктор съдържа снимки за изнудване на няколко пътници', true),
	(214, NULL, NULL, 'Small amount of blood found on corridor carpet outside Viktor''s compartment', 'Малко количество кръв намерено на килима в коридора извън купето на Виктор', true),
	(221, NULL, NULL, 'Georgi was seen near Viktor''s compartment at 1:20 AM, but claims he was checking security', 'Георги беше видян близо до купето на Виктор в 1:20 сутринта, но твърди, че е проверявал сигурността', true),
	(3000, NULL, NULL, 'Dave Martinez found dead in VIP lounge with blunt force trauma to the head', 'Дейв Мартинес е намерен мъртъв във VIP залата с травма на главата', false),
	(3001, NULL, NULL, 'Murder weapon - champagne bottle with fingerprints from multiple people', 'Оръжие на убийството - бутилка шампанско с пръстови отпечатъци от множество хора', false),
	(3002, NULL, NULL, 'Party started at 8 PM, Dave arrived at 9 PM, body found at 11:30 PM', 'Партито е започнало в 20:00, Дейв е пристигнал в 21:00, тялото му е намерено в 23:30', false),
	(3004, NULL, NULL, 'Dave''s phone found with threatening messages from multiple numbers', 'Телефонът на Дейв е намерен със заплашителни съобщения от няколко номера', false),
	(3005, NULL, NULL, 'VIP lounge door was locked from inside, window was found open', 'Вратата на VIP залата е била заключена отвътре, прозорецът е намерен отворен', false),
	(3006, NULL, NULL, 'Medical examiner confirms death between 11:00-11:30 PM', 'Съдебно-медицинският експерт потвърждава настъпване на смъртта между 23:00-23:30', false),
	(3007, NULL, NULL, 'Dave had traces of sedative in his system, likely administered 1-2 hours before death', 'Има следи от успокоително в организма на Дейв, вероятно приложено 1-2 часа преди смъртта', false),
	(3008, NULL, NULL, 'Several empty champagne bottles found in VIP lounge', 'Няколко празни бутилки шампанско са намерени във VIP залата', false),
	(3009, NULL, NULL, 'Dave''s wallet found empty, but he was paid $2000 for the performance', 'Портфейлът на Дейв е намерен празен, въпреки че му бяха платени $2000 за представлението', false),
	(3010, NULL, NULL, 'Sarah was seen arguing with Dave in the hallway at 10:45 PM, just before the music started', 'Сара беше видяна да се кара с Дейв в коридора в 22:45, точно преди музиката да започне', false),
	(3011, NULL, NULL, 'Amanda was seen giving Dave a drink around 9:30 PM', 'Аманда беше видяна да дава напитка на Дейв около 21:30', false),
	(3012, NULL, NULL, 'Jess was overheard saying "I can''t let him ruin everything" to someone on the phone', 'Джес беше дочута да казва "Не мога да позволя да развали всичко", говорейки с някого по телефона', false),
	(3013, NULL, NULL, 'Dave''s car keys found in the pool area, but his car is still in the parking lot', 'Ключовете на колата на Дейв са намерени в зоната на басейна, но колата му все още е на паркинга', false),
	(3014, NULL, NULL, 'Security log shows Dave entered the building at 9:05 PM through the service entrance', 'Охранителният дневник показва, че Дейв е влязъл в сградата в 21:05 през служебния вход', false),
	(3015, NULL, NULL, 'Dave''s performance contract shows he was supposed to leave by 11:00 PM', 'Договорът за ангажимент на Дейв показва, че е трябвало да напусне до 23:00', false),
	(3017, NULL, NULL, 'Bella was overheard saying "I need to protect him" to someone on the balcony', 'Бела беше дочута да казва "Трябва да го защитя", говорейки с някого на терасата', false),
	(3019, NULL, NULL, 'Vicky was seen following Dave in the first 20 minutes, after he arrived at the party', 'Вики беше забелязана да следва Дейв неотлъчно първите 20 минути, след като той пристигна на партито', false),
	(3021, NULL, NULL, 'Nikki was overheard saying "The operation is compromised" to someone', 'Ники беше дочута да казва "Операцията е компрометирана" на някого', false),
	(3023, NULL, NULL, 'Ash was the only person who knew the VIP lounge security code that evening', 'Аш беше единствената, която знаеше кода за сигурност на VIP залата тази вечер', false);


--
-- Data for Name: Clue_Rounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Clue_Rounds" ("clue_id", "round_id", "clue_number") VALUES
	(13, 5, 1),
	(78, 19, 3),
	(34, 10, 2),
	(109, 28, 3),
	(58, 15, 6),
	(102, 26, 4),
	(17, 6, 2),
	(54, 14, 4),
	(46, 13, 6),
	(9, 3, 3),
	(117, 30, 3),
	(73, 18, 2),
	(108, 28, 2),
	(53, 14, 5),
	(2, 1, 2),
	(63, 15, 1),
	(114, 29, 4),
	(12, 4, 3),
	(22, 7, 1),
	(111, 29, 1),
	(106, 27, 4),
	(25, 8, 2),
	(115, 30, 1),
	(11, 4, 2),
	(69, 17, 2),
	(55, 14, 3),
	(67, 16, 4),
	(71, 17, 4),
	(89, 23, 1),
	(3, 1, 3),
	(4, 2, 1),
	(65, 16, 2),
	(33, 10, 3),
	(24, 8, 3),
	(97, 25, 3),
	(118, 30, 4),
	(19, 7, 4),
	(23, 8, 4),
	(94, 24, 3),
	(85, 22, 1),
	(93, 24, 2),
	(40, 11, 1),
	(49, 13, 3),
	(42, 12, 4),
	(14, 5, 2),
	(77, 19, 2),
	(113, 29, 3),
	(68, 17, 1),
	(72, 18, 1),
	(18, 6, 3),
	(10, 4, 1),
	(6, 2, 3),
	(56, 14, 2),
	(27, 9, 4),
	(59, 15, 5),
	(52, 14, 6),
	(36, 11, 5),
	(20, 7, 3),
	(47, 13, 5),
	(79, 20, 1),
	(44, 12, 2),
	(82, 21, 1),
	(74, 18, 3),
	(1, 1, 1),
	(70, 17, 3),
	(28, 9, 3),
	(48, 13, 4),
	(107, 28, 1),
	(90, 23, 2),
	(45, 12, 1),
	(15, 5, 3),
	(91, 23, 3),
	(100, 26, 2),
	(64, 16, 1),
	(83, 21, 2),
	(112, 29, 2),
	(88, 22, 4),
	(87, 22, 3),
	(37, 11, 4),
	(110, 28, 4),
	(35, 10, 1),
	(80, 20, 2),
	(43, 12, 3),
	(105, 27, 3),
	(26, 8, 1),
	(96, 25, 2),
	(21, 7, 2),
	(66, 16, 3),
	(61, 15, 3),
	(81, 20, 3),
	(32, 10, 4),
	(30, 9, 1),
	(41, 12, 5),
	(31, 10, 5),
	(7, 3, 1),
	(16, 6, 1),
	(39, 11, 2),
	(62, 15, 2),
	(8, 3, 2),
	(75, 18, 4),
	(51, 13, 1),
	(99, 26, 1),
	(38, 11, 3),
	(103, 27, 1),
	(50, 13, 2),
	(60, 15, 4),
	(84, 21, 3),
	(92, 24, 1),
	(57, 14, 1),
	(98, 25, 4),
	(5, 2, 2),
	(76, 19, 1),
	(29, 9, 2),
	(95, 25, 1),
	(101, 26, 3),
	(116, 30, 2),
	(104, 27, 2),
	(86, 22, 2),
	(200, 31, 1),
	(201, 31, 2),
	(202, 31, 3),
	(203, 31, 4),
	(204, 31, 5),
	(205, 31, 6),
	(200, 36, 1),
	(201, 36, 2),
	(202, 36, 3),
	(203, 36, 4),
	(204, 36, 5),
	(205, 36, 6),
	(200, 41, 1),
	(201, 41, 2),
	(202, 41, 3),
	(203, 41, 4),
	(204, 41, 5),
	(205, 41, 6),
	(200, 46, 1),
	(201, 46, 2),
	(202, 46, 3),
	(203, 46, 4),
	(204, 46, 5),
	(205, 46, 6),
	(200, 51, 1),
	(201, 51, 2),
	(202, 51, 3),
	(203, 51, 4),
	(204, 51, 5),
	(205, 51, 6),
	(206, 33, 1),
	(207, 33, 2),
	(208, 33, 3),
	(210, 33, 4),
	(211, 33, 5),
	(212, 33, 6),
	(206, 38, 1),
	(207, 38, 2),
	(208, 38, 3),
	(210, 38, 4),
	(211, 38, 5),
	(212, 38, 6),
	(206, 43, 1),
	(207, 43, 2),
	(208, 43, 3),
	(210, 43, 4),
	(211, 43, 5),
	(212, 43, 6),
	(206, 48, 1),
	(207, 48, 2),
	(208, 48, 3),
	(210, 48, 4),
	(211, 48, 5),
	(212, 48, 6),
	(206, 53, 1),
	(207, 53, 2),
	(208, 53, 3),
	(210, 53, 4),
	(211, 53, 5),
	(212, 53, 6),
	(213, 35, 1),
	(214, 35, 2),
	(215, 35, 3),
	(216, 35, 4),
	(220, 35, 5),
	(221, 35, 6),
	(222, 35, 7),
	(213, 40, 1),
	(214, 40, 2),
	(215, 40, 3),
	(216, 40, 4),
	(220, 40, 5),
	(221, 40, 6),
	(222, 40, 7),
	(213, 45, 1),
	(214, 45, 2),
	(215, 45, 3),
	(216, 45, 4),
	(220, 45, 5),
	(221, 45, 6),
	(222, 45, 7),
	(213, 50, 1),
	(214, 50, 2),
	(215, 50, 3),
	(216, 50, 4),
	(220, 50, 5),
	(221, 50, 6),
	(222, 50, 7),
	(213, 55, 1),
	(214, 55, 2),
	(215, 55, 3),
	(216, 55, 4),
	(220, 55, 5),
	(221, 55, 6),
	(222, 55, 7),
	(230, 36, 8),
	(231, 38, 8),
	(232, 41, 8),
	(233, 43, 8),
	(234, 46, 8),
	(235, 48, 8),
	(236, 51, 8),
	(237, 53, 8),
	(3000, 60, 1),
	(3001, 60, 2),
	(3002, 60, 3),
	(3004, 60, 4),
	(3005, 60, 5),
	(3000, 65, 1),
	(3001, 65, 2),
	(3002, 65, 3),
	(3004, 65, 4),
	(3005, 65, 5),
	(3000, 70, 1),
	(3001, 70, 2),
	(3002, 70, 3),
	(3004, 70, 4),
	(3005, 70, 5),
	(3000, 75, 1),
	(3001, 75, 2),
	(3002, 75, 3),
	(3004, 75, 4),
	(3005, 75, 5),
	(3000, 80, 1),
	(3001, 80, 2),
	(3002, 80, 3),
	(3004, 80, 4),
	(3005, 80, 5),
	(3006, 62, 1),
	(3007, 62, 2),
	(3008, 62, 3),
	(3009, 62, 4),
	(3010, 62, 5),
	(3006, 67, 1),
	(3007, 67, 2),
	(3008, 67, 3),
	(3009, 67, 4),
	(3010, 67, 5),
	(3017, 67, 6),
	(3006, 72, 1),
	(3007, 72, 2),
	(3008, 72, 3),
	(3009, 72, 4),
	(3010, 72, 5),
	(3017, 72, 6),
	(3006, 77, 1),
	(3007, 77, 2),
	(3008, 77, 3),
	(3009, 77, 4),
	(3010, 77, 5),
	(3017, 77, 6),
	(3006, 82, 1),
	(3007, 82, 2),
	(3008, 82, 3),
	(3009, 82, 4),
	(3010, 82, 5),
	(3017, 82, 6),
	(3023, 82, 7),
	(3011, 64, 1),
	(3012, 64, 2),
	(3013, 64, 3),
	(3014, 64, 4),
	(3015, 64, 5),
	(3011, 69, 1),
	(3012, 69, 2),
	(3013, 69, 3),
	(3014, 69, 4),
	(3015, 69, 5),
	(3011, 74, 1),
	(3012, 74, 2),
	(3013, 74, 3),
	(3014, 74, 4),
	(3015, 74, 5),
	(3019, 74, 6),
	(3011, 79, 1),
	(3012, 79, 2),
	(3013, 79, 3),
	(3014, 79, 4),
	(3015, 79, 5),
	(3019, 79, 6),
	(3021, 79, 7),
	(3011, 84, 1),
	(3012, 84, 2),
	(3013, 84, 3),
	(3014, 84, 4),
	(3015, 84, 5),
	(3019, 84, 6),
	(3021, 84, 7);


--
-- Data for Name: Final_Reveal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Final_Reveal" ("reveal_id", "variation_id", "content", "murderer", "content_bg", "murderer_bg") VALUES
	(6, 6, 'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.', 'Dr. Lisette Marchand', 'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.', 'Д-р Лизет Маршан'),
	(7, 7, 'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.', 'Dr. Lisette Marchand', 'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.', 'Д-р Лизет Маршан'),
	(1, 1, 'She discovered Harold planned to divorce her and cut her from the will. She slipped cyanide into his brandy before dinner, knowing his habits. She planted misleading clues to frame Dr. Graves and Catherine.', 'Evelyn Langston was the murderer.', 'Тя откри, че Харалд планира да се разведе с нея и да я изключи от завещанието. Тя сложи цианид в бренди преди вечерята, знаейки неговите навици. Издирила подвеждащи улики, за да обвинят д-р Грейвс и Катрин.', 'Убийцата е Евелин Лангстън.'),
	(2, 2, 'She discovered Harold planned to divorce her and cut her from the will. She slipped cyanide into his brandy before dinner, knowing his habits. She planted misleading clues to frame Dr. Graves and Catherine.', 'Evelyn Langston was the murderer.', 'Тя откри, че Харалд планира да се разведе с нея и да я изключи от завещанието. Тя сложи цианид в бренди преди вечерята, знаейки неговите навици. Издирила подвеждащи улики, за да обвинят д-р Грейвс и Катрин.', 'Убийцата е Евелин Лангстън.'),
	(3, 3, 'She discovered Harold planned to divorce her and cut her from the will. She slipped cyanide into his brandy before dinner, knowing his habits. She planted misleading clues to frame Dr. Graves and Catherine.', 'Evelyn Langston was the murderer.', 'Тя откри, че Харалд планира да се разведе с нея и да я изключи от завещанието. Тя сложи цианид в бренди преди вечерята, знаейки неговите навици. Издирила подвеждащи улики, за да обвинят д-р Грейвс и Катрин.', 'Убийцата е Евелин Лангстън.'),
	(4, 4, 'She discovered Harold planned to divorce her and cut her from the will. She slipped cyanide into his brandy before dinner, knowing his habits. She planted misleading clues to frame Dr. Graves and Catherine.', 'Evelyn Langston was the murderer.', 'Тя откри, че Харалд планира да се разведе с нея и да я изключи от завещанието. Тя сложи цианид в бренди преди вечерята, знаейки неговите навици. Издирила подвеждащи улики, за да обвинят д-р Грейвс и Катрин.', 'Убийцата е Евелин Лангстън.'),
	(5, 5, 'She discovered Harold planned to divorce her and cut her from the will. She slipped cyanide into his brandy before dinner, knowing his habits. She planted misleading clues to frame Dr. Graves and Catherine.', 'Evelyn Langston was the murderer.', 'Тя откри, че Харалд планира да се разведе с нея и да я изключи от завещанието. Тя сложи цианид в бренди преди вечерята, знаейки неговите навици. Издирила подвеждащи улики, за да обвинят д-р Грейвс и Катрин.', 'Убийцата е Евелин Лангстън.'),
	(8, 8, 'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.', 'Dr. Lisette Marchand', 'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.', 'Д-р Лизет Маршан'),
	(9, 9, 'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.', 'Dr. Lisette Marchand', 'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.', 'Д-р Лизет Маршан'),
	(10, 10, 'Dr. Lisette Marchand killed Crowthorne with poison and staged the scene with a dagger. She was motivated by revenge for Crowthorne funding unethical medical research in Africa, which led to her sister''s death. Her medical expertise allowed her to administer the poison undetected, and she used the ceremonial dagger to mislead investigators into believing a violent murder had occurred.', 'Dr. Lisette Marchand', 'Д-р Лизет Маршан убива Кроуторн с отрова и инсценира сцената с кинжал. Тя е мотивирана от отмъщение, тъй като Кроуторн финансира неетични медицински изследвания в Африка, които доведоха до смъртта на сестра ѝ. Нейната медицинска експертиза ѝ позволи да приложи отровата незабелязано, а церемониалният кинжал беше използван, за да подведе разследващите, че е станало брутално убийство.', 'Д-р Лизет Маршан'),
	(11, 11, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Maria Petrova', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира.', 'Мария Петрова'),
	(12, 12, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Maria Petrova', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Мария Петрова'),
	(13, 13, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Maria Petrova', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Мария Петрова'),
	(14, 14, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Maria Petrova', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Мария Петрова'),
	(15, 15, 'The murder of Viktor Petrov was committed by Maria Petrova, his estranged daughter. Driven by years of emotional abuse and the recent discovery that Viktor was planning to disinherit her completely, Maria saw an opportunity during the train''s unscheduled stop. She used the ceremonial dagger (a family heirloom with her mother''s initials "E.M.") to kill her father. The sedative in Viktor''s system was administered by Sofia Dimitrova, who was helping Maria but didn''t know about the murder plan. The blackmail photos in Viktor''s luggage were of various passengers, including evidence of Nikolai''s embezzlement and Elena''s family scandal, which he used to control them.', 'Maria Petrova', 'Убийството на Виктор Петров е извършено от Мария Петрова, неговата отчуждена дъщеря. Подтикната от години емоционално насилие и наскорошното откритие, че Виктор планира да я лиши напълно от наследство, Мария видя възможност по време на незапланираната спирка на влака. Тя използва церемониалния кинжал (семейна реликвания с инициалите на майка ѝ "Е.М.") за да убие баща си. Успокоителното в системата на Виктор е приложено от София Димитрова, която помагаше на Мария, но не знаеше за плана за убийство. Снимките за изнудване в багажа на Виктор бяха на различни пътници, включително доказателства за присвояването на Николай и семейния скандал на Елена, които той използваше за да ги контролира. ', 'Мария Петрова'),
	(16, 16, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Sarah Mitchell', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Сара Митчъл'),
	(17, 17, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Sarah Mitchell', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Сара Митчъл'),
	(18, 18, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Sarah Mitchell', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Сара Митчъл'),
	(19, 19, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Sarah Mitchell', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Сара Митчъл'),
	(20, 20, 'The murder of "Diamond" Dave Martinez was committed by Sarah Mitchell, the bride-to-be. Driven to desperation by Dave''s relentless blackmail and the threat of her secrets being exposed on her wedding day, Sarah saw an opportunity during the chaotic party. She lured Dave to the VIP lounge under the pretense of a private performance, then struck him with a champagne bottle when his back was turned. The sedative in Dave''s system was administered by Amanda Chen, who was trying to sedate Dave so that he won''t expose her secret, but didn''t know about the murder plan. Dave''s criminal activities included drug trafficking, money laundering, and blackmailing multiple women.', 'Sarah Mitchell', 'Убийството на "Даймънд" Дейв Мартинес е извършено от Сара Митчъл, бъдещата булка. Подтикната до отчаяние от безмилостното изнудване на Дейв и заплахата тайните ѝ да бъдат разкрити по време на сватбения ѝ ден, Сара използва открилата се възможност по време на хаотичното парти. Тя примами Дейв във VIP залата под претекст, че иска частно представление, след което го удари с бутилка шампанско, когато той беше обърнат с гръб. Успокоителното в системата на Дейв е приложено от Аманда Чен, която се опитваше да приспи Дейв за да не издаде нейната тайна, но не знаеше за плана за убийство. Престъпните дейности на Дейв включваха трафик на наркотици, пране на пари и изнудване на множество жени.', 'Сара Митчъл');


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Users" ("user_id", "email", "created_at") VALUES
	('b77eb296-aac0-4be4-8eee-2d3ab9ffe238', 'speechsaver@gmail.com', '2025-06-10 14:56:33.815446'),
	('d34665c7-ff2c-4463-b71c-a824e0eea077', 'djlabs93@gmail.com', '2025-06-11 13:43:33.417923'),
	('1547d5f6-6d28-4669-a470-842031db5f96', 'dushkovd@gmail.com', '2025-06-11 15:31:40.790971'),
	('c2430400-f839-4258-96c8-3c98c2cb2d21', 'darkdevil15@abv.bg', '2025-06-11 16:08:27.092148'),
	('1799495b-666e-4163-9284-db99463e4bb7', 'darkdevil115@abv.bg', '2025-06-11 16:09:25.124873'),
	('bee45fd2-1445-4d8e-b8fc-d5c74c256b39', 'emkal@abv.bg', '2025-06-19 09:10:22.361024'),
	('96fc2b71-1dc8-41ec-84bb-5adfcb151da2', 'dushkovddushkovd@gmail.com', '2025-06-19 16:26:07.178555'),
	('64c3fd45-7c2f-466e-bc4c-c66aab216979', 'ivan.markov13@yahoo.com', '2025-06-22 16:09:36.557296'),
	('05b02cac-a6bb-445d-ab72-d49282960440', 'hddobrev@gmail.com', '2025-07-08 19:30:53.802535');


--
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Orders" ("order_id", "user_id", "order_date", "total_amount", "status", "payment_intent_id") VALUES
	(14, 'd34665c7-ff2c-4463-b71c-a824e0eea077', '2025-06-11 14:00:34.924717', 29.99, 'completed', NULL),
	(18, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-06-11 16:08:32.948342', 29.99, 'completed', NULL),
	(19, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-06-12 08:40:03.649793', 29.99, 'completed', NULL),
	(20, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-06-12 08:40:16.776584', 29.99, 'completed', NULL),
	(21, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-06-12 08:49:01.425611', 29.99, 'completed', NULL),
	(22, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-06-12 11:22:30.768873', 29.99, 'completed', NULL),
	(23, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:15:13.197379', 29.99, 'completed', 'pi_3RZZJzIvFYUO307F1v1kql3d'),
	(24, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:16:11.643717', 29.99, 'completed', 'pi_3RZZKwIvFYUO307F2Cop8Puv'),
	(25, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:20:58.483056', 29.99, 'completed', 'pi_3RZZPZIvFYUO307F14eJU94G'),
	(26, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:27:11.512982', 29.99, 'completed', 'pi_3RZZVaIvFYUO307F0BlVLizL'),
	(27, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:29:26.129592', 29.99, 'completed', 'pi_3RZZXkIvFYUO307F0ffSkb9w'),
	(28, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:34:28.189135', 29.99, 'completed', 'pi_3RZZccIvFYUO307F2tyftZWd'),
	(29, '1799495b-666e-4163-9284-db99463e4bb7', '2025-06-13 15:40:39.915829', 29.99, 'completed', 'pi_3RZZicIvFYUO307F2vXsYAQx'),
	(30, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-13 15:57:57.517075', 29.99, 'completed', 'pi_3RZZzMIvFYUO307F28jXri8v'),
	(31, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-13 16:07:27.173038', 29.99, 'completed', 'pi_3RZa8XIvFYUO307F2FH5bTA3'),
	(32, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-15 19:46:28.797928', 29.99, 'completed', 'pi_3RaMVbIvFYUO307F0WJMjZZk'),
	(33, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-17 13:27:32.229302', 29.99, 'completed', 'pi_3RazXyIvFYUO307F0jCyySOi'),
	(34, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-17 15:13:31.280101', 39.99, 'completed', 'pi_3Rb1CXIvFYUO307F1y2Hodsb'),
	(35, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-18 16:50:42.597526', 29.99, 'completed', 'pi_3RbPC8IvFYUO307F0Anb1fSs'),
	(36, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-18 16:57:42.701447', 29.99, 'completed', 'pi_3RbPIuIvFYUO307F1AqbZDH9'),
	(37, 'bee45fd2-1445-4d8e-b8fc-d5c74c256b39', '2025-06-19 09:12:23.586119', 29.99, 'completed', 'pi_3RbeWAIvFYUO307F1KR5z5DS'),
	(38, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:19:54.911289', 14.99, 'completed', 'pi_3Rc233IvFYUO307F0FEnbAcm'),
	(39, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:23:37.29789', 14.99, 'completed', 'pi_3Rc26dIvFYUO307F2cyovIXJ'),
	(40, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:24:15.06269', 14.99, 'completed', 'pi_3Rc27FIvFYUO307F2OPaewjE'),
	(41, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:25:41.868798', 14.99, 'completed', 'pi_3Rc28eIvFYUO307F0Gon991I'),
	(42, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:26:35.828893', 14.99, 'completed', 'pi_3Rc29WIvFYUO307F17g0U8B7'),
	(43, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:33:15.878624', 14.99, 'completed', 'pi_3Rc2FyIvFYUO307F0p60t2kA'),
	(44, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:34:34.930538', 14.99, 'completed', 'pi_3Rc2HFIvFYUO307F1VqzzeUt'),
	(45, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:35:20.823473', 14.99, 'completed', 'pi_3Rc2HzIvFYUO307F2ITJQlQH'),
	(46, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 10:43:35.524538', 14.99, 'completed', 'pi_3Rc2PxIvFYUO307F2h6f5JNY'),
	(47, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 12:02:27.348718', 14.99, 'completed', 'pi_3Rc3eHIvFYUO307F0UgmVaba'),
	(48, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 12:03:20.858678', 14.99, 'completed', 'pi_3Rc3f9IvFYUO307F1p8bVDyV'),
	(49, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 12:07:33.784016', 14.99, 'completed', 'pi_3Rc3jEIvFYUO307F0I8XYeAc'),
	(50, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 13:20:27.576465', 14.99, 'completed', 'pi_3Rc4rlIvFYUO307F1oLqEj8T'),
	(51, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 13:41:27.292196', 14.99, 'completed', 'pi_3Rc5C5IvFYUO307F0ZWFYec4'),
	(52, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 13:46:34.21737', 14.99, 'completed', 'pi_3Rc5H2IvFYUO307F2g6yTgXn'),
	(53, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-20 14:32:22.32403', 14.99, 'completed', 'pi_3Rc5zMIvFYUO307F0IG8aUA8'),
	(54, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-23 08:07:06.113691', 14.99, 'completed', 'pi_3Rd5PAIvFYUO307F1U0sCVUo'),
	(55, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-24 11:40:55.02078', 14.99, 'completed', 'pi_3RdVDdIvFYUO307F2anRp4Ld'),
	(56, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-06-25 15:37:04.940114', 14.99, 'completed', 'pi_3RdvNjIvFYUO307F0kZSLM2C'),
	(57, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-08 13:12:08.391987', 14.99, 'completed', 'pi_3RibJaIvFYUO307F04zqJsSk'),
	(58, '05b02cac-a6bb-445d-ab72-d49282960440', '2025-07-08 19:31:24.216588', 14.99, 'completed', 'pi_3RihEcIvFYUO307F2UCTUugP'),
	(59, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-11 14:46:29.06463', 44.99, 'completed', 'pi_3RjiDXIvFYUO307F0rbWaI0E'),
	(60, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-07-25 13:18:06.243285', 14.99, 'completed', 'pi_3RolVgIvFYUO307F2oCYySoN'),
	(61, 'c2430400-f839-4258-96c8-3c98c2cb2d21', '2025-07-25 13:18:21.727859', 14.99, 'completed', 'pi_3RolVwIvFYUO307F1h7twEKy'),
	(62, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:18:59.824448', 14.99, 'completed', 'pi_3RolWYIvFYUO307F0vprJG3c'),
	(63, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:20:06.701167', 14.99, 'completed', 'pi_3RolXcIvFYUO307F2zepToZg'),
	(64, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:32:29.49851', 14.99, 'completed', 'pi_3RoljbIvFYUO307F1ZYSPBxH'),
	(65, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:32:39.493605', 14.99, 'completed', 'pi_3RoljlIvFYUO307F1blLOk1E'),
	(66, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:33:20.080898', 14.99, 'completed', 'pi_3RolkQIvFYUO307F1NmKSXwf'),
	(67, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 13:53:00.598547', 14.99, 'completed', 'pi_3Rom3SIvFYUO307F0yp4gyQk'),
	(68, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 14:05:20.582615', 14.99, 'completed', 'pi_3RomFPIvFYUO307F2tHETdZy'),
	(69, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 14:14:03.739209', 14.99, 'completed', 'pi_3RomNpIvFYUO307F24NlNDn8'),
	(70, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 14:14:35.197764', 14.99, 'completed', 'pi_3RomOLIvFYUO307F2q4QSp8W'),
	(71, '1547d5f6-6d28-4669-a470-842031db5f96', '2025-07-25 14:15:13.779944', 14.99, 'completed', 'pi_3RomOyIvFYUO307F1XkxuvTq');


--
-- Data for Name: Order_Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."Order_Items" ("order_item_id", "order_id", "game_id", "price", "quantity", "created_at") VALUES
	(1, 14, 1, 29.99, 1, '2025-06-13 15:20:22.698213+00'),
	(2, 18, 1, 29.99, 1, '2025-06-13 15:20:22.698213+00'),
	(5, 21, 1, 29.99, 1, '2025-06-13 15:20:22.698213+00'),
	(6, 22, 1, 29.99, 1, '2025-06-13 15:20:22.698213+00'),
	(9, 27, 1, 29.99, 1, '2025-06-13 15:29:26.23409+00'),
	(10, 28, 1, 29.99, 1, '2025-06-13 15:34:28.361564+00'),
	(11, 29, 1, 29.99, 1, '2025-06-13 15:40:40.017258+00'),
	(12, 30, 1, 29.99, 1, '2025-06-13 15:57:57.626577+00'),
	(13, 31, 1, 29.99, 1, '2025-06-13 16:07:27.288386+00'),
	(14, 32, 1, 29.99, 1, '2025-06-15 19:46:28.933484+00'),
	(15, 33, 1, 29.99, 1, '2025-06-17 13:27:32.482057+00'),
	(16, 34, 2, 39.99, 1, '2025-06-17 15:13:31.414564+00'),
	(17, 35, 1, 29.99, 1, '2025-06-18 16:50:42.761169+00'),
	(18, 36, 1, 29.99, 1, '2025-06-18 16:57:42.86054+00'),
	(19, 37, 1, 29.99, 1, '2025-06-19 09:12:23.727519+00'),
	(20, 38, 2, 14.99, 1, '2025-06-20 10:19:55.062946+00'),
	(21, 39, 2, 14.99, 1, '2025-06-20 10:23:37.403556+00'),
	(22, 40, 1, 14.99, 1, '2025-06-20 10:24:15.172351+00'),
	(23, 41, 2, 14.99, 1, '2025-06-20 10:25:41.976287+00'),
	(24, 42, 2, 14.99, 1, '2025-06-20 10:26:35.953477+00'),
	(25, 43, 2, 14.99, 1, '2025-06-20 10:33:15.996816+00'),
	(26, 44, 2, 14.99, 1, '2025-06-20 10:34:35.037819+00'),
	(27, 45, 2, 14.99, 1, '2025-06-20 10:35:20.927615+00'),
	(28, 46, 2, 14.99, 1, '2025-06-20 10:43:35.634852+00'),
	(29, 47, 2, 14.99, 1, '2025-06-20 12:02:27.50133+00'),
	(30, 48, 2, 14.99, 1, '2025-06-20 12:03:20.959525+00'),
	(31, 49, 2, 14.99, 1, '2025-06-20 12:07:33.888787+00'),
	(32, 50, 1, 14.99, 1, '2025-06-20 13:20:27.711156+00'),
	(33, 51, 1, 14.99, 1, '2025-06-20 13:41:27.405304+00'),
	(34, 52, 1, 14.99, 1, '2025-06-20 13:46:34.342062+00'),
	(35, 53, 1, 14.99, 1, '2025-06-20 14:32:22.49105+00'),
	(36, 54, 1, 14.99, 1, '2025-06-23 08:07:06.233617+00'),
	(37, 55, 1, 14.99, 1, '2025-06-24 11:40:55.147848+00'),
	(38, 56, 2, 14.99, 1, '2025-06-25 15:37:05.201192+00'),
	(39, 57, 2, 14.99, 1, '2025-07-08 13:12:08.545383+00'),
	(40, 58, 1, 14.99, 1, '2025-07-08 19:31:24.520046+00'),
	(41, 59, 3, 44.99, 1, '2025-07-11 14:46:29.214785+00'),
	(53, 69, 3, 14.99, 1, '2025-07-25 14:14:03.891016+00'),
	(54, 70, 4, 14.99, 1, '2025-07-25 14:14:35.3056+00'),
	(55, 71, 4, 14.99, 1, '2025-07-25 14:15:13.893337+00');


--
-- Data for Name: User_Game_Access; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."User_Game_Access" ("user_id", "game_id", "access_granted") VALUES
	('c2430400-f839-4258-96c8-3c98c2cb2d21', 1, '2025-06-12 08:49:01.519147'),
	('1799495b-666e-4163-9284-db99463e4bb7', 1, '2025-06-13 15:29:26.23409'),
	('1547d5f6-6d28-4669-a470-842031db5f96', 1, '2025-06-13 15:57:57.626577'),
	('1547d5f6-6d28-4669-a470-842031db5f96', 2, '2025-06-17 15:13:31.414564'),
	('bee45fd2-1445-4d8e-b8fc-d5c74c256b39', 1, '2025-06-19 09:12:23.727519'),
	('05b02cac-a6bb-445d-ab72-d49282960440', 1, '2025-07-08 19:31:24.520046'),
	('1547d5f6-6d28-4669-a470-842031db5f96', 3, '2025-07-11 14:46:29.214785'),
	('1547d5f6-6d28-4669-a470-842031db5f96', 4, '2025-07-25 14:14:35.3056');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id") VALUES
	('game-images', 'game-images', NULL, '2025-06-20 09:44:01.931249+00', '2025-06-20 09:44:01.931249+00', true, false, 5242880, '{image/jpeg,image/png,image/webp,image/gif}', NULL);


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('46acfb9a-7eef-4114-88e9-aa8e989cb369', 'game-images', '1/.emptyFolderPlaceholder', NULL, '2025-06-20 10:07:41.534461+00', '2025-06-20 10:07:41.534461+00', '2025-06-20 10:07:41.534461+00', '{"eTag": "\"d41d8cd98f00b204e9800998ecf8427e\"", "size": 0, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-06-20T10:07:42.000Z", "contentLength": 0, "httpStatusCode": 200}', 'cdf98cd7-6f36-4b5f-b499-0900e9d65da6', NULL, '{}'),
	('d37b8a61-56b4-423d-8256-72366a6d25f9', 'game-images', '2/.emptyFolderPlaceholder', NULL, '2025-06-20 10:07:44.86526+00', '2025-06-20 10:07:44.86526+00', '2025-06-20 10:07:44.86526+00', '{"eTag": "\"d41d8cd98f00b204e9800998ecf8427e\"", "size": 0, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-06-20T10:07:45.000Z", "contentLength": 0, "httpStatusCode": 200}', '2d05a796-40fc-4a24-ba03-f9f7b6bb4aa2', NULL, '{}'),
	('175b55cd-4dc4-4df5-ae55-b0a00860eaab', 'game-images', '2/Midnight_express.jpeg', NULL, '2025-06-20 10:01:41.278899+00', '2025-06-20 10:07:54.457753+00', '2025-06-20 10:01:41.278899+00', '{"eTag": "\"c655c5d04bdf005d9b7d7d534dd8518d\"", "size": 104697, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-20T10:07:55.000Z", "contentLength": 104697, "httpStatusCode": 200}', '35f88c53-cb65-422b-9b60-530d2d7b4098', NULL, NULL),
	('85d60fa1-8ff3-4fe7-ae1b-dd6237d273f8', 'game-images', '1/Rosewood.jpeg', NULL, '2025-06-20 10:06:52.348954+00', '2025-06-20 10:08:01.289683+00', '2025-06-20 10:06:52.348954+00', '{"eTag": "\"4bd2722f6e145d9e1cdd26b327280be4\"", "size": 150084, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-20T10:08:02.000Z", "contentLength": 150084, "httpStatusCode": 200}', 'd32e331e-5a1f-4011-a2da-334d6aab11a8', NULL, NULL),
	('b41ee041-1f2c-451f-b215-c97186ad428d', 'game-images', '3/Orient_express.jpg', NULL, '2025-07-14 14:13:43.758231+00', '2025-07-14 14:13:43.758231+00', '2025-07-14 14:13:43.758231+00', '{"eTag": "\"55cc12b6f0bc701929c63b45909ebfe8-1\"", "size": 74507, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-14T14:13:44.000Z", "contentLength": 74507, "httpStatusCode": 200}', '165acc11-8292-4179-a471-8db7eb3e0843', NULL, NULL),
	('f2d5d9fa-0639-4ee0-815a-2462c3578f09', 'game-images', '3/Orient_express22_first_round.png', NULL, '2025-07-18 09:28:36.275556+00', '2025-07-18 09:28:36.275556+00', '2025-07-18 09:28:36.275556+00', '{"eTag": "\"16a97a71ef2034c653db38605fee0736-1\"", "size": 95737, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-07-18T09:28:36.000Z", "contentLength": 95737, "httpStatusCode": 200}', '2727f9bb-98e6-49e0-8c48-b1843df66e6d', NULL, NULL),
	('f25a828a-9164-4015-9d43-9d09038ce9e5', 'game-images', '3/Orient_express22_1_game_rules.png', NULL, '2025-07-18 09:28:36.344183+00', '2025-07-18 09:28:36.344183+00', '2025-07-18 09:28:36.344183+00', '{"eTag": "\"f09893c0a1b89b6dfcb2ffb163cb3cd4-1\"", "size": 119485, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-07-18T09:28:36.000Z", "contentLength": 119485, "httpStatusCode": 200}', '3766afab-3583-4194-8cc2-1f4be0fc746a', NULL, NULL),
	('7c2f8b95-8a34-44ae-af68-f8d52ed1956f', 'game-images', '3/Orient_express22_secret_revelation (1).png', NULL, '2025-07-18 09:29:58.738584+00', '2025-07-18 09:29:58.738584+00', '2025-07-18 09:29:58.738584+00', '{"eTag": "\"6ada9c9f0d132c02bc4fa58835278562-1\"", "size": 72574, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-07-18T09:29:59.000Z", "contentLength": 72574, "httpStatusCode": 200}', '80dd546f-a39b-4205-a80e-16c12e7847a1', NULL, NULL),
	('7ba0d149-459c-4e85-989f-c0ab47c7861d', 'game-images', '4/bachelorette_party.png', NULL, '2025-07-25 13:05:42.688148+00', '2025-07-25 13:05:42.688148+00', '2025-07-25 13:05:42.688148+00', '{"eTag": "\"44ed6a3def329afeb0cd9bd82be05fdd-1\"", "size": 1099201, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-07-25T13:05:43.000Z", "contentLength": 1099201, "httpStatusCode": 200}', '8ac1172d-137e-478f-ba7a-d0d307313f6c', NULL, NULL);


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 114, true);


--
-- Name: Characters_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Characters_character_id_seq"', 1012, true);


--
-- Name: Clues_clue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Clues_clue_id_seq"', 3023, true);


--
-- Name: Final_Reveal_reveal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Final_Reveal_reveal_id_seq"', 20, true);


--
-- Name: Game_Variations_variation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Game_Variations_variation_id_seq"', 20, true);


--
-- Name: Games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Games_game_id_seq"', 4, true);


--
-- Name: Order_Items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Order_Items_order_item_id_seq"', 55, true);


--
-- Name: Orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Orders_order_id_seq"', 71, true);


--
-- Name: Rounds_round_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."Rounds_round_id_seq"', 84, true);


--
-- Name: new_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."new_character_id_seq"', 1002, true);


--
-- Name: new_clue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."new_clue_id_seq"', 2002, true);


--
-- PostgreSQL database dump complete
--

RESET ALL;
