# dataform-conftest-example

## Setup

- install `dataform cli` <https://github.com/dataform-co/dataform#with-the-cli>
- install `conftest` <https://www.conftest.dev/install/>

## Compile

```bash
dataform compile example_project/ --json
```

## Run Test

```bash
dataform compile example_project/ --json  | conftest test -
```
