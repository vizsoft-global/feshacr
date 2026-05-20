# Feshah Firestore reference

**Firebase project:** `feshah-thbit`  
**Purpose:** Single reference for collections, fields, indexes, rules, and related backend behavior used by the Flutter app.

**Source of truth:** This document is derived from:

- `lib/backend/schema/*_record.dart` (FlutterFlow-generated Firestore models)
- `lib/backend/schema/structs/*.dart` (embedded maps and lists)
- `firebase/firestore.rules`
- `firebase/firestore.indexes.json`
- `firebase/functions/index.js` (collections touched outside the Dart schema)

When the app or FlutterFlow regenerates schema files, **update this document** or diff against `_record.dart` comments (they list Firestore field keys).

---

## Conventions

| Topic | Detail |
|--------|--------|
| **Document IDs** | Often auto-IDs; `users` documents typically match Firebase Auth **UID** (see rules). |
| **Field naming** | Firestore keys use **snake_case** (e.g. `room_user_list`, `game_ID`). |
| **Structs** | Nested objects and list-of-map values map to Dart `*Struct` types under `lib/backend/schema/structs/`. |
| **Timestamps** | Stored as Firestore `Timestamp`; Dart models expose `DateTime?` where applicable. |
| **References** | `DocumentReference` fields appear as `*Ref` or `*_userRef` in rules and data. |

---

## Top-level collections (Dart schema)

All paths are under `databases/(default)/documents/`.

### `users`

| Firestore field | Type / notes |
|-----------------|----------------|
| `email` | string |
| `display_name` | string |
| `photo_url` | string |
| `uid` | string |
| `created_time` | timestamp |
| `phone_number` | string |
| `status` | string |
| `user_role` | string |
| `user_id` | int (app-level numeric id) |
| `wallet_Point` | int |
| `country` | string |
| `language` | string |
| `wallet_Spent` | int |
| `present_room_game_info` | map → `PresentRoomGameInfoStruct` |
| `date_birth` | timestamp |
| `gender` | string |
| `user_setting` | map → `UserSettingStruct` |
| `user_address` | map → `UserAddressStruct` |
| `complete_profile_status` | bool |
| `user_verification` | map → `UserVerificationStruct` |
| `is_phone_verification` | bool |
| `is_walkthrough_status` | bool |
| `app_launch_time_user` | bool |

