package main

# Tableにdescriptionが存在するか
warn[msg] {
    table := input.tables[_]
    not table.actionDescriptor.description
    msg := sprintf("table %s should has description", [table.fileName])
}

# Tableに空文字でないdescriptionが書かれているか
warn[msg] {
    table := input.tables[_]
    table.actionDescriptor.description
    count(table.actionDescriptor.description) == 0
    msg := sprintf("table %s shoud have non empty description", [table.fileName])
}

# TableにBigQueryのLabelが存在するか
warn[msg] {
  table := input.tables[_]
  not table.bigquery.labels
  msg := sprintf("table %s should have BigQuery labels",[table.fileName])
}

# Tableに含まれるBigQueryのLabelの値に空文字のものが存在するか
warn[msg] {
  table := input.tables[_]
  some label; count(table.bigquery.labels[label]) == 0
  msg := sprintf("table %s should have nonempty value for BigQuery labels '%s'",[table.fileName, label])
}

# Tableに特定のLabelが付与されているか
warn[msg] {
  table := input.tables[_]
  table.bigquery.labels
  not table.bigquery.labels["managed_by"] == "dataform"
  msg := sprintf("table %s should have 'managed_by: dataform' label ",[table.fileName])
}

# 作成するTableにTagが付与される場合には,`hourly`,`daily`,`weekly`のいずれかのTagが含まれているか
valid_tags = {"hourly","daily","weekly"}
deny[msg] {
    table := input.tables[_]
    not count(cast_set(table.tags) & valid_tags) == 1
    msg := sprintf("table %s should have valid tag %s",[table.fileName, valid_tags])
}


deny[msg] {
  declaration := input.declarations[_]
  not declaration.actionDescriptor.description
  msg := sprintf("declaration %s should have description", [declaration.fileName])
}

deny[msg] {
    declaration := input.declarations[_]
    declaration.actionDescriptor.description
    count(declaration.actionDescriptor.description) == 0
    msg := sprintf("declaration %s shoud have non empty description", [declaration.fileName])
}
