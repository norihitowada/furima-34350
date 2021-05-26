
#テーブル設計

##users　テーブル

| Column             | Type      | Options                       |
| -------------------| ----------| ------------------------------|
| nickname           | string    | unique: true, null: false     |
| email              | string    | unique: true, null: false     |
| encrypted_password | string    | null: false                   |
| name_kanji_last    | string    | null: false                   |
| name_kanji_first   | string    | null: false                   |
| name_kana_last     | string    | null: false                   |
| name_kana_first    | string    | null: false                   |
| birthday           | date      | null: false                   |


### Association

- has_many :items
- has_many :purchase_records

##items テーブル

| Column             | Type      | Options          |
| -------------------| ----------| -----------------|
| name               | string    | null: false      |
| explanation        | text      | null: false      |
| category_id        | integer   | null: false      |
| condition_id       | integer   | null: false      |
| delivery_cost_id   | integer   | null: false      |
| ship_from_id       | integer   | null: false      |
| day_id             | integer   | null: false      |
| price              | integer   | null: false      |
| user               | reference | foreign_key: true|

### Association

- belongs_to :user
- has_one    :purchase_record

##purchase_records　テーブル

| Column             | Type      | Options          |
| -------------------| ----------| -----------------|
| user               | reference | foreign_key: true|
| item               | reference | foreign_key: true|


### Association

- belongs_to :user
- belongs_to :item
- has_one    :address

##addresses　テーブル

| Column             | Type      | Options             |
| -------------------| ----------| --------------------|
| zip_code           | string    | null: false         |
| prefecture_id      | integer   | null: false         |
| city               | string    | null: false         |
| street_number      | string    | null: false         |
| building           | string    | null: true          |
| phone_number       | string    | null: false         |

### Association


- belongs_to :purchase_record

