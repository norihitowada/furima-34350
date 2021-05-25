#テーブル設計

##users　テーブル

| Column             | Type      | Options          |
| -------------------| ----------| -----------------|
| nickname           | string    | unique: true     |
| email              | string    | unique: true     |
| password           | string    | null: false      |
| name_kanji_last    | string    | null: false      |
| name_kanji_first   | string    | null: false      |
| name_kana_last     | string    | null: false      |
| name_kana_first    | string    | null: false      |
| birthday           | datetime  | null: false      |


### Association

- has_many :items
- has_many :purchase_records
- has_many :addresses

##items　テーブル

| Column             | Type      | Options          |
| -------------------| ----------| -----------------|
| item_name          | string    | null: false      |
| explanation        | text      | null: false      |
| category           | text      | null: false      |
| condition          | text      | null: false      |
| delivery_cost      | text      | null: false      |
| days               | text      | null: false      |
| price              | integer   | null: false      |
| user_id            | reference | foreign_key: true|

### Association

- belongs_to :users
- has_one    :purchase_records
- has_one    :addresses

##purchase_records　テーブル

| Column             | Type      | Options          |
| -------------------| ----------| -----------------|
| user_id            | reference | foreign_key: true|
| item_id            | reference | foreign_key: true|


### Association

- belongs_to :users
- belongs_to :purchase_records
- has_one    :addresses

##addresses　テーブル

| Column             | Type      | Options          |
| -------------------| ----------| -----------------|
| zip_code           | string    | null: false         |
| prefecture         | text      | null: false         |
| street_number      | text      | null: false         |
| building           | text      | null: true          |
| phone_number       | string    | null: false         |

### Association

- belongs_to :users
- belongs_to :items
- belongs_to :purchase_records
