Inscriber
====
Inscriber is an automation tool for pulling localized data from your database and creating a YAML file for translations. In particular this should work very well with the [Globalize](https://github.com/globalize/globalize) gem and [Transifex](https://www.transifex.com) company.

Installation
---
```
gem install inscriber
```

Or if you are using rails
```
gem 'inscriber'
```

Configuration
---
Inscriber starts with a config YAML file `inscriber.yml`, example below:

```yaml
adapter: 'postgres'
host: 'localhost'
port: 5432
database_name: 'test'
source_lang: 'en'
output_dir: 'config/locales/'
input_dir: '.'
file_name: 'test.yml'
tables:
- name: 'test_header_translations'
  columns:
  - body
  - test_header_id
locales:
- fr
- jp 
```

- __adapter__ : supports `postgres`, `mysql`, & `sqlite`
- __host__ : host of the database, defaults to `127.0.0.1`
- __port__ : port of the database, defaults to `5432`
- __database_name__ : name of the database
- __source_lang__ : the language that will serve as your basis for translations, defaults to `en`
- __output_dir__ : the directory you want Inscriber to export the database data, defaults to `config/locales` for Rails
- __input_dir__ : the directory you want Inscriber to read the translated files, defaults to `config/locales` for Rails 
- __file_name__ : the name of the yml you want to save from the database (must have the `yml` extension)
- __tables__ : the names and columns of all data you want to be pulled from the database (include any required attributes in the column array)
- __locales__ : the locales you are going to translate to in Transifex (this must match up with Transifex)
 
### Setting the config path
Inscriber needs to know where to access the config path. By default this is set to `config/inscriber.yml`. If you chose to change this, you can export or set an `ENV` variable:
```bash
export INSCRIBER_CONFIG='/path/to/yml/file'
```

Usage
---
Inscriber was created for usage in small scripts or tasks.

### Exporting 
```
require 'inscriber'

Inscriber.export
```

### Inserting
```
require 'inscriber'

Inscriber.insert
```

Running Tests
---
Inscriber uses RSpec test framework `bundle exec rspec`

Authors
---
This project is maintained by [Ian Florentino](https://github.com/ianflorentino)

Credit
---
Inscriber was largely inspired and based off of [Txdb](https://github.com/lumoslabs/txdb) 
