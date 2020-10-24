package models

type Measurement struct {
	CreatedAt string `db:"hr_created_at" json:"created_at"`
	Minimum int `db:"minimum" json:"minimum"`
	Maximum int `db:"maximum" json:"maximum"`
	Median int `db:"median" json:"median"`
	Average int `db:"average" json:"average"`
}