**Subcollection (not in Dart record; used by Cloud Functions):** `users/{userId}/fcm_tokens/{tokenDoc}` — see [Push & FCM](#push--fcm).

---

### `room`

Core multiplayer “lobby” state: members, wallet mode, and **`selected_game_list`** (per-session game state machine).

| Firestore field | Type / notes |
|-----------------|----------------|
| `room_status` | string |
| `room_created_at` | timestamp |
| `room_main_info` | map → `MainInfoStruct` |
| `room_member_limit` | int |
| `room_current_user_id` | int |
| `room_updated_at` | timestamp |
| `room_ID` | int |
| `room_info` | map → `RoomInfoStruct` |
| `room_created_by_uid` | string |
| `room_created_by` | string |
| `room_created_userRef` | DocumentReference → `users` |
| `room_user_list` | list of maps → `RoomUserListStruct` |
| `is_room_wallet_status` | bool |
| `room_wallet_total_point` | int |
| `room_wallet_order_info` | list of maps → `RoomWalletOrderInfoStruct` |
| `selected_game_list` | list of maps → **`SelectedGameListStruct`** (game rounds, SAU steps, teams, questions) |
| `room_code` | int |
| `room_present_status` | string |
| `room_type` | string (e.g. `solo`) |
| `room_attended_question_list` | list of int |
| `room_app_launch_time` | bool |

**Important embedded struct:** `SelectedGameListStruct` is large; it holds `game_id`, `gameSAUStep`, `gameSAU`, `selectedGameUserList`, tie-break fields, topic/question id lists, etc. See `lib/backend/schema/structs/selected_game_list_struct.dart`.

---

### `game`

Catalog rows for playable games (metadata, points, translations).

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `game_ID` | int (**business id**, e.g. `1005` = Hot Potato / Game Six path in app) |
| `game_status` | string (e.g. `active`) |
| `game_info` | map → `MainInfoStruct` |
| `game_point` | int |
| `game_info_translate` | map → `TranslateInfoStruct` |
| `game_info_manual_translate` | map → `TranslateInfoStruct` |

---

### `game_history`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `game_history_ID` | int |
| `game_id` | int |
| `user_id` | int |
| `user_ref` | DocumentReference → `users` |
| `room_id` | int |
| `result_info` | map → `ResultInfoStruct` |
| `session_id` | string |

---

### `topic`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `topic_ID` | int |
| `topic_status` | string |
| `topic_info` | map → `MainInfoStruct` |
| `game_ref` | DocumentReference → `game` |
| `game_ID` | list of int (array-contains queries in indexes) |
| `topic_info_translate` | map → `TranslateInfoStruct` |
| `topic_info_manual_translate` | map → `TranslateInfoStruct` |
| `topic_main_id` | int |

---

### `topic_question`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `question_ID` | int |
| `question_status` | string |
| `question_Info` | map → `QuestionInfoStruct` |
| `question_point` | int |
| `topic_ref` | DocumentReference → `topic` |
| `topic_id` | int |
| `question_type` | string |
| `question_Info_translate` | map → `QuestionInfoTranslateStruct` |
| `question_Info_translate_manual` | map → `QuestionInfoTranslateStruct` |
| `question_main_id` | int |

---

### `order`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `order_ID` | int |
| `order_status` | string |
| `order_amount` | double |
| `order_user_main_info` | map → `OrderUserMainInfoStruct` |
| `order_payment_info` | map → `OrderPaymentInfoStruct` |
| `order_cart_item` | list of maps → `OrderCartItemStruct` |
| `order_userRef` | DocumentReference → `users` |
| `order_type` | string |
| `order_coupon_info` | map → `CouponCartInfoStruct` |

---

### `point`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `main_info` | map → `MainInfoStruct` |
| `point_info` | list of maps → `PointInfoStruct` |
| `point_status` | string |
| `point_ID` | int |
| `main_info_translate` | map → `TranslateInfoStruct` |
| `main_info_manual_translate` | map → `TranslateInfoStruct` |

---

### `wallet_spent`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `wallet_spent_ID` | int |
| `wallet_spent_status` | string |
| `wallet_spent_point` | int |
| `wallet_spent_room_ref` | DocumentReference → `room` |
| `wallet_spent_game_ref` | DocumentReference → `game` |
| `wallet_spent_user_ref` | DocumentReference → `users` |
| `wallet_spent_prev_point` | int |
| `wallet_spent_present_point` | int |

---

### `notification`

| Firestore field | Type / notes |
|-----------------|----------------|
| `created_at` | timestamp |
| `updated_at` | timestamp |
| `notification_ID` | int |
| `notification_status` | string |
| `to_userRef` | DocumentReference → `users` |
| `from_userRef` | DocumentReference → `users` |
| `room_info` | map → `RoomInfoStruct` |
| `game_info` | map → `MainInfoStruct` |
| `notification_type` | string (e.g. `game_invite`) |
| `notification_from` | string |

---

### `settings`

App-wide / company configuration documents (queried by `type`, e.g. `Company`).

| Firestore field | Type / notes |
|-----------------|----------------|
| `type` | string |
| `settings_payment_info` | map → `SettingsPaymentInfoStruct` |
| `settings_app_version_info` | map → `SettingsAppVersionInfoStruct` |
| `settings_company_info` | map → `SettingsCompanyInfoStruct` |
| `settings_inapp_purchase_status` | bool |
| `settings_social_login` | map → `SettingsSocialLoginStruct` |
| `settings_sponsor_info` | map (sponsor-related config) |
| `settings_otpless` | map |
| `settings_new_reg_coins` | int |
| `settings_new_room_coins` | int |

---

### `payment_response`

| Firestore field | Type / notes |
|-----------------|----------------|
| `order_id` | string |
| `payment_id` | string |
| `payment_type` | string |
| `status` | string |
| `track_id` | string |

---

### `coupon`

| Firestore field | Type / notes |
|-----------------|----------------|
| `coupon_created_at` | timestamp |
| `coupon_discount_amount_value` | double |
| `coupon_discount_type` | string |
| `coupon_end_date` | timestamp |
| `coupon_for` | string |
| `coupon_id` | int |
| `coupon_main_info` | map → `MainInfoStruct` |
| `coupon_maximum_amount` | double |
| `coupon_maximum_discount` | double |
| `coupon_member_limit` | int |
| `coupon_minimum_amount` | double |
| `coupon_start_date` | timestamp |
| `coupon_status` | string |
| `coupon_user_list` | list of DocumentReference |
| `coupon_user_type` | string |
| `coupon_value` | double |
| `coupon_used_user_list` | list of DocumentReference |

---

### `IDmap`

Counter / id-mapping documents used when allocating next numeric ids (`select_game_id`, etc.). Field set is wide; many may be unused per document type.

| Firestore field | Type / notes |
|-----------------|----------------|
| `type` | string |
| `room_id` | int |
| `point_id` | int |
| `order_id` | int |
| `game_id` | int |
| `topic_id` | int |
| `group_id` | int |
| `question_id` | int |
| `team_id` | int |
| `history_id` | int |
| `notification_id` | int |
| **`select_game_id`** | int (incremented when starting a game session) |
| `wallet_spent_id` | int |
| `round_id` | int |
| `round_result_id` | int |
| `vote_id` | int |
| `coupon_id` | int |

---

## Collections used by Cloud Functions (not in Dart `*_record.dart`)

| Collection | Role |
|------------|------|
| **`ff_push_notifications`** | Documents created to trigger outbound FCM; `functions/index.js` listens `onCreate` and sends push (skips rows with `scheduled_time` set). |
| **`users/{uid}/fcm_tokens`** | Token rows; `collectionGroup("fcm_tokens")` query by `fcm_token` in `addFcmToken` callable. |

---

## Composite indexes (`firebase/firestore.indexes.json`)

| Collection group | Fields (order / array) | Typical use |
|------------------|------------------------|-------------|
| `game` | `game_status` ASC, `game_ID` ASC | Filter active games by id |
| `game` | `game_status` ASC, `game_ID` DESC | Same, descending id |
| `room` | `room_status` ASC, `room_created_at` DESC | List rooms by status + recency |
| `notification` | `notification_status`, `to_userRef`, `notification_type`, `created_at` DESC | Inbox / typed notifications |
| `notification` | `notification_status`, `to_userRef`, `created_at` DESC | Shorter variant |
| `game_history` | `user_ref` ASC, `created_at` DESC | User history feed |
| `order` | `order_userRef` ASC, `created_at` DESC | User orders |
| `topic` | `topic_status` ASC, `game_ID` **array-contains** | Topics for a game id |
| `topic` | `topic_status` ASC, `game_ID` array-contains, `topic_main_id` ASC | Filter + sort |
| `point` | `point_status` ASC, `point_ID` DESC | Point packages listing |

**Field override:** `collectionGroup: fcm_tokens`, field `fcm_token` — supports collection-group lookup for duplicate token cleanup.

---

## Security rules summary (`firebase/firestore.rules`)

| Collection | Highlights |
|------------|------------|
| `users` | **Read: public (`true`)**. Create if `request.auth.uid == document`. Write if any authenticated user. Delete only own uid doc. |
| `IDmap`, `room`, `settings`, `payment_response` | **Read/write: very permissive** (`create/read/write: true` on several). Tighten for production. |
| Others | Generally read open, write/delete require `request.auth != null` (or similar). |

Treat rules as **documentation of current behavior**; a security review should revisit `IDmap` / `room` / `settings` / `payment_response`.

---

## Embedded structs (index)

Defined under `lib/backend/schema/structs/`. Commonly embedded:

- **`PresentRoomGameInfoStruct`** — on `users`: current room ref, selected game id, game admin flags, `roomGameId`, etc.
- **`SelectedGameListStruct`** — on `room.selected_game_list`: full in-room game lifecycle.
- **`RoomUserListStruct`** — on `room.room_user_list`: member refs, status, invite notification refs.
- **`MainInfoStruct`**, **`TranslateInfoStruct`**, **`RoomInfoStruct`**, **`ResultInfoStruct`**, **`GameSAUStruct`**, etc. — see `structs/index.dart` exports.

---

## Flutter ↔ Firestore mapping

| Dart | Location |
|------|----------|
| Query helpers | `lib/backend/backend.dart` |
| Record types | `lib/backend/schema/*_record.dart` |
| Struct types | `lib/backend/schema/structs/*.dart` |
| Barrel export | `lib/backend/schema/index.dart` |

---

## Maintenance checklist

1. After FlutterFlow export: diff `*_record.dart` field comments vs this file.  
2. After index changes in console: export indexes and merge into `firebase/firestore.indexes.json`.  
3. After rule changes: mirror summary in **Security rules summary** above.  
4. If new Cloud Function collections appear: add a row under **Collections used by Cloud Functions**.

---

*Last generated from repo snapshot (schema + firebase config). Not a live dump of document counts or optional fields present only in legacy data.*
