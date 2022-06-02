# Zero code

Zero Code Api is low code platform to expose mysql database as a Restful Api wih endpoints ready to use. This is an alternative to these tools strapi, nocodb, xmysql, dreamfactory, deployd.
Features

- Ready to use restful CRUD operations
- Swagger portal to play with endpoints
- Oauth2 security
- Admin Portal

# Variables:

|variable|sample value|description|
|--|--|--|
|MYSQL_PASSWORD| **** | used for mysql. Set your own values if you need
|ZERO_CODE_API_PORT| 2111 | zero code api port
|JWT_SECRET| **** | secret required by the api
|CRYPTO_KEY| **** | secret required by the api
|ZERO_CODE_UI_PORT| 2112 | zero code ui port
|ZERO_CODE_API_BASE_URL| http://localhost:2111 | zero code api base url. Also an http domain could be used. For local tests on one machine, use localhost instead of ip

# Run with docker - One click

The previous variables will be asked just the first time and will be saved in .env file. Next executions .env will be used.

```
bash one_click.sh
```

if a build is required after the first pull,


```
bash one_click.sh build=true
```

# Complex runs or configurations

More complex details in the [wiki](https://github.com/usil/zero-code/wiki)

# Projects

- https://github.com/usil/zero-code-api
- https://github.com/usil/zero-code-ui


# Contributors

<table>
  <tbody>
    <td>
      <img src="https://i.ibb.co/88Tp6n5/Recurso-7.png" width="100px;"/>
      <br />
      <label><a href="https://github.com/TacEtarip">Luis Huertas</a></label>
      <br />
    </td>
    <td>
      <img src="https://avatars0.githubusercontent.com/u/3322836?s=460&v=4" width="100px;"/>
      <br />
      <label><a href="http://jrichardsz.github.io/">JRichardsz</a></label>
      <br />
    </td>
  </tbody>
</table>
