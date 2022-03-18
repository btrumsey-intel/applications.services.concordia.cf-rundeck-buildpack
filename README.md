# Cloud Foundry Rundeck Buildpack

This buildpack makes it easy to install [Rundeck](https://rundeck.com/downloads) on Cloud Foundry.

## Supported platforms

This buildpack is tested with Cloud Foundry 8.2.0.  **It only supports Rundeck versions 3.0.0 and beyond.**

## How to install

Use this repo as the buildpack when pushing your Cloud Foundry app.  It supplies Java 8 and the Rundeck version as
specified by the `RUNDECK_VERSION` environment variable.  It also supports installation of plugins.

Available versions of Rundeck can be found [here](https://rundeck.com/community-downloads).  It is important that you
specify the full version that includes the date of release. This can be found by looking at the filenames shown on the 
downloads page.  You should see filenames such as `rundeck-3.4.10.20220118-1.noarch.rpm`, in which case you would
specify `3.4.10-20220118` as your `RUNDECK_VERSION` environment variable (notice the '.' between the version and date
is replaced with a '-').

## How to use

Your Cloud Foundry Rundeck application should have the following directory structure:

```bash
├── etc
│   ├── admin.aclpolicy
│   ├── apitoken.aclpolicy
│   ├── framework.properties
│   ├── preferences.properties
│   ├── profile
│   ├── profile.bat
│   └── project.properties
├── server
│   └── config
│       ├── artifact-repositories.yaml
│       ├── jaas-loginmodule.conf
│       ├── log4j.conf
│       ├── realm.conf
│       ├── rundeck-config.properties
│       └── ssl.properties
├── ssl
│   └── ca.perm
└── rundeck-plugins.txt
```

Note that it does not contain the actual Rundeck application!  This will be downloaded and installed automatically as
part of the push.

#### Required files

The only required file is `server/config/rundeck-config.properties`, which must include at least this line

```
grails.serverUrl=https://yoururl.com
```

The value of `grails.serverUrl` should match the URL *users* would use to access Rundeck (i.e., the URL they would enter
into the browser).

### SSL

If you need to add an SSL certificate (this may be required for your database connector) as part of the push, place
the .pem file to `ssl/ca.pem`.  The certificate will be placed in the `/home/var/app/ssl/mysql_truststore` TrustStore.

### Plugins

To install plugins, put a link to the corresponding `.jar` file into `rundeck-plugins.txt`. The buildpack will download
and install them.

### Environment variables

The following environment variables can be passed with your `cf push` command to control certain aspects of the
buildpack.

| Environment Variable | Description                                                                                             |
| ---------------------|---------------------------------------------------------------------------------------------------------|
| RUNDECK_VER          | Version of Rundeck to install.  Note that this must be the version number followed by the release date. |
| RUNDECK_VERBOSE      | Adds a verbose switch to most commands to provide additional output during the build.                   |

### Sample manifest.yml file

The following file is a sample manifest.yml file that can be used with the `cf push` command.

```yaml
---
applications:
  - name: rundeck-app
    stack: cflinuxfs3
    buildpacks:
      - https://github.com/btrumsey-intel/applications.services.concordia.cf-rundeck-buildpack.git
    env:
      RUNDEC_VERSION: 3.4.10-20220118
```

## Credits

Credit to Springer Nature for their [cf-rundeck-buildpack](https://github.com/springernature/cf-rundeck-buildpack),
which served as the starting point for this buildpack.