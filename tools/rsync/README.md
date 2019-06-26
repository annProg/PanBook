# Drone ci plugin rsync

## rsyncd 安全设置

使用 `munge symlinks` 给 `symlinks` 加 `/rsyncd-munged/` 前缀，防止恶意 `symlinks` 链接系统文件

```
address = 172.17.0.1
hosts allow = 172.17.0.0/255.255.0.0 172.18.0.0/255.255.0.0
[ftp]
  path = /path
  read only = false
  include = *.pdf
  exclude = *.*
  munge symlinks = yes
```

## nginx 安全设置

禁止访问 `symlinks`：http://nginx.org/en/docs/http/ngx_http_core_module.html#disable_symlinks

```
Syntax:	disable_symlinks off;
disable_symlinks on | if_not_owner [from=part];
Default:	disable_symlinks off;
Context:	http, server, location
This directive appeared in version 1.1.15.
```

只允许访问 pdf 文件

```
  disable_symlinks on;

  location ~ ^/pub/.*.pdf {
    root /somepath;
  }
  location / {
    deny all;
  }
```